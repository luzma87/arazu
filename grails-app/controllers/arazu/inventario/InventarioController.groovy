package arazu.inventario

import arazu.items.Item
import arazu.parametros.EstadoSolicitud
import arazu.parametros.Unidad
import arazu.seguridad.Persona
import arazu.seguridad.Shield
import arazu.solicitudes.Cotizacion
import arazu.solicitudes.Firma
import arazu.solicitudes.Pedido

class InventarioController extends Shield {

    def firmaService

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
        def items = Item.list([sort: "descripcion"])
        def itemStr = ""
        itemStr += items.collect { '"' + it.descripcion.trim() + '"' }

        //println "items "+itemStr
        return [bodegas: bodegas, bodega: bodega, items: itemStr]
    }

    /**
     * Acción que guarda los ingresos a una bodega
     */
    def saveIngreso() {
        def usu = Persona.get(session.usuario.id)
        def now = new Date()
        println "save ingreso " + params
        def parts = params.data.split("\\|\\|")
        println "parts " + parts
        parts.each {
            if (it != "") {
                def data = it.split("!!")
                println "data " + data
                def ingreso = new Ingreso()
                ingreso.bodega = Bodega.get(params.bodega)
//                ingreso.item = Item.findByDescripcion(data[0].toString().trim())
                ingreso.item = Item.get(data[0].toLong())
                ingreso.cantidad = data[1].toDouble()
                ingreso.unidad = Unidad.get(data[2])
                ingreso.valor = data[3].toDouble()
                ingreso.saldo = data[1].toDouble()
                if (!ingreso.save()) {
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
                        if (!ingreso.save()) {
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
     * Acción que muestra la pntalla de invetario resumido (una fila por item/unidad) de una bodega
     */
    def inventarioResumen() {
//        println "INVENTARIO     " + params
        def bodega = Bodega.get(params.id)
//        def ingresos = Ingreso.findAllByBodegaAndSaldoGreaterThan(bodega, 0)

        def c = Ingreso.createCriteria()
        def ingresos = c.list(params) {
            eq("bodega", bodega)
            gt("saldo", 0.toDouble())
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
     * Acción que muestra la pantalla de recepción de una transferencia de una bodega a otra
     */
    def transferencia() {
        def transfer = Transferencia.get(params.id)

        return [transfer: transfer]
    }

    /**
     * Acción que crea el ingreso de una nota de pedido
     */
    def ingresoNotaPedido() {
        def usu = Persona.get(session.usuario.id)
        def now = new Date()
        def pedido = Pedido.get(params.id)
        def bodega = Bodega.get(params.bodega)
        def estadoAprobado = EstadoSolicitud.findByCodigo("A01")
        def cot = Cotizacion.findAllByPedidoAndEstadoSolicitud(pedido, estadoAprobado)
        if (cot.size() == 1) {
            cot = cot.first()
            def ingreso = new Ingreso()
            ingreso.bodega = bodega
            ingreso.item = pedido.item
            ingreso.cantidad = params.cantidad.toDouble()
            ingreso.unidad = pedido.unidad
            ingreso.valor = cot.valor
            if (!ingreso.save()) {
                println "error en el save de ingreso " + ingreso.errors
                flash.tipo = "error"
                flash.message = renderErrors(bean: ingreso)
            } else {
                def firma = new Firma()
                firma.persona = usu
                firma.fecha = now
                firma.concepto = "Ingreso a bodega de ${ingreso.cantidad}${ingreso.unidad.codigo} ${ingreso.item}, nota de pedido ${pedido.numero} el " + new Date().format("dd-MM-yyyy HH:mm")
                firma.pdfControlador = "reportesInventario"
                firma.pdfAccion = "ingresoDeBodega"
                firma.pdfId = ingreso.id

                if (!firma.save(flush: true)) {
                    println "Error con la firma"
                    flash.tipo = "error"
                    flash.message = "ERROR*Ha ocurrido un error al firmar la solicitud:" + renderErrors(bean: firma)
                } else {
                    ingreso.ingresa = firma
                    ingreso.calcularSaldo()
                    if (!ingreso.save()) {
                        println "Error al firmar el ingreso: " + ingreso.errors
                    } else {
                        def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort
                        def firmaRes = firmaService.firmarDocumento(usu.id, usu.autorizacion, firma, baseUri)
                        if (firmaRes instanceof String) {
                            flash.tipo = "error"
                            flash.message = firmaRes
                        }
                    }
                }
            }
        }
    }
}
