package arazu.solicitudes

import arazu.inventario.Egreso
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

class SolicitudMantenimientoExternoController extends Shield {

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
        def c = SolicitudMantenimientoExterno.createCriteria()
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
        strSearch = "Mostrando las solicitudes de mantenimiento externo " + strSearch
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
        def numero = NotaPedido.list([sort: "numero", order: "desc", limit: 1])
        if (numero.size() > 0) {
            numero = numero.first().numero + 1
        } else {
            numero = 1
        }
        def items = Item.list([sort: "descripcion"])
        def itemStr = ""
        itemStr += items.collect { '"' + it.descripcion.trim() + '"' }

        def jefes = Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo("JFCM"), [sort: 'apellido'])

        return [numero: numero, items: itemStr, jefes: jefes]
    }

    /**
     * Acción que guarda una solicitud de mantenimiento externo y redirecciona a la lista
     */
    def saveSolicitud_ignore() {
        def now = new Date()
        def usu = Persona.get(session.usuario.id)

        def numero = SolicitudMantenimientoExterno.list([sort: "numero", order: "desc", limit: 1])
        if (numero.size() > 0) {
            numero = numero.first().numero + 1
        } else {
            numero = 1
        }

        def firma = new Firma()
        firma.persona = usu
        firma.fecha = now
        firma.pdfControlador = "reportesPedidos"
        firma.pdfAccion = "solicitudMAntExt"
        firma.concepto = ""
        firma.pdfId = 0

        if (!firma.save(flush: true)) {
            println "Error con la firma"
            flash.tipo = "error"
            flash.message = "Ha ocurrido un error al firmar la solicitud:" + renderErrors(bean: firma)
            redirect(action: "pedido")
        } else {
            def solicitud = new SolicitudMantenimientoExterno(params)
            solicitud.estadoSolicitud = EstadoSolicitud.findByCodigo("E11")
            solicitud.fecha = now
            solicitud.de = usu
            solicitud.numero = numero
            solicitud.codigo = "MX-" + numero
            solicitud.firmaSolicita = firma
            solicitud.observaciones = "<strong>" + usu.nombre + " " + usu.apellido + "</strong> ha <strong>realizado</strong> la solicitud de mantenimiento externo #${solicitud.numero} el " + now.format("dd-MM-yyyy HH:mm")
            if (!solicitud.save(flush: true)) {
                println "error  " + solicitud.errors
                flash.tipo = "error"
                flash.message = "Ha ocurrido un error al guardar la solicitud de mantenimiento externo:" + renderErrors(bean: solicitud)
                redirect(action: "pedido")
            } else {
                def trabajosIds = params.trabajos.split(",")
                trabajosIds.each { tid ->
                    def detalle = new DetalleTrabajo()
                    detalle.solicitud = solicitud
                    detalle.tipoTrabajo = TipoTrabajo.get(tid.toLong())
                    if (!detalle.save(flush: true)) {
                        println "Error al grabar el detalle de trabajo de la solicitud"
                    }
                }

                firma.concepto = "Solicitud de mantenimiento externo núm. ${solicitud.numero} de " + usu.nombre + " " + usu.apellido + " " + now.format("dd-MM-yyyy HH:mm")
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
                    def mens = usu.nombre + " " + usu.apellido + " ha realizado la solicitud de mantenimiento externo núm. ${solicitud.numero}"
                    def paramsAlerta = [
                            mensaje    : mens,
                            controlador: "solicitudMantenimientoExterno",
                            accion     : "listaJefeCompras"
                    ]
                    def paramsMail = [
                            subject : "Nueva solicitud de mantenimiento externo",
                            template: '/mail/notaPedido',
                            model   : [
                                    recibe : solicitud.paraJC,
                                    mensaje: mens,
                                    now    : now,
                                    link   : baseUri + createLink(controller: paramsAlerta.controlador, action: paramsAlerta.accion)
                            ]
                    ]
                    def msg = notificacionService.notificacionCompleta(usu, solicitud.paraJC, paramsAlerta, paramsMail)

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
     * Acción que guarda una cotización y vuelve a cargar la pantalla de revisión de asistente de compras
     */
    def saveCotizacion_ignore() {
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
        redirect(action: "revisarAsistenteCompras", id: params.solicitudMantenimientoExterno.id)
    }

    /**
     * Acción que muestra la lista de todas las solicitudes de mantenimiento externo
     */
    def lista() {
        def r1 = getList_funcion(params, false)
        def strSearch = r1.strSearch
        def solicitudes = r1.list
        def solicitudesCount = getList_funcion(params, true).list.size()
        return [solicitudes: solicitudes, solicitudesCount: solicitudesCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de solicitud de mantenimiento externo aprobadas
     */
    def listaAprobadas() {
        def estadoAprobada = EstadoSolicitud.findByCodigo("A11")
        params.search_estado = estadoAprobada.id
        if (!params.order) {
            params.ordeer = "asc"
        }
        def r1 = getList_funcion(params, false)
        def strSearch = r1.strSearch
        def solicitudes = r1.list
        def solicitudesCount = getList_funcion(params, true).list.size()
        def perfil = session.perfil
        def ingreso = perfil.codigo == "RSBD"
        return [solicitudes: solicitudes, solicitudesCount: solicitudesCount, strSearch: strSearch, params: params, ingreso: ingreso]
    }

    /**
     * Acción que muestra la lista de solicitudes de mantenimiento externo para que un jefe de compras les asigne un asistente de compras
     */
    def listaJefeCompras() {
        if (session.perfil.codigo != "JFCM") {
            response.sendError(403)
        }
        def estadoPendienteAsignacion = EstadoSolicitud.findByCodigo("E11")
        params.search_estado = estadoPendienteAsignacion.id
        def r1 = getList_funcion(params, false)
        def strSearch = r1.strSearch
        def solicitudes = r1.list
        def solicitudesCount = getList_funcion(params, true).list.size()
        return [solicitudes: solicitudes, solicitudesCount: solicitudesCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de solicitudes de mantenimiento externo para que un asistente de compras les asigne cotizaciones
     */
    def listaAsistenteCompras() {
        if (session.perfil.codigo != "ASCM") {
            response.sendError(403)
        }
        def estadoPendientesCotizaciones = EstadoSolicitud.findByCodigo("E12")
        params.search_estado = estadoPendientesCotizaciones.id
        def r1 = getList_funcion(params, false)
        def strSearch = r1.strSearch
        def solicitudes = r1.list
        def solicitudesCount = getList_funcion(params, true).list.size()
        return [solicitudes: solicitudes, solicitudesCount: solicitudesCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de solicitudes de mantenimiento externo para que un jefe haga la aprobación final
     */
    def listaJefe() {
        if (session.perfil.codigo != "JEFE") {
            response.sendError(403)
        }
        def estadoPendientesAprobacionFinal = EstadoSolicitud.findByCodigo("E13")
        params.search_estado = estadoPendientesAprobacionFinal.id
        def r1 = getList_funcion(params, false)
        def strSearch = r1.strSearch
        def solicitudes = r1.list
        def solicitudesCount = getList_funcion(params, true).list.size()
        return [solicitudes: solicitudes, solicitudesCount: solicitudesCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que muestra la lista de solicitudes de mantenimiento externo para que un gerente haga la aprobación final
     */
    def listaGerente() {
        if (session.perfil.codigo != "GRNT") {
            response.sendError(403)
        }
        def estadoPendientesAprobacionFinal = EstadoSolicitud.findByCodigo("E13")
        params.search_estado = estadoPendientesAprobacionFinal.id
        def r1 = getList_funcion(params, false)
        def strSearch = r1.strSearch
        def solicitudes = r1.list
        def solicitudesCount = getList_funcion(params, true).list.size()
        return [solicitudes: solicitudes, solicitudesCount: solicitudesCount, strSearch: strSearch, params: params]
    }

    /**
     * Acción que le permite a un jefe de compras revisar una solicitud de mantenimiento externo y aprobar/negar
     */
    def revisarJefeCompras() {
        if (!params.id) {
            response.sendError(404)
        }
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        if (session.perfil.codigo != "JFCM") {
            response.sendError(403)
        }
        if (solicitud.estadoSolicitud.codigo != "E11") {
            response.sendError(403)
        }
        return [solicitud: solicitud]
    }

    /**
     * Acción que le permite a un asistente de compras revisar una solicitud de mantenimiento externo, aprobar/negar y asignar cotizaciones
     */
    def revisarAsistenteCompras() {
        if (!params.id) {
            response.sendError(404)
        }
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        if (session.perfil.codigo != "ASCM") {
            response.sendError(403)
        }
        if (solicitud.estadoSolicitud.codigo != "E12") {
            response.sendError(403)
        }
        def cots = Cotizacion.findAllBySolicitudMantenimientoExterno(solicitud, [sort: "id"])
        return [solicitud: solicitud, cots: cots]
    }

    /**
     * Acción que le permite a un jefe revisar una solicitud de mantenimiento externo
     * y aprobar/negar FINAL
     */
    def revisarJefe() {
        if (!params.id) {
            response.sendError(404)
        }
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        if (session.perfil.codigo != "JEFE") {
            response.sendError(403)
        }
        if (solicitud.estadoSolicitud.codigo != "E13") {
            response.sendError(403)
        }

        def cots = Cotizacion.findAllBySolicitudMantenimientoExterno(solicitud, [sort: "id"])
        return [solicitud: solicitud, cots: cots]
    }

    /**
     * Acción que le permite a un gerente revisar una solicitud de mantenimiento externo
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
        if (solicitud.estadoSolicitud.codigo != "E13") {
            response.sendError(403)
        }

        def cots = Cotizacion.findAllBySolicitudMantenimientoExterno(solicitud, [sort: "id"])
        return [solicitud: solicitud, cots: cots]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para aprobar una solicitud de mantenimiento externo
     */
    def dlgAprobarJefeCompras_ajax() {
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        def asistentesCompras = Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo("ASCM"), [sort: 'apellido'])
        return [solicitud: solicitud, asistentesCompras: asistentesCompras]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para aprobar una solicitud de mantenimiento externo
     */
    def dlgAprobarAsistenteCompras_ajax() {
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        def jefes = null, gerentes = null

        def total = []
        def cots = Cotizacion.findAllBySolicitudMantenimientoExterno(solicitud, [sort: "id"])
        def max = 0
        cots.eachWithIndex { c, i ->
            def m = c.valor
            total[i] = m
            if (m > max) {
                max = m
            }
        }

        if (max < Parametros.maxSolicitudMantExt) {
            jefes = Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo("JEFE"), [sort: 'apellido'])
        } else {
            gerentes = Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo("GRNT"), [sort: 'apellido'])
        }

        return [solicitud: solicitud, jefes: jefes, gerentes: gerentes]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para aprobar una solicitud de mantenimiento externo
     */
    def dlgAprobarFinal_ajax() {
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        def cots = Cotizacion.findAllBySolicitudMantenimientoExterno(solicitud)
        return [solicitud: solicitud, cots: cots]
    }

    /**
     * Acción que carga una pantalla emergente para solicitar al asistente de compras que cargue más cotizaciones
     */
    def dlgSolicitarCotizaciones_ajax() {
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        return [solicitud: solicitud]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para negar una solicitud de mantenimiento externo
     */
    def dlgNegar_ajax() {
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        return [solicitud: solicitud]
    }

    /**
     * Acción que carga una pantalla emergente para completar la información necesaria para negar definitivamente una solicitud de mantenimiento externo
     */
    def dlgNegarFinal_ajax() {
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        return [solicitud: solicitud]
    }

    /**
     * Acción que guarda la aprobación de una solicitud de mantenimiento externo por parte de un jefe, y envía una alerta y un email al asistente de compras destinatario y al que realizó el pedido
     */
    def aprobarJefeCompras_ajax() {
        render cambiarEstadoPedido_funcion(params, "AJC")
    }

    /**
     * Acción que guarda la aprobación de la solicitud de mantenimiento externo con las cotizaciones ingresadas por un asistente de compras  y envía una alerta y un email al jefe o gerente de compras destinatario y al que realizó el pedido
     */
    def aprobarAsistenteCompras_ajax() {
        render cambiarEstadoPedido_funcion(params, "AAC")
    }

    /**
     * Acción que guarda la aprobación final de solicitud de mantenimiento externo por un asistente de compras  y envía una alerta y un email al que realizó el pedido
     */
    def aprobarFinal_ajax() {
        render cambiarEstadoPedido_funcion(params, "AF")
    }

    /**
     * Acción que devuelve una solicitud de mantenimiento externo a un asistente de compras para que cargue más cotizaciones y envía una alerta y un email al que realizó el pedido
     */
    def solicitarCotizaciones_ajax() {
        render cambiarEstadoPedido_funcion(params, "CF")
    }

    /**
     * Acción que guarda la negación de una nota de pedido por parte de un jefe, y envía una alerta y un email al que realizó el pedido
     */
    def negarJefeCompras_ajax() {
        render cambiarEstadoPedido_funcion(params, "NJC")
    }

    /**
     * Acción que guarda la negación de una solicitud de mantenimiento externo por parte de un asistente de compras, y envía una alerta y un email al que realizó el pedido
     */
    def negarAsistenteCompras_ajax() {
        render cambiarEstadoPedido_funcion(params, "NAC")
    }

    /**
     * Acción que guarda la negación final de una solicitud de mantenimiento externo por parte de un asistente de compras, y envía una alerta y un email al que realizó el pedido
     */
    def negarFinal_ajax() {
        render cambiarEstadoPedido_funcion(params, "NF")
    }

    /**
     * Función que cambia de estado una solicitud de mantenimiento externo y envía las notificaciones necesarias
     * @param params los parámetros que llegan del cliente
     * @param tipo tipo de cambio de estado a efectuarse:
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

        def maxMx = Parametros.maxSolicitudMantExt

        def para = null
        def usu = Persona.get(session.usuario.id)
        if (params.para) {
            para = Persona.get(params.para.toLong())
        }
        def pedido = SolicitudMantenimientoExterno.get(params.id.toLong())

        def str = ""

        if (params.auth.toString().encodeAsMD5() == usu.autorizacion) {
            switch (tipo) {
                case "AJC": // el jefe de compras aprueba la solicitud
                    codEstadoInicial = "E11"
                    estadoFinal = EstadoSolicitud.findByCodigo("E12") //estado Pendientes cotizaciones
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
                    codEstadoInicial = "E11"
                    estadoFinal = EstadoSolicitud.findByCodigo("N11") //estado Negado
                    concepto = "Negación"
                    mensTipo = "negado"
                    retTipo = "ha sido negada"
                    retTipo2 = "negarla"
                    firmaPedido = "firmaNiega"
                    accionAlerta = "lista"

                    notificacion1Recibe = pedido.de
                    break;
                case "AAC": // el asistente de compras aprueba la solicitud y ya cargó las cotizaciones
                    codEstadoInicial = "E12"
                    estadoFinal = EstadoSolicitud.findByCodigo("E13") //estado Pendiente de aprobacion final
                    concepto = "Cargado de cotizaciones"
                    mensTipo = "cargado cotizaciones"
                    retTipo = "ha sido aprobada y ha enviado las cotizaciones"
                    retTipo2 = "aprobarla y enviar las cotizaciones"
                    firmaPedido = "firmaAsistenteCompras"
                    def total = []
                    def cots = Cotizacion.findAllBySolicitudMantenimientoExterno(pedido, [sort: "id"])
                    def max = 0
                    cots.eachWithIndex { c, i ->
                        def m = c.valor
                        total[i] = m
                        if (m > max) {
                            max = m
                        }
                    }

                    if (max < maxMx) {
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
                    codEstadoInicial = "E12"
                    estadoFinal = EstadoSolicitud.findByCodigo("N11") //estado Negado
                    concepto = "Negación"
                    mensTipo = "negado"
                    retTipo = "ha sido negada"
                    retTipo2 = "negarla"
                    firmaPedido = "firmaNiega"
                    accionAlerta = "lista"

                    notificacion1Recibe = pedido.de
                    break;
                case "AF": // el jefe o gerente aprueba final la solicitud
                    codEstadoInicial = "E13"
                    estadoFinal = EstadoSolicitud.findByCodigo("A11") //estado aprobado
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
                    codEstadoInicial = "E13"
                    estadoFinal = EstadoSolicitud.findByCodigo("N11") //estado Negado
                    concepto = "NEGACIÓN"
                    mensTipo = "NEGADO"
                    retTipo = "HA SIDO NEGADA"
                    retTipo2 = "negarla"
                    firmaPedido = "firmaNiega"
                    accionAlerta = "lista"

                    notificacion1Recibe = pedido.de
                    break;
                case "CF": // el jefe/gerente devuelve al asistente de compras para que cargue nuevas cotizaciones
                    codEstadoInicial = "E13"
                    estadoFinal = EstadoSolicitud.findByCodigo("E12") //estado Pendientes cotizaciones
                    concepto = "Solicitud de recarga de cotizaciones"
                    mensTipo = "solicitado la recarga de cotizaciones"
                    retTipo = "ha sido solicitada la recarga de cotizaciones"
                    retTipo2 = "solicitar recarga de cotizaciones"
                    firmaPedido = ""
                    accionAlerta = "listaAsistenteCompras"

                    notificacion1Recibe = pedido.paraAC
                    notificacion2Recibe = pedido.de

                    if (str != "") {
                        concepto += str
                        mensTipo += str
                        retTipo += str
                    }

                    perfilNotificacionesExtra = "ASCM"
                    break;
            }
            if (pedido && estadoFinal) {
                if (pedido.save(flush: true)) {
                    if (tipo == "AF") {
                        def cotizacionAprobada = Cotizacion.get(params.cot.toLong())
                        cotizacionAprobada.estadoSolicitud = estadoFinal
                        if (cotizacionAprobada.save(flush: true)) {
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
                        firma.concepto = "${concepto} de Solicitud de mantenimiento externo núm. ${pedido.numero} de " + pedido.de.nombre + " " + pedido.de.apellido + " " + now.format("dd-MM-yyyy HH:mm")
                        firma.pdfControlador = "reportesPedidos"
                        firma.pdfAccion = "solicitudMantenimientoExterno"
                        firma.pdfId = pedido.id

                        if (!firma.save(flush: true)) {
                            println "Error con la firma"
                            return "ERROR*Ha ocurrido un error al firmar la solicitud:" + renderErrors(bean: firma)
                        } else {
                            if (firmaPedido != "") {
                                pedido[firmaPedido] = firma
                            }
                            def observaciones = "<strong>${usu.toString()}</strong> ha <strong>${mensTipo}</strong> esta " +
                                    "solicitud de mantenimiento externo " +
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
                                        "solicitud de mantenimiento externo núm. ${pedido.numero}" + mensajeAprobacionFinal
                                def paramsAlerta = [
                                        mensaje    : mens,
                                        controlador: "solicitudMantenimientoExterno",
                                        accion     : accionAlerta
                                ]
                                def paramsMail = [
                                        subject : "${concepto} de solicitud de mantenimiento externo",
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
                                    msg = "SUCCESS*La solicitud de mantenimiento externo <strong>número ${pedido.numero}</strong> ${retTipo} exitosamente <ul>" + msg + "</ul>"
                                } else {
                                    msg = "SUCCESS*La solicitud de mantenimiento externo <strong>número ${pedido.numero}</strong> ${retTipo} exitosamente"
                                }
                                return msg
                            }
                        }
                    } else {
                        return "ERROR*La solicitud de mantenimiento externo se encuentra en estado ${pedido.estadoSolicitud.nombre}, no puede ${retTipo2}"
                    }
                } else {
                    return "ERROR*Ha ocurrido un error al guardar el nuevo destinatario de la solicitud de mantenimiento externo: " + renderErrors(bean: pedido)
                }
            } else {
                return "ERROR*Acción no reconocida"
            }
        } else {
            return "ERROR*Su clave de autorización es incorrecta"
        }
    }
}
