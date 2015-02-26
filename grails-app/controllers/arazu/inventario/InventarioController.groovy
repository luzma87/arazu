package arazu.inventario

import arazu.items.Item
import arazu.parametros.Unidad
import arazu.seguridad.Shield

class InventarioController extends Shield {

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
        println "save ingreso " + params
        def parts = params.data.split("\\|\\|")
        println "parts " + parts
        parts.each {
            if (it != "") {
                def data = it.split("!!")
                println "data " + data
                def ingreso = new Ingreso()
                ingreso.bodega = Bodega.get(params.bodega)
                ingreso.item = Item.findByDescripcion(data[0].trim())
                ingreso.cantidad = data[1].toDouble()
                ingreso.unidad = Unidad.get(data[2])
                ingreso.valor = data[3].toDouble()
                ingreso.saldo = data[1].toDouble()
                if (!ingreso.save(flush: true)) {
                    println "error en el save de ingreso " + ingreso.errors
                }
            }
        }
        render "ok"
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
}
