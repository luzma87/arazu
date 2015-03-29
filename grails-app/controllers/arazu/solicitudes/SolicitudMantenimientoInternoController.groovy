package arazu.solicitudes

import arazu.items.Item
import arazu.items.Maquinaria
import arazu.parametros.EstadoSolicitud
import arazu.parametros.Parametros
import arazu.parametros.TipoTrabajo
import arazu.parametros.TipoUsuario
import arazu.seguridad.Perfil
import arazu.seguridad.Persona
import arazu.seguridad.Sesion
import arazu.seguridad.Shield

class SolicitudMantenimientoInternoController extends Shield {
    def firmaService
    def notificacionService

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista: de los elementos encontrados, strSearch: String con la descripción de la búsqueda realizada
     */
    def getList_funcion(params, all) {
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
        def numero = null
        if (params.search_numero) {
            strSearch += "con número <strong>${params.search_numero}</strong>"
            numero = params.search_numero.toInteger()
        }
        if (params.search_desde) {
            if (strSearch != "") {
                strSearch += ", realizadas "
            } else {
                strSearch += " realizadas"
            }
            desde = new Date().parse("dd-MM-yyyy", params.search_desde)
            strSearch += "desde el <strong>${params.search_desde}</strong>"
        }
        if (params.search_hasta) {
            hasta = new Date().parse("dd-MM-yyyy", params.search_hasta)
            if (strSearch != "") {
                strSearch += ", realizadas "
            } else {
                strSearch += " realizadas"
            }
            strSearch += "hasta el <strong>${params.search_desde}</strong>"
        }
        if (!desde && !hasta) {
            if (strSearch != "") {
                strSearch += ", realizadas "
            } else {
                strSearch += " realizadas"
            }
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
        def c = SolicitudMantenimientoInterno.createCriteria()
        list = c.list(params) {
            if (numero) {
                eq("numero", numero)
            }
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
            if (estado) {
                eq("estadoSolicitud", estado)
            }
        }
        strSearch = "Mostrando las solicitudes de mantenimiento interno " + strSearch
        return [list: list, strSearch: strSearch]
    }

    /**
     * Acción que muestra la pantalla de ingreso de una nueva nsolicitud de mantenimiento externo
     */
    def pedido() {
        def usu = Persona.get(session.usuario.id)
        if (!usu.autorizacion) {
            flash.message = "Tiene que establecer una clave de autorización para poder firmar los documentos. " +
                    "<br/>Presione el botón 'Olvidé mi autorización' e ingrese su e-mail registrado para recibir una clave temporal que puede después modificar." +
                    "<br/>Si no tiene un e-mail registrado contáctese con un administrador del sistema."
            flash.tipo = "error"
            redirect(controller: "persona", action: "personal")
            return
        }
        def numero = SolicitudMantenimientoInterno.list([sort: "numero", order: "desc", limit: 1])
        if (numero.size() > 0) {
            numero = numero.first().numero + 1
        } else {
            numero = 1
        }
        def items = Item.list([sort: "descripcion"])
        def itemStr = ""
        itemStr += items.collect { '"' + it.descripcion.trim() + '"' }

        def ls = [TipoUsuario.findByCodigo("JFCM"), TipoUsuario.findByCodigo("GRNT")]
        def jefes = Persona.findAllByTipoUsuarioInList(ls, [sort: 'apellido'])

        return [numero: numero, items: itemStr, jefes: jefes]
    }

    /**
     * Acción que guarda una solicitud de mantenimiento externo y redirecciona a la lista
     */
    def saveSolicitud_ignore() {
        def now = new Date()
        def usu = Persona.get(session.usuario.id)

        def numero = SolicitudMantenimientoInterno.list([sort: "numero", order: "desc", limit: 1])
        if (numero.size() > 0) {
            numero = numero.first().numero + 1
        } else {
            numero = 1
        }

        def firma = new Firma()
        firma.persona = usu
        firma.fecha = now
        firma.pdfControlador = "reportesPedidos"
        firma.pdfAccion = "solicitudMantInt"
        firma.concepto = ""
        firma.pdfId = 0

        if (!firma.save(flush: true)) {
            println "Error con la firma"
            flash.tipo = "error"
            flash.message = "Ha ocurrido un error al firmar la solicitud:" + renderErrors(bean: firma)
            redirect(action: "pedido")
        } else {
            def solicitud = new SolicitudMantenimientoInterno(params)
            solicitud.estadoSolicitud = EstadoSolicitud.findByCodigo("E21")
            solicitud.fecha = now
            solicitud.de = usu
            solicitud.numero = numero
            solicitud.codigo = "MI-" + numero
            solicitud.firmaSolicita = firma
            solicitud.observaciones = "<strong>" + usu.nombre + " " + usu.apellido + "</strong> ha <strong>realizado</strong> la solicitud de mantenimiento interno #${solicitud.numero} el " + now.format("dd-MM-yyyy HH:mm")
            if (!solicitud.save(flush: true)) {
                println "error  " + solicitud.errors
                flash.tipo = "error"
                flash.message = "Ha ocurrido un error al guardar la solicitud de mantenimiento interno:" + renderErrors(bean: solicitud)
                redirect(action: "pedido")
            } else {
                def trabajosIds = params.trabajos.split(",")
                trabajosIds.each { tid ->
                    def detalle = new DetalleTrabajo()
                    detalle.solicitudMantenimientoInterno = solicitud
                    detalle.tipoTrabajo = TipoTrabajo.get(tid.toLong())
                    if (!detalle.save(flush: true)) {
                        println "Error al grabar el detalle de trabajo de la solicitud"
                    }
                }

                firma.concepto = "Solicitud de mantenimiento interno núm. ${solicitud.numero} de " + usu.nombre + " " + usu.apellido + " " + now.format("dd-MM-yyyy HH:mm")
                firma.pdfId = solicitud.id
                if (!firma.save(flush: true)) {
                    println "error al asociar firma con solicitud: " + firma.errors
                }

                def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort
                def firmaRes = firmaService.firmarDocumento(usu.id, usu.autorizacion, firma, baseUri)
                if (firmaRes instanceof String) {
                    flash.tipo = "error"
                    flash.message = firmaRes
                    redirect(action: "pedido")
                } else {
                    def mens = usu.nombre + " " + usu.apellido + " ha realizado la solicitud de mantenimiento interno núm. ${solicitud.numero}"
                    def paramsAlerta = [
                            mensaje    : mens,
                            controlador: "solicitudMantenimientoInterno",
                            accion     : "listaJefe"
                    ]
                    def paramsMail = [
                            subject : "Nueva solicitud de mantenimiento interno",
                            template: '/mail/notaPedido',
                            model   : [
                                    recibe : solicitud.paraAF,
                                    mensaje: mens,
                                    now    : now,
                                    link   : baseUri + createLink(controller: paramsAlerta.controlador, action: paramsAlerta.accion)
                            ]
                    ]
                    def msg = notificacionService.notificacionCompleta(usu, solicitud.paraAF, paramsAlerta, paramsMail)

                    def perf = Perfil.findByCodigo("JFCM")
                    def personas = Sesion.withCriteria {
                        eq("perfil", perf)
                        usuario {
                            ne("id", solicitud.paraJC.id)
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
                    flash.message = "La solicitud de mantenimiento externo <strong>número ${numero}</strong> ha sido enviada exitosamente"
                    if (msg != "") {
                        flash.message += "<ul>" + msg + "</ul>"
                    }
                    redirect(action: "lista")
                }
            }
        }
    }

    /**
     * Acción que muestra la lista de todas las solicitudes de mantenimiento interno
     */
    def lista() {
        def r1 = getList_funcion(params, false)
        def strSearch = r1.strSearch
        def solicitudes = r1.list
        def solicitudesCount = getList_funcion(params, true).list.size()
        return [solicitudes: solicitudes, solicitudesCount: solicitudesCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de solicitud de mantenimiento interno aprobadas
     */
    def listaAprobadas() {
        def estadoAprobada = EstadoSolicitud.findByCodigo("A21")
        params.search_estado = estadoAprobada.id
        if (!params.order) {
            params.ordeer = "asc"
        }
        def r1 = getList_funcion(params, false)
        def strSearch = r1.strSearch
        def solicitudes = r1.list
        def solicitudesCount = getList_funcion(params, true).list.size()
        return [solicitudes: solicitudes, solicitudesCount: solicitudesCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de solicitudes de mantenimiento interno para que un jefe haga la aprobación final
     */
    def listaJefe() {
        if (session.perfil.codigo != "JEFE") {
            response.sendError(403)
        }
        def estadoPendientesAprobacionFinal = EstadoSolicitud.findByCodigo("E21")
        params.search_estado = estadoPendientesAprobacionFinal.id
        def r1 = getList_funcion(params, false)
        def strSearch = r1.strSearch
        def solicitudes = r1.list
        def solicitudesCount = getList_funcion(params, true).list.size()
        return [solicitudes: solicitudes, solicitudesCount: solicitudesCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de solicitudes de mantenimiento interno para que un gerente haga la aprobación final
     */
    def listaGerente() {
        if (session.perfil.codigo != "GRNT") {
            response.sendError(403)
        }
        def estadoPendientesAprobacionFinal = EstadoSolicitud.findByCodigo("E21")
        params.search_estado = estadoPendientesAprobacionFinal.id
        def r1 = getList_funcion(params, false)
        def strSearch = r1.strSearch
        def solicitudes = r1.list
        def solicitudesCount = getList_funcion(params, true).list.size()
        return [solicitudes: solicitudes, solicitudesCount: solicitudesCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que le permite a un jefe revisar una solicitud de mantenimiento interno
     * y aprobar/negar FINAL
     */
    def revisarJefe() {
        if (!params.id) {
            response.sendError(404)
        }
        def solicitud = SolicitudMantenimientoInterno.get(params.id)
        if (session.perfil.codigo != "JEFE") {
            response.sendError(403)
        }
        if (solicitud.estadoSolicitud.codigo != "E21") {
            response.sendError(403)
        }

        return [solicitud: solicitud]
    }

    /**
     * Acción que le permite a un gerente revisar una solicitud de mantenimiento interno
     * y aprobar/negar FINAL
     */
    def revisarGerente() {
        if (!params.id) {
            response.sendError(404)
        }
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        if (session.perfil.codigo != "GRNT") {
            response.sendError(403)
        }
        if (solicitud.estadoSolicitud.codigo != "E21") {
            response.sendError(403)
        }

        return [solicitud: solicitud]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para aprobar una solicitud de mantenimiento interno
     */
    def dlgAprobarFinal_ajax() {
        def solicitud = SolicitudMantenimientoInterno.get(params.id)
        return [solicitud: solicitud]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para negar definitivamente una solicitud de mantenimiento interno
     */
    def dlgNegarFinal_ajax() {
        def solicitud = SolicitudMantenimientoInterno.get(params.id)
        return [solicitud: solicitud]
    }

    /**
     * Acción que guarda la aprobación final de solicitud de mantenimiento interno y envía una alerta y un email al que realizó el pedido
     */
    def aprobarFinal_ajax() {
        render cambiarEstadoPedido_funcion(params, "AF")
    }

    /**
     * Acción que guarda la negación final de una solicitud de mantenimiento interno por parte de un asistente de compras, y envía una alerta y un email al que realizó el pedido
     */
    def negarFinal_ajax() {
        render cambiarEstadoPedido_funcion(params, "NF")
    }

    /**
     * Función que cambia de estado una solicitud de mantenimiento interno y envía las notificaciones necesarias
     * @param params los parámetros que llegan del cliente
     * @param tipo tipo de cambio de estado a efectuarse:
     *              AF: el jefe/gerente aprueba definitivamente la solicitud
     *              NF: el jefe/gerente niega definitivamente la solicitud
     *              BF: el jefe/gerente indica de q bodega(s) sacar
     * @return String con los mensajes de error si ocurrieron
     */
    private String cambiarEstadoPedido_funcion(params, String tipo) {
        String codEstadoInicial = ""
        EstadoSolicitud estadoFinal = null
        String concepto = "", mensTipo = "", retTipo = "", retTipo2 = ""
        String firmaPedido = ""
        String accionAlerta = ""
        def notificacion1Recibe = null
        def notificacion2Recibe = null
        def perfilNotificacionesExtra = null
        String mensajeAprobacionFinal = ""

        def para = null
        def usu = Persona.get(session.usuario.id)
        if (params.para) {
            para = Persona.get(params.para.toLong())
        }
        def pedido = SolicitudMantenimientoInterno.get(params.id.toLong())

        def str = ""

        if (params.auth.toString().encodeAsMD5() == usu.autorizacion) {
            switch (tipo) {
                case "AF": // el jefe o gerente aprueba final la solicitud
                    codEstadoInicial = "E21"
                    estadoFinal = EstadoSolicitud.findByCodigo("A21") //estado aprobado
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
                    mensajeAprobacionFinal = ". Puede proceder al mantenimiento solicitado."
                    break;
                case "NF": // el jefe o gerente niega la solicitud
                    codEstadoInicial = "E21"
                    estadoFinal = EstadoSolicitud.findByCodigo("N21") //estado Negado
                    concepto = "NEGACIÓN"
                    mensTipo = "NEGADO"
                    retTipo = "HA SIDO NEGADA"
                    retTipo2 = "negarla"
                    firmaPedido = "firmaNiega"
                    accionAlerta = "lista"

                    notificacion1Recibe = pedido.de
                    break;
            }
            if (pedido && estadoFinal) {
                if (pedido.save(flush: true)) {
//                    println ">>>>> " + pedido + "   " + pedido.estadoSolicitud.codigo + "      " + codEstadoInicial
                    if (pedido.estadoSolicitud.codigo == codEstadoInicial) {
                        def now = new Date()
                        pedido.estadoSolicitud = estadoFinal

                        def firma = new Firma()
                        firma.persona = usu
                        firma.fecha = now
                        firma.concepto = "${concepto} de Solicitud de mantenimiento interno núm. ${pedido.numero} de " + pedido.de.nombre + " " + pedido.de.apellido + " " + now.format("dd-MM-yyyy HH:mm")
                        firma.pdfControlador = "reportesPedidos"
                        firma.pdfAccion = "solicitudMantenimientoInterno"
                        firma.pdfId = pedido.id

                        if (!firma.save(flush: true)) {
                            println "Error con la firma"
                            return "ERROR*Ha ocurrido un error al firmar la solicitud:" + renderErrors(bean: firma)
                        } else {
                            if (firmaPedido != "") {
                                pedido[firmaPedido] = firma
                            }
                            def observaciones = "<strong>${usu.toString()}</strong> ha <strong>${mensTipo}</strong> esta " +
                                    "solicitud de mantenimiento interno " +
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
                                def mens = usu.nombre + " " + usu.apellido + " ha ${mensTipo} la " +
                                        "solicitud de mantenimiento interno núm. ${pedido.numero}" + mensajeAprobacionFinal
                                def paramsAlerta = [
                                        mensaje    : mens,
                                        controlador: "solicitudMantenimientoInterno",
                                        accion     : accionAlerta
                                ]
                                def paramsMail = [
                                        subject : "${concepto} de solicitud de mantenimiento interno",
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
                                if (msg != "") {
                                    msg = "SUCCESS*La solicitud de mantenimiento interno <strong>número ${pedido.numero}</strong> ${retTipo} exitosamente <ul>" + msg + "</ul>"
                                } else {
                                    msg = "SUCCESS*La solicitud de mantenimiento interno <strong>número ${pedido.numero}</strong> ${retTipo} exitosamente"
                                }
                                return msg
                            }
                        }
                    } else {
                        return "ERROR*La solicitud de mantenimiento interno se encuentra en estado ${pedido.estadoSolicitud.nombre}, no puede ${retTipo2}"
                    }
                } else {
                    return "ERROR*Ha ocurrido un error al guardar el nuevo destinatario de la solicitud de mantenimiento interno: " + renderErrors(bean: pedido)
                }
            } else {
                return "ERROR*Acción no reconocida"
            }
        } else {
            return "ERROR*Su clave de autorización es incorrecta"
        }
    }
}
