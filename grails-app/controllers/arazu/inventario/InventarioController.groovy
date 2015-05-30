package arazu.inventario

import arazu.items.Item
import arazu.parametros.EstadoSolicitud
import arazu.parametros.TipoDesecho
import arazu.parametros.TipoUsuario
import arazu.parametros.Unidad
import arazu.seguridad.Persona
import arazu.seguridad.Shield
import arazu.solicitudes.BodegaPedido
import arazu.solicitudes.Cotizacion
import arazu.solicitudes.Firma
import arazu.solicitudes.NotaPedido

class InventarioController extends Shield {

    def firmaService
    def notificacionService

    /**
     * Acción que carga con ajax las unidades disponibles para un item
     */
    def unidadesItem_ajax = {
        def item = Item.get(params.id)
        def unidadPadre = item.unidad
        def unidades = Unidad.findAllByPadre(unidadPadre)
        unidades += unidadPadre
        unidades = unidades.sort { it.descripcion }

        /*
         <g:select name="unidad.id" id="unidad" from="['': 'Seleccione el item']" optionKey="key" optionValue="value"
                              class="form-control input-sm select"/>
         */
        def select = g.select(name: "unidad.id", id: "unidad", from: unidades, optionKey: "id", class: "form-control input-sm")
        def js = "<script type='text/javascript'>"
        js += '$("#unidad").selectpicker();'
        js += "</script>"

        render select + js
    }

    /**
     * Acción que muestra la pantalla para hacer ingresos a una bodega
     */
    def ingresoDeBodega() {
        def usu = Persona.get(session.usuario.id)
        if (!usu.autorizacion) {
            flash.message = "Tiene que establecer una clave de autorización para poder firmar los documentos. " +
                    "<br/>Presione el botón 'Olvidé mi autorización' e ingrese su e-mail registrado para recibir una clave temporal que puede después modificar." +
                    "<br/>Si no tiene un e-mail registrado contáctese con un administrador del sistema."
            flash.tipo = "error"
            redirect(controller: "persona", action: "personal")
            return
        }

        def bodega = null
        def bodegas = []
        if (params.bodega) {
            bodega = Bodega.get(params.bodega)
            if (session.usuario.id != bodega.responsableId && session.usuario.id != bodega.suplenteId) {
                flash.message = "Solo el responsable de bodega puede realizar ingresos."
                response.sendError(403)
            } else {
                bodegas.add(bodega)
            }
        } else {
            bodegas = Bodega.findAllByResponsableOrSuplente(session.usuario, session.usuario)
        }

        if (bodegas.size() == 0) {
            flash.message = "No está asignado como responsable o suplente en ninguna bodega."
            response.sendError(403)
        }

        def items = Item.list([sort: "descripcion"])
        def itemStr = ""
        itemStr += items.collect { '"' + it.descripcion.trim() + '"' }

        //println "items "+itemStr
        return [bodegas: bodegas, bodega: bodega, items: itemStr]
    }

    /**
     * Acción que muestra la pantalla para hacer egresos de una bodega
     */
    def dlgEgresoDeBodega_ajax() {
//        println params
        def ingreso = Ingreso.get(params.id.toLong())
        ingreso.calcularSaldo()
        return [ingreso: ingreso]
    }

    /**
     * Acción que guarda los ingresos a una bodega
     */
    def saveIngreso_ajax() {
        def usu = Persona.get(session.usuario.id)
        def now = new Date()
//        println "save ingreso " + params
        def parts = params.data.split("\\|\\|")
//        println "parts " + parts
        parts.each {
            if (it != "") {
                def data = it.split("!!")
                def ingreso = new Ingreso()
                ingreso.bodega = Bodega.get(params.bodega)
//                ingreso.item = Item.findByDescripcion(data[0].toString().trim())
                ingreso.item = Item.get(data[0].toLong())
                ingreso.cantidad = data[1].toDouble()
                ingreso.unidad = Unidad.get(data[2])
                ingreso.valor = data[3].toDouble()
                ingreso.saldo = data[1].toDouble()
                if (!ingreso.save(flush: true)) {
                    println "error en el save de ingreso " + ingreso.errors
                    render "ERROR*" + renderErrors(bean: ingreso)
                } else {
                    def firma = new Firma()
                    firma.persona = usu
                    firma.fecha = now
                    firma.concepto = "Ingreso a bodega de ${ingreso.cantidad}${ingreso.unidad.codigo} ${ingreso.item} el " + new Date().format("dd-MM-yyyy HH:mm")
                    firma.pdfControlador = "reportesInventario"
                    firma.pdfAccion = "ingresoDeBodega"
                    firma.pdfId = ingreso.id

                    if (!firma.save(flush: true)) {
                        println "Error con la firma"
                        return "ERROR*Ha ocurrido un error al firmar la solicitud:" + renderErrors(bean: firma)
                    } else {
                        ingreso.ingresa = firma
                        if (!ingreso.save(flush: true)) {
                            println "Error al firmar el ingreso: " + ingreso.errors
                        } else {
                            def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort
                            def firmaRes = firmaService.firmarDocumento(usu.id, usu.autorizacion, firma, baseUri)
                            if (firmaRes instanceof String) {
                                render "ERROR*" + firmaRes
                                return
                            }
                        }
                    }
                }
            }
        }
        render "SUCCESS*Ingreso registrado exitosamente"
    }

    /**
     * Acción que muestra la pantalla de inventario de una bodega
     */
    def inventario() {
//        println "INVENTARIO     " + params
        def bodega = Bodega.get(params.id)
//        def ingresos = Ingreso.findAllByBodegaAndSaldoGreaterThan(bodega, 0)

        def desde = null
        def hasta = null
        if (params.search_desde) {
            desde = new Date().parse("dd-MM-yyyy", params.search_desde)
        }
        if (params.search_hasta) {
            hasta = new Date().parse("dd-MM-yyyy", params.search_hasta)
        }
        def c = Ingreso.createCriteria()
        def ingresos = c.list(params) {
            eq("bodega", bodega)
            gt("saldo", 0.toDouble())
            eq("desecho", 0)
            if (desde) {
                ge("fecha", desde)
            }
            if (hasta) {
                le("fecha", hasta)
            }
            if (params.search_item) {
                item {
                    ilike("descripcion", "%" + params.search_item + "%")
                }
            }
        }
        return [ingresos: ingresos, bodega: bodega, params: params]
    }

    /**
     * Acción que muestra la pantalla de inventario de desechos de una bodega
     */
    def inventarioDesecho() {
//        println "INVENTARIO     " + params
        def bodega = Bodega.get(params.id)
//        def ingresos = Ingreso.findAllByBodegaAndSaldoGreaterThan(bodega, 0)

        def desde = null
        def hasta = null
        if (params.search_desde) {
            desde = new Date().parse("dd-MM-yyyy", params.search_desde)
        }
        if (params.search_hasta) {
            hasta = new Date().parse("dd-MM-yyyy", params.search_hasta)
        }
        def c = Ingreso.createCriteria()
        def ingresos = c.list(params) {
            eq("bodega", bodega)
            gt("saldo", 0.toDouble())
            eq("desecho", 1)
            if (desde) {
                ge("fecha", desde)
            }
            if (hasta) {
                le("fecha", hasta)
            }
            if (params.search_item) {
                item {
                    ilike("descripcion", "%" + params.search_item + "%")
                }
            }
        }
        return [ingresos: ingresos, bodega: bodega, params: params]
    }

    /**
     * Acción que muestra la pantalla de inventario resumido (una fila por item/unidad) de una bodega
     */
    def inventarioResumen() {
//        println "INVENTARIO     " + params
        def bodega = Bodega.get(params.id)
//        def ingresos = Ingreso.findAllByBodegaAndSaldoGreaterThan(bodega, 0)

        def c = Ingreso.createCriteria()
        def ingresos = c.list(params) {
            eq("bodega", bodega)
            gt("saldo", 0.toDouble())
            eq("desecho", 0)
            if (params.search_item) {
                item {
                    ilike("descripcion", "%" + params.search_item + "%")
                }
            }
        }

        def res = [:]
        ingresos.each { ing ->
            if (!res[ing.item.id + "-" + ing.unidad.id]) {
                res[ing.item.id + "-" + ing.unidad.id] = [:]
                res[ing.item.id + "-" + ing.unidad.id].item = ing.item
                res[ing.item.id + "-" + ing.unidad.id].unidad = ing.unidad
                res[ing.item.id + "-" + ing.unidad.id].saldo = ing.saldo
            } else {
                res[ing.item.id + "-" + ing.unidad.id].saldo += ing.saldo
            }
        }

        return [ingresos: res, bodega: bodega, params: params]
    }

    /**
     * Acción que muestra la pantalla de inventario de desechos resumido (una fila por item/unidad) de una bodega
     */
    def inventarioDesechoResumen() {
//        println "INVENTARIO     " + params
        def bodega = Bodega.get(params.id)
//        def ingresos = Ingreso.findAllByBodegaAndSaldoGreaterThan(bodega, 0)

        def c = Ingreso.createCriteria()
        def ingresos = c.list(params) {
            eq("bodega", bodega)
            gt("saldo", 0.toDouble())
            eq("desecho", 1)
            if (params.search_item) {
                item {
                    ilike("descripcion", "%" + params.search_item + "%")
                }
            }
        }

        def res = [:]
        ingresos.each { ing ->
            if (!res[ing.item.id + "-" + ing.unidad.id]) {
                res[ing.item.id + "-" + ing.unidad.id] = [:]
                res[ing.item.id + "-" + ing.unidad.id].item = ing.item
                res[ing.item.id + "-" + ing.unidad.id].unidad = ing.unidad
                res[ing.item.id + "-" + ing.unidad.id].saldo = ing.saldo
            } else {
                res[ing.item.id + "-" + ing.unidad.id].saldo += ing.saldo
            }
        }

        return [ingresos: res, bodega: bodega, params: params]
    }

    /**
     * Acción llamada con ajax que muestra la pntalla de invetario resumido (una fila por item/unidad) de una bodega
     */
    def inventarioResumen_ajax() {
//        println "INVENTARIO     " + params
        def bodega = Bodega.get(params.id)
//        def ingresos = Ingreso.findAllByBodegaAndSaldoGreaterThan(bodega, 0)

        def c = Ingreso.createCriteria()
        def ingresos = c.list(params) {
            eq("bodega", bodega)
            gt("saldo", 0.toDouble())
            eq("desecho", 0)
        }

        def res = [:]
        ingresos.each { ing ->
            if (!res[ing.item.id + "-" + ing.unidad.id]) {
                res[ing.item.id + "-" + ing.unidad.id] = [:]
                res[ing.item.id + "-" + ing.unidad.id].item = ing.item
                res[ing.item.id + "-" + ing.unidad.id].unidad = ing.unidad
                res[ing.item.id + "-" + ing.unidad.id].saldo = ing.saldo
            } else {
                res[ing.item.id + "-" + ing.unidad.id].saldo += ing.saldo
            }
        }

        return [ingresos: res, bodega: bodega, params: params]
    }

    /**
     * Acción llamada con ajax que crea el ingreso de una nota de pedido
     */
    def ingresoNotaPedido_ajax() {
        def usu = Persona.get(session.usuario.id)
        def now = new Date()
        def pedido = NotaPedido.get(params.id)
        def bodega = Bodega.get(params.bodega)
        def estadoAprobado = EstadoSolicitud.findByCodigo("A01")
        def estadoCompletado = EstadoSolicitud.findByCodigo("C01")
        def cot = Cotizacion.findAllByPedidoAndEstadoSolicitud(pedido, estadoAprobado)
        if (cot.size() == 1) {
            cot = cot.first()

            def firma = new Firma()
            firma.persona = usu
            firma.fecha = now
//            firma.concepto = "Ingreso a bodega de ${ingreso.cantidad}${ingreso.unidad.codigo} ${ingreso.item}, nota de pedido ${pedido.numero} el " + new Date().format("dd-MM-yyyy HH:mm")
            firma.pdfControlador = "reportesInventario"
            firma.pdfAccion = "ingresoDeBodega"
//            firma.pdfId = ingreso.id
            firma.concepto = ""
            firma.pdfId = 0

            if (!firma.save(flush: true)) {
                println "Error con la firma"
                render "ERROR*Ha ocurrido un error al firmar la solicitud:" + renderErrors(bean: firma)
            } else {
                def ingreso = new Ingreso()
                ingreso.bodega = bodega
                ingreso.item = pedido.item
                ingreso.cantidad = pedido.cantidad
                ingreso.unidad = pedido.unidad
                ingreso.valor = cot.valor
                ingreso.pedido = pedido

                ingreso.ingresa = firma
                if (!ingreso.save(flush: true)) {
                    println "Error al firmar el ingreso: " + ingreso.errors
                    render "ERROR*Ha ocurrido un error al firmar el ingreso"
                } else {
                    ingreso.calcularSaldo()

                    firma.concepto = "Ingreso a bodega de ${ingreso.cantidad}${ingreso.unidad.codigo} ${ingreso.item}, nota de pedido ${pedido.codigo} el " + new Date().format("dd-MM-yyyy HH:mm")
                    firma.pdfId = ingreso.id
                    if (!firma.save(flush: true)) {
                        println "Error al vincular firma con ingreso: " + firma.errors
                    }

                    def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort
                    def firmaRes = firmaService.firmarDocumento(usu.id, usu.autorizacion, firma, baseUri)
                    if (firmaRes instanceof String) {
                        render "ERROR*" + firmaRes
                    } else {
                        pedido.estadoSolicitud = estadoCompletado
                        if (!pedido.save(flush: true)) {
                            render "ERROR*Ha ocurrido un error al completar la nota de pedido"
                        } else {
                            render "SUCCESS*Ingreso realizado exitosamente"
                        }
                    }
                }
            }
        } else {
            render "ERROR*No se encontró la cotización aprobada de la nota de pedido."
        }
    }

    /**
     * Acción llamada con ajax que carga un dialog para llenar la información necesaria para realizar un egreso de nota de pedido
     */
    def dlgEgreso_ajax() {
        def pedido = NotaPedido.get(params.id)
        def bodegasUsuario = Bodega.findAllByResponsableOrSuplente(session.usuario, session.usuario)
        def bp = BodegaPedido.findAllByPedidoAndBodegaInList(pedido, bodegasUsuario)
        def bodegasPedido = bp.findAll { it.cantidad - it.entregado > 0 }
        return [pedido: pedido, bodegas: bodegasPedido]
    }

    /**
     * Acción llamada con ajax que realiza un egreso de nota de pedido
     */
    def egreso_ajax() {
        def usu = session.usuario

        def pedido = NotaPedido.get(params.id)

        def bodegaPedido = BodegaPedido.get(params.bodega.toLong())
        def bodega = bodegaPedido.bodega

//        def ingreso = Ingreso.findAllByBodegaAndItem(bodega, pedido.item)
//        if (ingreso.size() == 0) {
//            render "ERROR*No se encontraron ingresos para el item ${pedido.item} en la bodega ${bodega}"
//        } else {
        def responsable = Persona.get(params.persona.toLong())
        def obs = params.observaciones?.toString()?.trim()
        def now = new Date()
        def msg = ""

        def egresos = Egreso.withCriteria {
            eq("pedido", pedido)
            ingreso {
                eq("bodega", bodega)
            }
            isNull("firma")
        }
        def mailGerentes = false
        def msgGerentes = ""
        egresos.each { eg ->
            eg.fecha = now
            eg.persona = responsable
            if (obs != "") {
                eg.observaciones = obs
            }
            def firma = new Firma()
            firma.persona = session.usuario
            firma.fecha = now
            firma.concepto = "Egreso de bodega de ${eg.cantidad}${pedido.unidad.codigo} ${pedido.item}, nota de pedido ${pedido.codigo} el " + new Date().format("dd-MM-yyyy HH:mm")
            firma.pdfControlador = "reportesInventario"
            firma.pdfAccion = "egresoDeBodega"
            firma.pdfId = eg.id

            if (!firma.save(flush: true)) {
                println "Error con la firma"
                render "ERROR*Ha ocurrido un error al firmar la solicitud:" + renderErrors(bean: firma)
                return
            } else {
                eg.firma = firma
                bodegaPedido.entregado += eg.cantidad
                if (!eg.save(flush: true)) {
                    msg += renderErrors(bean: eg)
                } else {
                    if (params.desecho == "ok") {
                        def firmaDesecho = new Firma()
                        firmaDesecho.persona = usu
                        firmaDesecho.fecha = now
                        firmaDesecho.concepto = ""
                        firmaDesecho.pdfControlador = "reportesInventario"
                        firmaDesecho.pdfAccion = "ingresoDeDesecho"
                        firmaDesecho.pdfId = 0

                        if (firmaDesecho.save(flush: true)) {
                            def ingresoDesecho = new Ingreso()
                            ingresoDesecho.unidad = eg.ingreso.unidad
                            ingresoDesecho.item = eg.ingreso.item
                            ingresoDesecho.bodega = eg.ingreso.bodega
                            ingresoDesecho.fecha = new Date()
                            ingresoDesecho.cantidad = eg.cantidad
                            ingresoDesecho.valor = 1
                            ingresoDesecho.saldo = eg.cantidad
                            ingresoDesecho.ingresa = firmaDesecho
                            ingresoDesecho.desecho = 1
                            ingresoDesecho.egreso = eg
                            if (ingresoDesecho.save(flush: true)) {
                                firmaDesecho.concepto = "Ingreso de desecho de ${eg.cantidad}${eg.ingreso.unidad.codigo} ${eg.ingreso.item} el " + new Date().format("dd-MM-yyyy HH:mm")
                                firmaDesecho.pdfId = ingresoDesecho.id
                                firmaDesecho.save(flush: true)
                                eg.ingresoDesecho = ingresoDesecho
                                eg.save(flush: true)
                            }
                        } else {
                            render "ERROR*" + renderErrors(bean: firmaDesecho)
                        }
                    } else {
                        mailGerentes = true
                        if (msgGerentes != "") {
                            msgGerentes += ", "
                        }
                        msgGerentes += "${eg.cantidad}${eg.ingreso.unidad.codigo} ${eg.ingreso.item}"
                    }
                }
            }
        }
        if (mailGerentes) {
            def tipoGerente = TipoUsuario.findByCodigo("GRNT")
            def gerentes = Persona.findAllByTipoUsuario(tipoGerente)
            def msgGrnt = ""

            def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort
            def mens = usu.nombre + " " + usu.apellido + " ha realizado un egreso de bodega de " + msgGerentes + " sin un ingreso de desecho"
            def paramsAlerta = [
                    mensaje    : mens,
                    controlador: "inventario",
                    accion     : "listaEgresosSinDesecho"
            ]
            def paramsMail = [
                    subject : "Egreso sin desecho",
                    template: '/mail/egresoSinDesecho',
                    model   : [
                            recibe : usu,
                            mensaje: mens,
                            now    : now,
                            link   : baseUri + createLink(controller: paramsAlerta.controlador, action: paramsAlerta.accion)
                    ]
            ]

            gerentes.each { grnt ->
                paramsMail.model.recibe = grnt
                msgGrnt += notificacionService.notificacionCompleta(usu, grnt, paramsAlerta, paramsMail)
            }
            if (msgGrnt == "") {
                render "SUCCESS*Egreso realizado exitosamente"
            } else {
                render "SUCCESS*Se realizó correctamente el egreso, pero " + msgGrnt
            }
        }
        if (!bodegaPedido.save(flush: true)) {
            println "error en bodega pedido: " + bodegaPedido.errors
        }
        if (msg == "") {
            render "SUCCESS*Se ha realizado el egreso exitosamente"
        } else {
            render "ERROR*Ha ocurrido un erro al realizar el egreso: " + msg
        }
//        }
    }

    /**
     * Acción llamada con ajax que realiza un egreso de bodega
     */
    def egresoBodega_ajax() {
        def usu = session.usuario
        def ingreso = Ingreso.get(params.id)
        def responsable = Persona.get(params.persona)
        def cant = params.cantidad.toDouble()
        def obs = params.observaciones?.toString()?.trim()
        def now = new Date()
        def msg = ""

//        def egreso = new Egreso()
//        egreso.ingreso = ingreso
//        egreso.persona = responsable
//        egreso.fecha = now
//        if (obs != "") {
//            egreso.observaciones = obs
//        }
//        egreso.cantidad = cant
//        if (egreso.save(flush: true)) {
        def firma = new Firma()
        firma.persona = usu
        firma.fecha = now
//        firma.concepto = "Egreso de bodega de ${egreso.cantidad}${ingreso.unidad.codigo} ${ingreso.item} el " + new Date().format("dd-MM-yyyy HH:mm")
        firma.concepto = ""
        firma.pdfControlador = "reportesInventario"
        firma.pdfAccion = "egresoDeBodega"
        firma.pdfId = 0
        if (firma.save(flush: true)) {
            def egreso = new Egreso()
            egreso.ingreso = ingreso
            egreso.persona = responsable
            egreso.fecha = now
            if (obs != "") {
                egreso.observaciones = obs
            }
            egreso.cantidad = cant
            egreso.firma = firma
            if (egreso.save(flush: true)) {
                firma.concepto = "Egreso de bodega de ${egreso.cantidad}${ingreso.unidad.codigo} ${ingreso.item} el " + now.format("dd-MM-yyyy HH:mm")
                firma.pdfId = egreso.id
            } else {
                println "error " + egreso.errors
                msg += renderErrors(bean: egreso)
            }
            ingreso.calcularSaldo()

            if (params.desecho == "ok") {
                def firmaDesecho = new Firma()
                firmaDesecho.persona = usu
                firmaDesecho.fecha = now
                firmaDesecho.concepto = ""
                firmaDesecho.pdfControlador = "reportesInventario"
                firmaDesecho.pdfAccion = "ingresoDeDesecho"
                firmaDesecho.pdfId = 0

                if (firmaDesecho.save(flush: true)) {
                    def ingresoDesecho = new Ingreso()
                    ingresoDesecho.unidad = ingreso.unidad
                    ingresoDesecho.item = ingreso.item
                    ingresoDesecho.bodega = ingreso.bodega
                    ingresoDesecho.fecha = new Date()
                    ingresoDesecho.cantidad = egreso.cantidad
                    ingresoDesecho.valor = 1
                    ingresoDesecho.saldo = egreso.cantidad
                    ingresoDesecho.ingresa = firmaDesecho
                    ingresoDesecho.desecho = 1
                    ingresoDesecho.egreso = egreso
                    if (ingresoDesecho.save(flush: true)) {
                        firmaDesecho.concepto = "Ingreso de desecho de ${egreso.cantidad}${ingreso.unidad.codigo} ${ingreso.item} el " + new Date().format("dd-MM-yyyy HH:mm")
                        firmaDesecho.pdfId = ingresoDesecho.id
                        firmaDesecho.save(flush: true)

                        egreso.ingresoDesecho = ingresoDesecho
                        egreso.save(flush: true)
                    }
                } else {
                    render "ERROR*" + renderErrors(bean: firmaDesecho)
                }
            } else {
                def tipoGerente = TipoUsuario.findByCodigo("GRNT")
                def gerentes = Persona.findAllByTipoUsuario(tipoGerente)
                def msgGrnt = ""

                def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort
                def mens = usu.nombre + " " + usu.apellido + " ha realizado un egreso de bodega de ${egreso.cantidad}${ingreso.unidad.codigo} ${ingreso.item} sin un ingreso de desecho"
                def paramsAlerta = [
                        mensaje    : mens,
                        controlador: "inventario",
                        accion     : "listaEgresosSinDesecho"
                ]
                def paramsMail = [
                        subject : "Egreso sin desecho",
                        template: '/mail/egresoSinDesecho',
                        model   : [
                                recibe : usu,
                                mensaje: mens,
                                now    : now,
                                link   : baseUri + createLink(controller: paramsAlerta.controlador, action: paramsAlerta.accion)
                        ]
                ]

                gerentes.each { grnt ->
                    paramsMail.model.recibe = grnt
                    msgGrnt += notificacionService.notificacionCompleta(usu, grnt, paramsAlerta, paramsMail)
                }
                if (msgGrnt == "") {
                    render "SUCCESS*Egreso realizado exitosamente"
                } else {
                    render "SUCCESS*Se realizó correctamente el egreso, pero " + msgGrnt
                }
            }

            if (msg == "") {
                render "SUCCESS*Egreso realizado exitosamente"
            } else {
                render "ERROR*" + msg
            }
        } else {
            println "error2 " + firma.errors
            msg += renderErrors(bean: firma)
            render "ERROR*" + msg
        }
//        } else {
//            println "error3 " + egreso.errors
//            msg += renderErrors(bean: egreso)
//        }
    }

    /**
     * Acción que muestra una pantalla que permite realizar búsquedas de ítems en una bodega para realizar un egreso
     */
    def egresoDeBodega() {

        def usu = Persona.get(session.usuario.id)
        if (!usu.autorizacion) {
            flash.message = "Tiene que establecer una clave de autorización para poder firmar los documentos. " +
                    "<br/>Presione el botón 'Olvidé mi autorización' e ingrese su e-mail registrado para recibir una clave temporal que puede después modificar." +
                    "<br/>Si no tiene un e-mail registrado contáctese con un administrador del sistema."
            flash.tipo = "error"
            redirect(controller: "persona", action: "personal")
            return
        }

        def bodega = null
        def bodegas = []
        if (params.bodega) {
            bodega = Bodega.get(params.bodega)
            if (session.usuario.id != bodega.responsableId && session.usuario.id != bodega.suplenteId) {
                flash.message = "Solo el responsable de bodega puede realizar egresos."
                response.sendError(403)
            } else {
                bodegas.add(bodega)
            }
        } else {
//            bodegas = Bodega.findAllByResponsableOrSuplente(session.usuario, session.usuario)
            bodegas = Bodega.withCriteria {
                and {
                    or {
                        eq("responsable", session.usuario)
                        eq("suplente", session.usuario)
                    }
                    if (params.search_bodega) {
                        ilike("descripcion", "%" + params.search_bodega.toString().trim() + "%")
                    }
                }
            }
//            if (params.search_bodega) {
//                println "******************** " + params.search_bodega
//                bodegas = bodegas.findAll { it.descripcion.toLowerCase().contains(params.search_bodega.toString().toLowerCase()) }
//            }
        }

        if (bodegas.size() == 0) {
            flash.message = "No está asignado como responsable o suplente en ninguna bodega."
            response.sendError(403)
        }

        def desde = null
        def hasta = null
        if (params.search_desde) {
            desde = new Date().parse("dd-MM-yyyy", params.search_desde)
        }
        if (params.search_hasta) {
            hasta = new Date().parse("dd-MM-yyyy", params.search_hasta)
        }
        def c = Ingreso.createCriteria()
        def ingresos = c.list(params) {
            inList("bodega", bodegas)
            gt("saldo", 0.toDouble())
            eq("desecho", 0)
            if (desde) {
                ge("fecha", desde)
            }
            if (hasta) {
                le("fecha", hasta)
            }
            if (params.search_item) {
                item {
                    ilike("descripcion", "%" + params.search_item + "%")
                }
            }
        }
        return [ingresos: ingresos, bodega: bodega, params: params, bodega: bodega]
    }

    def listaEgresosSinDesecho() {
        def egresos = Egreso.findAllByIngresoDesechoIsNull()
        return [egresos: egresos]
    }

    /**
     * Acción llamada con ajax que muestra el formulario para realizar un egreso de desecho de bodega
     */
    def desechar_ajax() {
        // ing.bodega.id + "-" + ing.item.id + "-" + ing.unidad.id + "-" + ing.desecho
        def bodega = null, item = null, unidad = null, ingresos = [], total = 0
        if (params.id) {
            def ids = params.id.split("-")
            bodega = Bodega.get(ids[0].toLong())
            item = Item.get(ids[1].toLong())
            unidad = Unidad.get(ids[2].toLong())

            ingresos = Ingreso.withCriteria {
                eq("bodega", bodega)
                eq("item", item)
                eq("unidad", unidad)
                eq("desecho", 1)
                gt("saldo", 0.toDouble())
            }
        }
        if (params.ingreso) {
            def ing = Ingreso.get(params.ingreso.toDouble())
            ingresos = [ing]
            bodega = ing.bodega
            item = ing.item
            unidad = ing.unidad
        }

        total = ingresos.sum { it.saldo }

        return [total: total, unidad: unidad, item: item, bodega: bodega]
    }

    /**
     * Acción llamada con ajax que realiza un egreso de desecho de bodega
     */
    def hacerDesecho_ajax() {
        def bodega = Bodega.get(params.bodega.toLong())
        def item = Item.get(params.item.toLong())
        def unidad = Unidad.get(params.unidad.toLong())

        def usu = session.usuario
        def now = new Date()

        def cantidad = params.cantidad.toDouble()
        def retirado = 0

        def ingresos = Ingreso.withCriteria {
            eq("bodega", bodega)
            eq("item", item)
            eq("unidad", unidad)
            eq("desecho", 1)
            gt("saldo", 0.toDouble())
        }

        def msg = ""

        ingresos.each { ing ->
            if (retirado < cantidad) {
                def cantRetirar
                def porRetirar = cantidad - retirado
                if (porRetirar < ing.saldo) {
                    cantRetirar = porRetirar
                } else {
                    cantRetirar = ing.saldo
                }

                def firma = new Firma()
                firma.persona = usu
                firma.fecha = now
                firma.concepto = ""
                firma.pdfControlador = "reportesInventario"
                firma.pdfAccion = "egresoDeBodegaDesecho"
                firma.pdfId = 0
                if (firma.save(flush: true)) {
                    def egreso = new Egreso()

                    egreso.ingreso = ing
                    egreso.fecha = now
                    egreso.observaciones = "Egreso de desecho"
                    egreso.responsable = params.responsable
                    egreso.cantidad = cantRetirar
                    egreso.firma = firma
                    egreso.tipoDesecho = TipoDesecho.get(params.tipoDesecho)
                    egreso.lugarDesecho = params.donde
                    if (params.precio) {
                        egreso.precioDesecho = params.precio.toDouble()
                    }
                    if (egreso.save(flush: true)) {
                        firma.concepto = "Egreso de bodega de de desecho ${egreso.cantidad}${ing.unidad.codigo} ${ing.item} el " + now.format("dd-MM-yyyy HH:mm")
                        firma.pdfId = egreso.id
                        retirado += cantRetirar
                    } else {
                        println "error " + egreso.errors
                        msg += renderErrors(bean: egreso)
                    }
                    ing.calcularSaldo()
                } else {
                    println "error2 " + firma.errors
                    msg += renderErrors(bean: firma)
                }
            }
        }
        if (msg == "") {
            render "SUCCESS*Desecho realizado exitosamente"
        }
        render "ERROR*" + msg
    }

}
