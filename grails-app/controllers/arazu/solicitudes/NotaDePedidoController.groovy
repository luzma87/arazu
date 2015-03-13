package arazu.solicitudes

import arazu.alertas.Alerta
import arazu.inventario.Bodega
import arazu.inventario.Egreso
import arazu.inventario.Ingreso
import arazu.items.Item
import arazu.items.Maquinaria
import arazu.parametros.EstadoSolicitud
import arazu.parametros.TipoUsuario
import arazu.parametros.Unidad
import arazu.seguridad.Perfil
import arazu.seguridad.Persona
import arazu.seguridad.Sesion
import arazu.seguridad.Shield

class NotaDePedidoController extends Shield {

    def mailService
    def firmaService
    def notificacionService

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista: de los elementos encontrados, strSearch: String con la descripción de la búsqueda realizada
     */
    def getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        def strSearch = ""
        def desde = null
        def hasta = null
        def de = null
        def maquina = null
        def item = null
        def estado = null
        if (params.search_desde) {
            desde = new Date().parse("dd-MM-yyyy", params.search_desde)
            strSearch += "desde el <strong>${params.search_desde}</strong>"
        }
        if (params.search_hasta) {
            hasta = new Date().parse("dd-MM-yyyy", params.search_hasta)
            if (strSearch != "") {
                strSearch += " "
            }
            strSearch += "hasta el <strong>${params.search_desde}</strong>"
        }
        if (!desde && !hasta) {
            strSearch += "en cualquier fecha"
        }
        if (params.search_de) {
            de = Persona.get(params.search_de.toLong())
            if (strSearch != "") {
                strSearch += ", "
            }
            strSearch += "solicitadas por <strong>" + de + "</strong>"
        } else {
            if (strSearch != "") {
                strSearch += ", "
            }
            strSearch += "por cualquier persona"
        }
        if (params.search_maquina) {
            maquina = Maquinaria.get(params.search_maquina.toLong())
            if (strSearch != "") {
                strSearch += ", "
            }
            strSearch += "para la maquinaria <strong>" + maquina + "</strong>"
        } else {
            if (strSearch != "") {
                strSearch += ", "
            }
            strSearch += "para cualquier maquinaria"
        }
        if (params.search_item) {
            item = Item.get(params.search_item.toLong())
            if (strSearch != "") {
                strSearch += ", "
            }
            strSearch += "solicitando <strong>" + item + "</strong>"
        } else {
            if (strSearch != "") {
                strSearch += ", "
            }
            strSearch += "solicitando culquier item"
        }
        if (params.search_estado) {
            estado = EstadoSolicitud.get(params.search_estado.toLong())
            if (strSearch != "") {
                strSearch += ", "
            }
            strSearch += "que estén en estado <strong>" + estado + "</strong>"
        } else {
            if (strSearch != "") {
                strSearch += ", "
            }
            strSearch += "que estén en cualquier estado"
        }
        if (!params.sort) {
            params.sort = "numero"
        }
        if (!params.order) {
            params.order = "asc"
        }
        def c = Pedido.createCriteria()
        list = c.list(params) {
            if (desde) {
                ge("fecha", desde)
            }
            if (hasta) {
                le("fecha", hasta)
            }
            if (de) {
                eq("de", de)
            }
            if (maquina) {
                eq('maquina', maquina)
            }
            if (item) {
                eq("item", item)
            }
            if (estado) {
                eq("estadoSolicitud", estado)
            }
        }
        strSearch = "Mostrando las notas de pedido realizadas " + strSearch
        return [list: list, strSearch: strSearch]
    }

    /**
     * Acción que muestra la pantalla de ingreso de una nueva nota de pedido
     */
    def pedido() {
        def numero = Pedido.list([sort: "numero", order: "desc", limit: 1])
        if (numero.size() > 0)
            numero = numero.first().numero + 1
        else
            numero = 1
        def items = Item.list([sort: "descripcion"])
        def itemStr = ""
        itemStr += items.collect { '"' + it.descripcion.trim() + '"' }

        def jefes = Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo("JEFE"), [sort: 'apellido'])

        return [numero: numero, items: itemStr, jefes: jefes]
    }

    /**
     * Acción que guarda la nota de pedido, genera la firma del solicitante y envía una alerta y un email al jefe destinatario
     */
    def saveSolicitud() {
//        println "Save solicitud " + params

        def now = new Date()
        def usu = Persona.get(session.usuario.id)

//        def item = Item.findByDescripcion(params.item.trim())
//        params.remove("item")
//        params["item.id"] = item.id

        def numero = Pedido.list([sort: "numero", order: "desc", limit: 1])
        if (numero.size() > 0)
            numero = numero.first().numero + 1
        else
            numero = 1

        def solicitud = new Pedido(params)
        solicitud.estadoSolicitud = EstadoSolicitud.findByCodigo("E01")
        solicitud.fecha = now
        solicitud.de = usu
        solicitud.numero = numero
        solicitud.codigo = "NP-" + numero
        if (!solicitud.save(flush: true)) {
            println "error  " + solicitud.errors
            flash.tipo = "error"
            flash.message = "Ha ocurrido un error al guardar la solicitud:" + renderErrors(bean: solicitud)
            redirect(action: "pedido")
        } else {

            def firma = new Firma()
            firma.persona = usu
            firma.fecha = now
            firma.concepto = "Nota de pedido núm. ${solicitud.numero} de " + usu.nombre + " " + usu.apellido + " " + now.format("dd-MM-yyyy HH:mm")
            firma.pdfControlador = "reportesInventario"
            firma.pdfAccion = "notaDePedido"
            firma.pdfId = solicitud.id

            if (!firma.save(flush: true)) {
                println "Error con la firma"
                flash.tipo = "error"
                flash.message = "Ha ocurrido un error al firmar la solicitud:" + renderErrors(bean: firma)
                redirect(action: "pedido")
            } else {
                solicitud.firmaSolicita = firma
                if (!solicitud.save(flush: true)) {
                    println "Error al guardar firma en solicitud " + solicitud.errors
                }

                def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort
                def firmaRes = firmaService.firmarDocumento(usu.id, usu.autorizacion, firma, baseUri)
                if (firmaRes instanceof String) {
                    flash.tipo = "error"
                    flash.message = firmaRes
                    redirect(action: "pedido")
                } else {
                    def mens = usu.nombre + " " + usu.apellido + " ha realizado la nota de pedido núm. ${solicitud.numero}"
                    def paramsAlerta = [
                            mensaje    : mens,
                            controlador: "notaDePedido",
                            accion     : "listaJefatura"
                    ]
                    def paramsMail = [
                            subject : "Nueva nota de pedido",
                            template: '/mail/notaPedido',
                            model   : [
                                    recibe : solicitud.para,
                                    mensaje: mens,
                                    now    : now,
                                    link   : baseUri + createLink(controller: paramsAlerta.controlador, action: paramsAlerta.accion)
                            ]
                    ]
                    def msg = notificacionService.notificacionCompleta(usu, solicitud.para, paramsAlerta, paramsMail)

                    def perf = Perfil.findByCodigo("JEFE")
                    def personas = Sesion.withCriteria {
                        eq("perfil", perf)
                        usuario {
                            ne("id", solicitud.para.id)
                            eq("activo", 1)
                        }
                        projections {
                            distinct("usuario")
                        }
                    }
                    personas.each { pers ->
                        msg += notificacionService.notificacionCompleta(usu, pers, paramsAlerta, paramsMail)
                    }

                    flash.tipo = "success"
                    flash.message = "La solicitud <strong>número ${numero}</strong> ha sido enviada exitosamente"
                    if (msg != "") {
                        flash.message += "<ul>" + msg + "</ul>"
                    }
                    redirect(action: "lista")
                }
            }
        }
    }

    /**
     * Acción que muestra la lista de notas de pedido efectuadas por elusuario
     */
    def lista() {
        def r1 = getList(params, false)
        def strSearch = r1.strSearch
        def notas = r1.list
        def notasCount = getList(params, true).list.size()
        return [notas: notas, notasCount: notasCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de notas de pedido que un jefe debe autorizar
     */
    def listaJefatura() {
        if (session.perfil.codigo != "JEFE") {
            response.sendError(403)
        }
        def estadoPendienteRevision = EstadoSolicitud.findByCodigo("E01")
        params.search_estado = estadoPendienteRevision.id
        def r1 = getList(params, false)
        def strSearch = r1.strSearch
        def notas = r1.list
        def notasCount = getList(params, true).list.size()
        return [notas: notas, notasCount: notasCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de notas de pedido para que un jefe de compras les asigne un asistente de compras
     */
    def listaJefeCompras() {
        if (session.perfil.codigo != "JFCM") {
            response.sendError(403)
        }
        def estadoPendienteAsignacion = EstadoSolicitud.findByCodigo("E02")
        params.search_estado = estadoPendienteAsignacion.id
        def r1 = getList(params, false)
        def strSearch = r1.strSearch
        def notas = r1.list
        def notasCount = getList(params, true).list.size()
        return [notas: notas, notasCount: notasCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de notas de pedido para que un asistente de compras les asigne cotizaciones
     */
    def listaAsistenteCompras() {
        println ">>> " + session.perfil + "    " + session.perfil.codigo
        if (session.perfil.codigo != "ASCM") {
            response.sendError(403)
        }
        def estadoPendientesCotizaciones = EstadoSolicitud.findByCodigo("E03")
        params.search_estado = estadoPendientesCotizaciones.id
        def r1 = getList(params, false)
        def strSearch = r1.strSearch
        def notas = r1.list
        def notasCount = getList(params, true).list.size()
        return [notas: notas, notasCount: notasCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de notas de pedido para que un jefe haga la aprobación final
     */
    def listaJefe() {
        if (session.perfil.codigo != "JEFE") {
            response.sendError(403)
        }
        def estadoPendientesAprobacionFinal = EstadoSolicitud.findByCodigo("E04")
        params.search_estado = estadoPendientesAprobacionFinal.id
        def r1 = getList(params, false)
        def strSearch = r1.strSearch
        def notas = r1.list
        def notasCount = getList(params, true).list.size()
        return [notas: notas, notasCount: notasCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de notas de pedido para que un gerente haga la aprobación final
     */
    def listaGerente() {
        if (session.perfil.codigo != "GRNT") {
            response.sendError(403)
        }
        def estadoPendientesAprobacionFinal = EstadoSolicitud.findByCodigo("E04")
        params.search_estado = estadoPendientesAprobacionFinal.id
        def r1 = getList(params, false)
        def strSearch = r1.strSearch
        def notas = r1.list
        def notasCount = getList(params, true).list.size()
        return [notas: notas, notasCount: notasCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de notas de pedido que existen en la bodega del usuario
     */
    def listaBodega() {
        if (session.perfil.codigo != "RSBD") {
            response.sendError(403)
        }
        def estadoBodega = EstadoSolicitud.findByCodigo("B01")

        def usu = Persona.get(session.usuario.id)
        def bodegasUsu = Bodega.findAllByResponsableOrSuplente(usu, usu)

        def notas = BodegaPedido.withCriteria {
            inList("bodega", bodegasUsu)
            pedido {
                order("fecha", "asc")
            }
        }.pedido.unique()

//        def notas = Pedido.findAllByEstadoSolicitud(estadoPendientesCotizaciones, [sort: "numero"])
        return [notas: notas]
    }

    /**
     * Acción que muestra la lista de notas de pedido aprobadas y permite a los responsables de bodega generar un ingreso
     */
    def listaAprobadas() {
        def estadoAprobada = EstadoSolicitud.findByCodigo("A01")
        params.search_estado = estadoAprobada.id
        if (!params.sort) {
            params.sort = "prioridad"
        }
        if (!params.order) {
            params.ordeer = "asc"
        }
        def r1 = getList(params, false)
        def strSearch = r1.strSearch
        def notas = r1.list
        def notasCount = getList(params, true).list.size()
        return [notas: notas, notasCount: notasCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que le permite a un jefe revisar una nota de pedido, verificar las existencias en bodegas
     * y aprobar/negar/informar existe en bodegas
     */
    def revisarJefatura() {
        if (!params.id)
            response.sendError(404)
        def nota = Pedido.get(params.id)
        if (session.perfil.codigo != "JEFE") {
            response.sendError(403)
        }
        if (nota.estadoSolicitud.codigo != "E01") {
            response.sendError(403)
        }
        def existencias = [:]
        Ingreso.findAllByItemAndSaldoGreaterThan(nota.item, 0).each { ing ->
            ing.calcularSaldo()
            if (!existencias[ing.bodegaId + "_" + ing.unidadId]) {
                existencias[ing.bodegaId + "_" + ing.unidadId] = [bodega: ing.bodega,
                                                                  unidad: ing.unidad,
                                                                  total : 0]
            }
            existencias[ing.bodegaId + "_" + ing.unidadId]["total"] += ing.saldo
        }
        return [nota: nota, existencias: existencias]
    }

    /**
     * Acción que le permite a un jefe de compras revisar una nota de pedido, verificar las existencias en bodegas
     * y aprobar/negar/informar existe en bodegas
     */
    def revisarJefeCompras() {
        if (!params.id)
            response.sendError(404)
        def nota = Pedido.get(params.id)
        if (session.perfil.codigo != "JFCM") {
            response.sendError(403)
        }
        if (nota.estadoSolicitud.codigo != "E02") {
            response.sendError(403)
        }
        def existencias = [:]
        Ingreso.findAllByItemAndSaldoGreaterThan(nota.item, 0).each { ing ->
            if (!existencias[ing.bodegaId + "_" + ing.unidadId]) {
                existencias[ing.bodegaId + "_" + ing.unidadId] = [bodega: ing.bodega,
                                                                  unidad: ing.unidad,
                                                                  total : 0]
            }
            existencias[ing.bodegaId + "_" + ing.unidadId]["total"] += ing.saldo
        }
        def locked = Egreso.findAllByPedidoAndFirmaIsNull(nota)
        return [nota: nota, existencias: existencias, locked: locked]
    }

    /**
     * Acción que le permite a un asistente de compras revisar una nota de pedido, verificar las existencias en bodegas
     * y aprobar/negar/informar existe en bodegas y asignar cotizaciones
     */
    def revisarAsistenteCompras() {
        if (!params.id)
            response.sendError(404)
        def nota = Pedido.get(params.id)
        if (session.perfil.codigo != "ASCM") {
            response.sendError(403)
        }
        if (nota.estadoSolicitud.codigo != "E03") {
            response.sendError(403)
        }
        def existencias = [:]
        Ingreso.findAllByItemAndSaldoGreaterThan(nota.item, 0).each { ing ->
            if (!existencias[ing.bodegaId + "_" + ing.unidadId]) {
                existencias[ing.bodegaId + "_" + ing.unidadId] = [bodega: ing.bodega,
                                                                  unidad: ing.unidad,
                                                                  total : 0]
            }
            existencias[ing.bodegaId + "_" + ing.unidadId]["total"] += ing.saldo
        }
        def cots = Cotizacion.findAllByPedido(nota, [sort: "id"])
        def locked = Egreso.findAllByPedidoAndFirmaIsNull(nota)
        return [nota: nota, existencias: existencias, cots: cots, locked: locked]
    }

    /**
     * Acción que le permite a un jefe revisar una nota de pedido, verificar las existencias en bodegas
     * y aprobar/negar/informar existe en bodegas FINAL
     */
    def revisarJefe() {
        if (!params.id)
            response.sendError(404)
        def nota = Pedido.get(params.id)
        if (session.perfil.codigo != "JEFE") {
            response.sendError(403)
        }
        if (nota.estadoSolicitud.codigo != "E04") {
            response.sendError(403)
        }
        def existencias = [:]
        Ingreso.findAllByItemAndSaldoGreaterThan(nota.item, 0).each { ing ->
            if (!existencias[ing.bodegaId + "_" + ing.unidadId]) {
                existencias[ing.bodegaId + "_" + ing.unidadId] = [bodega: ing.bodega,
                                                                  unidad: ing.unidad,
                                                                  total : 0]
            }
            existencias[ing.bodegaId + "_" + ing.unidadId]["total"] += ing.saldo
        }
        def cots = Cotizacion.findAllByPedido(nota, [sort: "id"])
        def locked = Egreso.findAllByPedidoAndFirmaIsNull(nota)
        return [nota: nota, existencias: existencias, cots: cots, locked: locked]
    }

    /**
     * Acción que le permite a un gerente revisar una nota de pedido, verificar las existencias en bodegas
     * y aprobar/negar/informar existe en bodegas FINAL
     */
    def revisarGerente() {
        if (!params.id)
            response.sendError(404)
        def nota = Pedido.get(params.id)
        if (session.perfil.codigo != "GRNT") {
            response.sendError(403)
        }
        if (nota.estadoSolicitud.codigo != "E04") {
            response.sendError(403)
        }
        def existencias = [:]
        Ingreso.findAllByItemAndSaldoGreaterThan(nota.item, 0).each { ing ->
            if (!existencias[ing.bodegaId + "_" + ing.unidadId]) {
                existencias[ing.bodegaId + "_" + ing.unidadId] = [bodega: ing.bodega,
                                                                  unidad: ing.unidad,
                                                                  total : 0]
            }
            existencias[ing.bodegaId + "_" + ing.unidadId]["total"] += ing.saldo
        }
        def cots = Cotizacion.findAllByPedido(nota, [sort: "id"])
        def locked = Egreso.findAllByPedidoAndFirmaIsNull(nota)
        return [nota: nota, existencias: existencias, cots: cots, locked: locked]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para aprobar una nota de pedido
     */
    def dlgAprobarJefe_ajax() {
        def nota = Pedido.get(params.id)
        def jefesCompras = Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo("JFCM"), [sort: 'apellido'])
        return [nota: nota, jefesCompras: jefesCompras]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para aprobar una nota de pedido
     */
    def dlgAprobarJefeCompras_ajax() {
        def nota = Pedido.get(params.id)
        def asistentesCompras = Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo("ASCM"), [sort: 'apellido'])
        return [nota: nota, asistentesCompras: asistentesCompras]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para aprobar una nota de pedido
     */
    def dlgAprobarAsistenteCompras_ajax() {
        def nota = Pedido.get(params.id)
        def jefes = null, gerentes = null

        def total = []
        def cots = Cotizacion.findAllByPedido(nota, [sort: "id"])
        def max = 0
        cots.eachWithIndex { c, i ->
            def m = c.valor * nota.cantidad
            total[i] = m
            if (m > max) {
                max = m
            }
        }

        if (max < 100) {
            jefes = Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo("JEFE"), [sort: 'apellido'])
        } else {
            gerentes = Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo("GRNT"), [sort: 'apellido'])
        }

        return [nota: nota, jefes: jefes, gerentes: gerentes]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para aprobar una nota de pedido
     */
    def dlgAprobarFinal_ajax() {
        def nota = Pedido.get(params.id)
        def cots = Cotizacion.findAllByPedido(nota)
        return [nota: nota, cots: cots]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para negar una nota de pedido
     */
    def dlgNegar_ajax() {
        def nota = Pedido.get(params.id)
        return [nota: nota]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para negar definitivamente una nota de pedido
     */
    def dlgNegarFinal_ajax() {
        def nota = Pedido.get(params.id)
        return [nota: nota]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para notificar que el item de una nota de pedido está disponible en bodegas y seleccionar de cual se dese sacar para notificar al responsable de bodega
     */
    def dlgBodega_ajax() {
        def nota = Pedido.get(params.id)
        def existencias = [:]
        Ingreso.findAllByItemAndSaldoGreaterThan(nota.item, 0).each { ing ->
            if (!existencias[ing.bodegaId + "_" + ing.unidadId]) {
                existencias[ing.bodegaId + "_" + ing.unidadId] = [bodega: ing.bodega,
                                                                  unidad: ing.unidad,
                                                                  total : 0]
            }
            existencias[ing.bodegaId + "_" + ing.unidadId]["total"] += ing.saldo
        }
        def jefesCompras = Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo("JFCM"), [sort: 'apellido'])
        return [nota: nota, existencias: existencias, jefesCompras: jefesCompras]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para hacer el ingreso de una nota de pedido a una bodega
     */
    def dlgIngresoBodega_ajax() {
        def nota = Pedido.get(params.id)
        def usu = Persona.get(session.usuario.id)
        def bodegas = Bodega.findAllByResponsableOrSuplente(usu, usu, [sort: 'descripcion'])
        return [nota: nota, bodegas: bodegas]
    }

    /**
     * Acción que guarda la aprobación de una nota de pedido por parte de un jefe, y envía una alerta y un email al jefe de compras destinatario y al que realizó el pedido
     */
    def aprobarJefatura_ajax() {
        render cambiarEstadoPedido(params, "AJF")
    }

    /**
     * Acción que guarda la aprobación de una nota de pedido por parte de un jefe, y envía una alerta y un email al asistente de compras destinatario y al que realizó el pedido
     */
    def aprobarJefeCompras_ajax() {
        render cambiarEstadoPedido(params, "AJC")
    }

    /**
     * Acción que guarda la aprobación de la nota de pedido con las cotizaciones ingresadas para una nota de pedido por un asistente de compras  y envía una alerta y un email al jefe o gerente de compras destinatario y al que realizó el pedido
     */
    def aprobarAsistenteCompras_ajax() {
        render cambiarEstadoPedido(params, "AAC")
    }

    /**
     * Acción que guarda laaprobación final de una nota de pedido por un asistente de compras  y envía una alerta y un email al que realizó el pedido
     */
    def aprobarFinal_ajax() {
        render cambiarEstadoPedido(params, "AF")
    }

    /**
     * Acción que guarda la negación de una nota de pedido por parte de un jefe, y envía una alerta y un email al que realizó el pedido
     */
    def negarJefatura_ajax() {
        render cambiarEstadoPedido(params, "NJF")
    }

    /**
     * Acción que guarda la negación de una nota de pedido por parte de un jefe, y envía una alerta y un email al que realizó el pedido
     */
    def negarJefeCompras_ajax() {
        render cambiarEstadoPedido(params, "NJC")
    }

    /**
     * Acción que guarda la negación de una nota de pedido por parte de un asistente de compras, y envía una alerta y un email al que realizó el pedido
     */
    def negarAsistenteCompras_ajax() {
        render cambiarEstadoPedido(params, "NAC")
    }

    /**
     * Acción que guarda la negación final de una nota de pedido por parte de un asistente de compras, y envía una alerta y un email al que realizó el pedido
     */
    def negarFinal_ajax() {
        render cambiarEstadoPedido(params, "NF")
    }

    /**
     * Acción que guarda la información de las bodegas seleccionadas cuando un jefe notifica que una nota de pedido está disponible en bodegas. Envía una alerta y un email al que realizó el pedido y a los reponsables de bodega correspondientes
     */
    def bodegaJefatura_ajax() {
        render cambiarEstadoPedido(params, "BJF")
    }

    /**
     * Acción que guarda la información de las bodegas seleccionadas cuando un jefe notifica que una nota de pedido está disponible en bodegas. Envía una alerta y un email al que realizó el pedido y a los reponsables de bodega correspondientes
     */
    def bodegaJefeCompras_ajax() {
        render cambiarEstadoPedido(params, "BJC")
    }

    /**
     * Acción que guarda la información de las bodegas seleccionadas cuando un asistente de compras notifica que una nota de pedido está disponible en bodegas. Envía una alerta y un email al que realizó el pedido y a los reponsables de bodega correspondientes
     */
    def bodegaAsistenteCompras_ajax() {
        render cambiarEstadoPedido(params, "BAC")
    }

    /**
     * Acción que guarda la información de las bodegas seleccionadas cuando un asistente de compras notifica que una nota de pedido está disponible en bodegas. Envía una alerta y un email al que realizó el pedido y a los reponsables de bodega correspondientes
     */
    def bodegaFinal_ajax() {
        render cambiarEstadoPedido(params, "BF")
    }

    /**
     * Acción que guarda una cotización y vuelve a cargar la pantalla de revisión de asistente de compras
     */
    def saveCotizacion() {
        println "save cotizacion " + params
        def cotizacion
        if (params.id) {
            cotizacion = Cotizacion.get(params.id)
            cotizacion.properties = params
        } else {
            cotizacion = new Cotizacion(params)
        }
        cotizacion.fecha = new Date()
        cotizacion.estadoSolicitud = EstadoSolicitud.findByCodigo("E01")
        if (!cotizacion.save(flush: true)) {
            flash.message = renderErrors(bean: cotizacion)
        }
        redirect(action: "revisarAsistenteCompras", id: params.pedido.id)
    }

    /**
     * Función que hace los objetos bodegaPedido y los egresos en estado pendiente
     * @param pedido el pedido que genera los movimientos de bodega
     * @param params los parametros que indican las bodegas y la cantidad a retirar de cada una
     * @return un arreglo con los responsables de las bodegas respecitivas
     */
    def bodega(Pedido pedido, params) {
        def now = new Date()
        def notificacionBodegas = []

        params.each { k, v ->
            if (k.toString().startsWith("ret")) {
                def parts = k.split("_")
                def bodega = Bodega.get(parts[1].toLong())
                def cantidad = v.toDouble()
                def tot = 0

                notificacionBodegas += bodega.responsable
                notificacionBodegas += bodega.suplente
                def bp = new BodegaPedido()
                bp.bodega = bodega
                bp.pedido = pedido
                bp.cantidad = cantidad
                bp.save()
//                def ingresos = Ingreso.findAllByItemAndSaldoGreaterThan(pedido.item, 0.toDouble())
                def ingresos = Ingreso.withCriteria {
                    eq("item", pedido.item)
                    gt("saldo", 0.toDouble())
                    eq("bodega", bodega)
                }
                ingresos.each { ing ->
                    if (tot < cantidad) {
                        ing.calcularSaldo()
                        def c
                        if (ing.saldo >= (cantidad - tot)) {
                            c = (cantidad - tot)
                        } else {
                            c = ing.saldo
                        }
                        tot += c
                        def egreso = new Egreso()
                        egreso.ingreso = ing
                        egreso.pedido = pedido
                        egreso.fecha = now
                        egreso.cantidad = c
                        if (egreso.save()) {
                            ing.calcularSaldo()
                        } else {
                            println "ERROR*Ha ocurrido un error al generar el egreso"
                        }
                    }
                }
            }
        }
        return notificacionBodegas
    }

    /**
     * Función que cambia de estado un pedido y envía las notificaciones necesarias
     * @param params los parámetros que llegan del cliente
     * @param tipo tipo de cambio de estado a efectuarse:
     *              AJF: el jefe aprueba la solicitud
     *              NJF: el jefe niega la solicitud
     *              BJF: el jefe indica de q bodega(s) sacar
     *
     *              AJC: el jefe de compras aprueba la solicitud
     *              NJC: el jefe de compras niega la solicitud
     *              BJC: el jefe de compras indica de q bodega(s) sacar
     *
     *              AJC: el asistente de compras aprueba la solicitud y envía las cotizaciones
     *              NJC: el asistente de compras niega la solicitud
     *              BJC: el asistente de compras indica de q bodega(s) sacar
     *
     *              AF: el jefe/gerente aprueba definitivamente la solicitud
     *              NF: el jefe/gerente niega definitivamente la solicitud
     *              BF: el jefe/gerente indica de q bodega(s) sacar
     * @return String con los mensajes de error si ocurrieron
     */
    private String cambiarEstadoPedido(params, String tipo) {
        String codEstadoInicial = ""
        EstadoSolicitud estadoFinal = null
        String concepto = "", mensTipo = "", retTipo = "", retTipo2 = ""
        String firmaPedido = ""
        String accionAlerta = ""
        def notificacion1Recibe = null
        def notificacion2Recibe = null
        def notificacionBodegas = []
        def perfilNotificacionesExtra = null
        String mensajeAprobacionFinal = ""

        def para = null
        def usu = Persona.get(session.usuario.id)
        if (params.para) {
            para = Persona.get(params.para.toLong())
        }
        def pedido = Pedido.get(params.id.toLong())

        if (!params.cant) {
            params.cant = 0
        } else {
            params.cant = params.cant.toDouble()
        }
        def str = ""
        if (params.cant > 0) {
            str = " (" + params.cant + " " + pedido.unidad.codigo + ")"
        }

        if (params.auth.toString().encodeAsMD5() == usu.autorizacion) {
            switch (tipo) {
                case "AJF": // el jefe aprueba la solicitud
                    codEstadoInicial = "E01"
                    estadoFinal = EstadoSolicitud.findByCodigo("E02") //estado Pendiente Asignacion
                    concepto = "Aprobación"
                    mensTipo = "aprobado"
                    retTipo = "ha sido aprobada"
                    retTipo2 = "aprobarla"
                    firmaPedido = "firmaJefe"
                    accionAlerta = "listaJefeCompras"

                    notificacion1Recibe = para
                    notificacion2Recibe = pedido.de

                    pedido.paraJC = para

                    if (str != "") {
                        concepto += str
                        mensTipo += str
                        retTipo += str
                    }

                    perfilNotificacionesExtra = "JFCM"
                    break;
                case "NJF": // el jefe niega la solicitud
                    codEstadoInicial = "E01"
                    estadoFinal = EstadoSolicitud.findByCodigo("N01") //estado Negado
                    concepto = "Negación"
                    mensTipo = "negado"
                    retTipo = "ha sido negada"
                    retTipo2 = "negarla"
                    firmaPedido = "firmaNiega"
                    accionAlerta = "lista"

                    notificacion1Recibe = pedido.de
                    break;
                case "BJF": // el jefe indica de q bodega(s) sacar
                    notificacionBodegas = bodega(pedido, params)

                    codEstadoInicial = "E01"
                    if (params.cant != 0) {
                        estadoFinal = EstadoSolicitud.findByCodigo("E02") //estado Pendiente Asignacion
                        concepto = "Notificación de existencia en bodega y aprobación parcial"
                        mensTipo = "notificado que existe en bodega y aprobado parcialmente (${params.cant} de ${pedido.cantidad})"
                        retTipo = "ha sido notificada que existe en bodega y aprobado parcialmente"
                        retTipo2 = "notificar que existe en bodega y aprobar parcialmente"
                        firmaPedido = "firmaJefe"
                        accionAlerta = "listaJefeCompras"

                        notificacion1Recibe = para
                        notificacion2Recibe = pedido.de

                        pedido.paraJC = para
                        perfilNotificacionesExtra = "JFCM"
                    } else {
                        estadoFinal = EstadoSolicitud.findByCodigo("B01") //estado Existente En Bodega
                        concepto = "Notificación de existencia en bodega"
                        mensTipo = "notificado que existe en bodega"
                        retTipo = "ha sido notificada que existe en bodega"
                        retTipo2 = "notificar que existe en bodega"
                        firmaPedido = "firmaBodega"
                        accionAlerta = "lista"

                        notificacion1Recibe = pedido.de
                    }
                    break;
                case "AJC": // el jefe de compras aprueba la solicitud
                    codEstadoInicial = "E02"
                    estadoFinal = EstadoSolicitud.findByCodigo("E03") //estado Pendientes cotizaciones
                    concepto = "Aprobación"
                    mensTipo = "aprobado"
                    retTipo = "ha sido aprobada"
                    retTipo2 = "aprobarla"
                    firmaPedido = "firmaJefeCompras"
                    accionAlerta = "listaAsistenteCompras"

                    notificacion1Recibe = para
                    notificacion2Recibe = pedido.de

                    pedido.paraAC = para
                    if (str != "") {
                        concepto += str
                        mensTipo += str
                        retTipo += str
                    }

                    perfilNotificacionesExtra = "ASCM"
                    break;
                case "NJC": // el jefe de compras niega la solicitud
                    codEstadoInicial = "E02"
                    estadoFinal = EstadoSolicitud.findByCodigo("N01") //estado Negado
                    concepto = "Negación"
                    mensTipo = "negado"
                    retTipo = "ha sido negada"
                    retTipo2 = "negarla"
                    firmaPedido = "firmaNiega"
                    accionAlerta = "lista"

                    notificacion1Recibe = pedido.de
                    break;
                case "BJC": // el jefe de compras indica de q bodega(s) sacar
                    notificacionBodegas = bodega(pedido, params)

                    codEstadoInicial = "E02"
                    if (params.cant != 0) {
                        estadoFinal = EstadoSolicitud.findByCodigo("E03") //estado Pendientes cotizaciones
                        concepto = "Notificación de existencia en bodega y aprobación parcial"
                        mensTipo = "notificado que existe en bodega y aprobado parcialmente (${params.cant} de ${pedido.cantidad})"
                        retTipo = "ha sido notificada que existe en bodega y aprobado parcialmente"
                        retTipo2 = "notificar que existe en bodega y aprobar parcialmente"
                        firmaPedido = "firmaJefeCompras"
                        accionAlerta = "listaAsistenteCompras"

                        notificacion1Recibe = para
                        notificacion2Recibe = pedido.de

                        pedido.paraAC = para

                        perfilNotificacionesExtra = "ASCM"
                    } else {
                        estadoFinal = EstadoSolicitud.findByCodigo("B01") //estado Existente En Bodega
                        concepto = "Notificación de existencia en bodega"
                        mensTipo = "notificado que existe en bodega"
                        retTipo = "ha sido notificada que existe en bodega"
                        retTipo2 = "notificar que existe en bodega"
                        firmaPedido = "firmaBodega"
                        accionAlerta = "lista"

                        notificacion1Recibe = pedido.de
                    }
                    break;
                case "AAC": // el asistente de compras aprueba la solicitud y ya cargó las cotizaciones
                    codEstadoInicial = "E03"
                    estadoFinal = EstadoSolicitud.findByCodigo("E04") //estado Pendiente de aprobacion final
                    concepto = "Cargado de cotizaciones"
                    mensTipo = "cargado de cotizaciones"
                    retTipo = "ha sido aprobada y ha enviado las cotizaciones"
                    retTipo2 = "aprobarla y enviar las cotizaciones"
                    firmaPedido = "firmaAsistenteCompras"
                    def total = []
                    def cots = Cotizacion.findAllByPedido(pedido, [sort: "id"])
                    def max = 0
                    cots.eachWithIndex { c, i ->
                        def m = c.valor * pedido.cantidad
                        total[i] = m
                        if (m > max) {
                            max = m
                        }
                    }

                    if (max < 100) {
                        accionAlerta = "listaJefe"
                        perfilNotificacionesExtra = "JEFE"
                    } else {
                        accionAlerta = "listaGerente"
                        perfilNotificacionesExtra = "GRNT"
                    }

                    notificacion1Recibe = para
                    notificacion2Recibe = pedido.de

                    pedido.paraAF = para
                    if (str != "") {
                        concepto += str
                        mensTipo += str
                        retTipo += str
                    }
                    break;
                case "NAC": // el asistente de compras niega la solicitud
                    codEstadoInicial = "E03"
                    estadoFinal = EstadoSolicitud.findByCodigo("N01") //estado Negado
                    concepto = "Negación"
                    mensTipo = "negado"
                    retTipo = "ha sido negada"
                    retTipo2 = "negarla"
                    firmaPedido = "firmaNiega"
                    accionAlerta = "lista"

                    notificacion1Recibe = pedido.de
                    break;
                case "BAC": // el asistente de compras indica de q bodega(s) sacar
                    notificacionBodegas = bodega(pedido, params)

                    codEstadoInicial = "E03"
                    if (params.cant != 0) {
                        estadoFinal = EstadoSolicitud.findByCodigo("E04") //estado Pendiente de aprobacion final
                        concepto = "Notificación de existencia en bodega, aprobación parcial y cargado cotizaciones"
                        mensTipo = "notificado que existe en bodega, aprobado parcialmente (${params.cant} de ${pedido.cantidad}) y cargado cotizaciones"
                        retTipo = "ha sido notificada que existe en bodega, aprobado parcialmente y cargado cotizaciones"
                        retTipo2 = "notificar que existe en bodega, aprobar parcialmente y cargar cotizaciones"
                        firmaPedido = "firmaAsistenteCompras"
                        def total = []
                        def cots = Cotizacion.findAllByPedido(pedido, [sort: "id"])
                        def max = 0
                        cots.eachWithIndex { c, i ->
                            def m = c.valor * pedido.cantidad
                            total[i] = m
                            if (m > max) {
                                max = m
                            }
                        }

                        if (max < 100) {
                            accionAlerta = "listaJefe"
                            perfilNotificacionesExtra = "JEFE"
                        } else {
                            accionAlerta = "listaGerente"
                            perfilNotificacionesExtra = "GRNT"
                        }

                        notificacion1Recibe = para
                        notificacion2Recibe = pedido.de

                        pedido.paraAF = para
                    } else {
                        estadoFinal = EstadoSolicitud.findByCodigo("B01") //estado Existente En Bodega
                        concepto = "Notificación de existencia en bodega"
                        mensTipo = "notificado que existe en bodega"
                        retTipo = "ha sido notificada que existe en bodega"
                        retTipo2 = "notificar que existe en bodega"
                        firmaPedido = "firmaBodega"
                        accionAlerta = "lista"

                        notificacion1Recibe = pedido.de
                    }
                    break;
                case "AF": // el jefe o gerente aprueba final la solicitud
                    codEstadoInicial = "E04"
                    estadoFinal = EstadoSolicitud.findByCodigo("A01") //estado aprobado
                    concepto = "APROBACIÓN"
                    mensTipo = "APROBADO"
                    retTipo = "HA SIDO APROBADA"
                    retTipo2 = "aprobarla"
                    firmaPedido = "firmaAprueba"
                    accionAlerta = "listaAprobadas"

                    notificacion1Recibe = pedido.de
                    if (str != "") {
                        concepto += str
                        mensTipo += str
                        retTipo += str
                    }
                    notificacion2Recibe = pedido.paraAC
                    perfilNotificacionesExtra = "ASCM"
                    mensajeAprobacionFinal = ". Puede proceder a la compra de ${pedido.cantidad}${pedido.unidad.codigo} ${pedido.item}"
                    break;
                case "NF": // el jefe o gerente niega la solicitud
                    codEstadoInicial = "E04"
                    estadoFinal = EstadoSolicitud.findByCodigo("N01") //estado Negado
                    concepto = "NEGACIÓN"
                    mensTipo = "NEGADO"
                    retTipo = "HA SIDO NEGADA"
                    retTipo2 = "negarla"
                    firmaPedido = "firmaNiega"
                    accionAlerta = "lista"

                    notificacion1Recibe = pedido.de
                    break;
                case "BF": // el jefe o gerente indica de q bodega(s) sacar
                    notificacionBodegas = bodega(pedido, params)

                    codEstadoInicial = "E04"
                    if (params.cant != 0) {
                        estadoFinal = EstadoSolicitud.findByCodigo("A01") //estado aprobado
                        concepto = "APROBACIÓN PARCIAL"
                        mensTipo = "APROBADO PARCIALMENTE (${params.cant} de ${pedido.cantidad})"
                        retTipo = "HA SIDO APROBADA PARCIALMENTE"
                        retTipo2 = "aprobarla parcialmente"
                        firmaPedido = "firmaAprueba"
                        accionAlerta = "listaAprobadas"

                        notificacion1Recibe = pedido.de
                        notificacion2Recibe = pedido.paraAC
                        perfilNotificacionesExtra = "ASCM"
                        mensajeAprobacionFinal = ". Puede proceder a la compra de ${params.cant}${pedido.unidad.codigo} ${pedido.item}"
                    } else {
                        estadoFinal = EstadoSolicitud.findByCodigo("B01") //estado Existente En Bodega
                        concepto = "Notificación de existencia en bodega"
                        mensTipo = "notificado que existe en bodega"
                        retTipo = "ha sido notificada que existe en bodega"
                        retTipo2 = "notificar que existe en bodega"
                        firmaPedido = "firmaBodega"
                        accionAlerta = "lista"

                        notificacion1Recibe = pedido.de
                    }
                    break;
            }
            if (pedido && estadoFinal) {
                if (params.cant) {
                    pedido.cantidadAprobada = params.cant.toDouble()
                }
                if (tipo == "AF") {
                    if (!params.prio) {
                        params.prio = "2MD"
                    }
                    pedido.prioridad = params.prio
                }
                if (pedido.save()) {
                    if (tipo == "AF") {
                        def cotizacionAprobada = Cotizacion.get(params.cot.toLong())
                        cotizacionAprobada.estadoSolicitud = estadoFinal
                        if (cotizacionAprobada.save()) {
                            println "error al aprobar la cotización: " + cotizacionAprobada.errors
                        }
                    }
//                    println ">>>>> " + pedido + "   " + pedido.estadoSolicitud.codigo + "      " + codEstadoInicial
                    if (pedido.estadoSolicitud.codigo == codEstadoInicial) {
                        def now = new Date()
                        pedido.estadoSolicitud = estadoFinal

                        def firma = new Firma()
                        firma.persona = usu
                        firma.fecha = now
                        firma.concepto = "${concepto} de Nota de pedido núm. ${pedido.numero} de " + pedido.de.nombre + " " + pedido.de.apellido + " " + now.format("dd-MM-yyyy HH:mm")
                        firma.pdfControlador = "reportesInventario"
                        firma.pdfAccion = "notaDePedido"
                        firma.pdfId = pedido.id

                        if (!firma.save(flush: true)) {
                            println "Error con la firma"
                            return "ERROR*Ha ocurrido un error al firmar la solicitud:" + renderErrors(bean: firma)
                        } else {
                            pedido[firmaPedido] = firma
                            def observaciones = "<strong>${usu.toString()}</strong> ha <strong>${mensTipo}</strong> esta nota de pedido " +
                                    "el ${now.format('dd-MM-yyyy')} a las ${now.format('HH:mm')}"
                            if (params.razon && params.razon.trim() != "") {
                                observaciones += ", razón: " + params.razon.trim()
                            }
                            if (params.obs && params.obs.trim() != "") {
                                observaciones += ", observaciones: " + params.obs.trim()
                            }
                            if (pedido.observaciones) {
                                pedido.observaciones = observaciones + " || " + pedido.observaciones
                            } else {
                                pedido.observaciones = observaciones
                            }
                            if (!pedido.save(flush: true)) {
                                println "Error al guardar firma en solicitud " + pedido.errors
                            }

                            def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort
                            def firmaRes = firmaService.firmarDocumento(usu.id, params.auth.toString().encodeAsMD5(), firma, baseUri)
                            if (firmaRes instanceof String) {
                                return "ERROR*" + firmaRes
                            } else {
                                def mens = usu.nombre + " " + usu.apellido + " ha ${mensTipo} la nota de pedido núm. ${pedido.numero}" + mensajeAprobacionFinal
                                def paramsAlerta = [
                                        mensaje    : mens,
                                        controlador: "notaDePedido",
                                        accion     : accionAlerta
                                ]
                                def paramsMail = [
                                        subject : "${concepto} de nota de pedido",
                                        template: '/mail/notaPedido',
                                        model   : [
                                                recibe : notificacion1Recibe,
                                                mensaje: mens,
                                                now    : now,
                                                link   : baseUri + createLink(controller: paramsAlerta.controlador, action: paramsAlerta.accion)
                                        ]
                                ]
                                def msg = notificacionService.notificacionCompleta(usu, notificacion1Recibe, paramsAlerta, paramsMail)
                                if (perfilNotificacionesExtra) {
                                    def perf = Perfil.findByCodigo(perfilNotificacionesExtra)
                                    def personas = Sesion.withCriteria {
                                        eq("perfil", perf)
                                        usuario {
                                            ne("id", notificacion1Recibe.id)
                                            ne("id", notificacion2Recibe.id)
                                            eq("activo", 1)
                                        }
                                        projections {
                                            distinct("usuario")
                                        }
                                    }
                                    personas.each { pers ->
                                        msg += notificacionService.notificacionCompleta(usu, pers, paramsAlerta, paramsMail)
                                    }
                                }
                                if (notificacion2Recibe) {
                                    paramsAlerta.accion = "lista"
                                    paramsMail.model.recibe = notificacion2Recibe
                                    paramsMail.model.link = baseUri + createLink(controller: paramsAlerta.controlador, action: paramsAlerta.accion)
                                    msg += notificacionService.notificacionCompleta(usu, notificacion2Recibe, paramsAlerta, paramsMail)
                                }
                                if (notificacionBodegas.size() > 0) {
                                    notificacionBodegas.each { nb ->
                                        paramsAlerta.accion = "listaBodega"
                                        paramsMail.model.recibe = nb
                                        paramsMail.model.link = baseUri + createLink(controller: paramsAlerta.controlador, action: paramsAlerta.accion)
                                        msg += notificacionService.notificacionCompleta(usu, nb, paramsAlerta, paramsMail)
                                    }
                                }
                                if (msg != "") {
                                    msg = "SUCCESS*La solicitud <strong>número ${pedido.numero}</strong> ${retTipo} exitosamente <ul>" + msg + "</ul>"
                                } else {
                                    msg = "SUCCESS*La solicitud <strong>número ${pedido.numero}</strong> ${retTipo} exitosamente"
                                }
                                return msg
                            }
                        }
                    } else {
                        return "ERROR*La nota de pedido se encuentra en estado ${pedido.estadoSolicitud.nombre}, no puede ${retTipo2}"
                    }
                } else {
                    return "ERROR*Ha ocurrido un error al guardar el nuevo destinatario de la nota de pedido: " + renderErrors(bean: pedido)
                }
            } else {
                return "ERROR*Acción no reconocida"
            }
        } else {
            return "ERROR*Su clave de autorización es incorrecta"
        }
    }
}
