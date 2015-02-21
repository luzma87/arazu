package arazu.solicitudes

import arazu.alertas.Alerta
import arazu.inventario.Ingreso
import arazu.items.Item
import arazu.parametros.EstadoSolicitud
import arazu.parametros.TipoUsuario
import arazu.seguridad.Persona
import arazu.seguridad.Shield

class NotaDePedidoController extends Shield {

    def mailService
    def firmaService
    def notificacionService

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
        def estadoNegado = EstadoSolicitud.findByCodigo("E03")
        def notas = Pedido.findAllByEstadoSolicitudNotEqual(estadoNegado, [sort: "numero"])
        return [notas: notas]
    }

    /**
     * Acción que muestra la lista de notas de pedido que un jefe debe autorizar
     */
    def listaJefatura() {
        def estadoPendienteRevision = EstadoSolicitud.findByCodigo("E01")
        def notas = Pedido.findAllByEstadoSolicitudAndPara(estadoPendienteRevision, session.usuario, [sort: "numero"])
        [notas: notas]
    }

    /**
     * Acción que le permite a un jefe revisar una nota de pedido, verificar las existencias en bodegas
     * y aprobar/negar/informar existe en bodegas
     */
    def revisarJefatura() {
        if (!params.id)
            response.sendError(404)
        def nota = Pedido.get(params.id)
        if (nota.para.id != session.usuario.id) {
            response.sendError(403)
        }
        if (nota.estadoSolicitud.codigo != "E01") {
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
        return [nota: nota, existencias: existencias]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para aprobar una nota de pedido
     */
    def dlgAprobar_ajax() {
        def nota = Pedido.get(params.id)
        def jefesCompras = Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo("JFCM"), [sort: 'apellido'])
        return [nota: nota, jefesCompras: jefesCompras]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para negar una nota de pedido
     */
    def dlgNegar_ajax() {
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
        return [nota: nota, existencias: existencias]
    }


    def cambiarEstadoPedido(params, String tipo) {
        String codEstadoInicial = ""
        EstadoSolicitud estadoFinal = null
        String concepto = "", mensTipo = "", retTipo = "", retTipo2 = ""
        String firmaPedido = ""
        String accionAlerta = ""
        def notificacion1Recibe = null
        def notificacion2Recibe = null

        def para = null
        def usu = Persona.get(session.usuario.id)
        if (params.para) {
            para = Persona.get(params.para.toLong())
        }
        def pedido = Pedido.get(params.id.toLong())

        switch (tipo) {
            case "AJF": //el jefe se aprueba la solicitud
                codEstadoInicial = "E01"
                estadoFinal = EstadoSolicitud.findByCodigo("E02") //estadoPendienteAsignacion
                concepto = "Aprobación"
                mensTipo = "aprobado"
                retTipo = "aprobada"
                retTipo2 = "aprobarla"
                firmaPedido = "firmaJefe"
                accionAlerta = "listaJefeCompras"

                notificacion1Recibe = para
                notificacion2Recibe = pedido.de
                break;
            case "NJF": //el jefe se niega la solicitud
                codEstadoInicial = "E01"
                estadoFinal = EstadoSolicitud.findByCodigo("N01") //estadoNegado
                concepto = "Negación"
                mensTipo = "negado"
                retTipo = "negada"
                retTipo2 = "negarla"
                firmaPedido = "firmaBodega"
                accionAlerta = "lista"

                notificacion1Recibe = pedido.de
                break;
            case "BJF": // el jefe indica de q bodega(s) sacar
                // ret_5:2, obs:sssss, auth:456, ret_6:1
                params.each { k, v ->
                    if(k.toString().startsWith("ret")) {

                    }
                }

//                codEstadoInicial = "E01"
//                estadoFinal = EstadoSolicitud.findByCodigo("B01") //estadoExistenteEnBodega
//                concepto = "Notificación de existencia en bodega"
//                mensTipo = "notificado que existe en bodega"
//                retTipo = "notificada que existe en bodega"
//                retTipo2 = "notificar que existe en bodega"
//                firmaPedido = "firmaNiega"
//                accionAlerta = "lista"
//
//                notificacion1Recibe = pedido.de
//                notificacion2Recibe = [].toArray()
                break;
        }
        if (pedido && estadoFinal) {
            if (params.auth.toString().encodeAsMD5() == usu.autorizacion) {
                if (pedido) {
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
                                pedido.observaciones = observaciones + " | " + pedido.observaciones
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
                                def mens = usu.nombre + " " + usu.apellido + " ha ${mensTipo} la nota de pedido núm. ${pedido.numero}"
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
                                if (notificacion2Recibe) {
                                    paramsAlerta.accion = "lista"
                                    paramsMail.model.recibe = notificacion2Recibe
                                    paramsMail.model.link = baseUri + createLink(controller: paramsAlerta.controlador, action: paramsAlerta.accion)
                                    msg += notificacionService.notificacionCompleta(usu, notificacion2Recibe, paramsAlerta, paramsMail)
                                }
                                if (msg != "") {
                                    msg = "SUCCESS*La solicitud <strong>número ${pedido.numero}</strong> ha sido ${retTipo} exitosamente <ul>" + msg + "</ul>"
                                } else {
                                    msg = "SUCCESS*La solicitud <strong>número ${pedido.numero}</strong> ha sido ${retTipo} exitosamente"
                                }
                                return msg
                            }
                        }
                    } else {
                        return "ERROR*La nota de pedido se encuentra en estado ${pedido.estadoSolicitud.nombre}, no puede ${retTipo2}"
                    }
                } else {
                    return "ERROR*No se encontró la nota de pedido"
                }
            } else {
                return "ERROR*Su clave de autorización es incorrecta"
            }
        } else {
            return "ERROR*Acción no reconocida"
        }
    }

    /**
     * Acción que guarda la aprobación de una nota de pedido por parte de un jefe, y envía una alerta y un email al jefe de compras destinatario y al que realizó el pedido
     */
    def aprobarJefatura_ajax() {
        render cambiarEstadoPedido(params, "AJF")
    }

    /**
     * Acción que guarda la negación de una nota de pedido por parte de un jefe, y envía una alerta y un email al que realizó el peddo
     */
    def negarJefatura_ajax() {
        render cambiarEstadoPedido(params, "NJF")
    }

    /**
     * Acción que guarda la información de las bodegas seleccionadas cuando un jefe notifica que una nota de pedido está disponible en bodegas. Envía una alerta y un email al que realizó el pedido y a los reponsables de bodega correspondientes
     */
    def bodegaJefatura_ajax() {
        render cambiarEstadoPedido(params, "BJF")
    }

    def revisar() {
        if (!params.id)
            response.sendError(404)
        def nota = Pedido.get(params.id)
        if (nota.para.id != session.usuario.id) {
            response.sendError(403)
        }
        if (nota.estadoSolicitud.codigo != "E01") {
            response.sendError(403)
        }
        def cots = Cotizacion.findAllByPedido(nota, [sort: "id"])
        [nota: nota, cots: cots]
    }

    def savaCotizacion() {
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
        redirect(action: "revisar", id: params.pedido.id)
    }

    def enviarAprobacion() {

        def nota = Pedido.get(params.id)
        def cots = Cotizacion.findAllByPedido(nota, [sort: "id"])
        if (cots.size() < 1) {
            flash.message = "Error: Está nota de pedido no tiene al menos una cotización"
            response.sendError(403)
        } else {
            nota.estadoSolicitud = EstadoSolicitud.findByCodigo("E04")
            nota.save(flush: true)
            flash.message = "La nota de pedido número ${nota.numero} ha sido enviada para su aprobación"
            redirect(action: "listaJefatura")
        }
    }

    def listaAprobacion() {

        def notas = Pedido.findAllByEstadoSolicitud(EstadoSolicitud.findByCodigo("E04"), [sort: "numero"])
        [notas: notas]
    }


}
