package arazu.inventario

import arazu.items.Item
import arazu.parametros.Unidad
import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Bodega
 */
class BodegaController extends Shield {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    /**
     * Acción que redirecciona a la lista (acción "list")
     */
    def index() {
        redirect(action: "list", params: params)
    }

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
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
        if (params.search) {
            def c = Bodega.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                    ilike("observaciones", "%" + params.search + "%")
                }
            }
        } else {
            list = Bodega.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     */
    def list() {
        def bodegaInstanceList = getList(params, false)
        def bodegaInstanceCount = getList(params, true).size()
        return [bodegaInstanceList: bodegaInstanceList, bodegaInstanceCount: bodegaInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def bodegaInstance = Bodega.get(params.id)
            if (!bodegaInstance) {
                render "ERROR*No se encontró Bodega."
                return
            }
            return [bodegaInstance: bodegaInstance]
        } else {
            render "ERROR*No se encontró Bodega."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def bodegaInstance = new Bodega()
        if (params.id) {
            bodegaInstance = Bodega.get(params.id)
            if (!bodegaInstance) {
                render "ERROR*No se encontró Bodega."
                return
            }
        }
        bodegaInstance.properties = params
        return [bodegaInstance: bodegaInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def bodegaInstance = new Bodega()
        if (params.id) {
            bodegaInstance = Bodega.get(params.id)
            if (!bodegaInstance) {
                render "ERROR*No se encontró Bodega."
                return
            }
        }
        bodegaInstance.properties = params
        if (!bodegaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Bodega: " + renderErrors(bean: bodegaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Bodega exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def bodegaInstance = Bodega.get(params.id)
            if (!bodegaInstance) {
                render "ERROR*No se encontró Bodega."
                return
            }
            try {
                bodegaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Bodega exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Bodega"
                return
            }
        } else {
            render "ERROR*No se encontró Bodega."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción llamada con ajax que muestra los detalles de ingreso de un item a una bodega
     */
    def verDetalles_ajax() {
        def bodega = Bodega.get(params.bodega.toLong())
        def item = Item.get(params.item.toLong())
        def unidad = Unidad.get(params.unidad.toLong())
        def ingresos = Ingreso.withCriteria {
            eq("bodega", bodega)
            eq("item", item)
            eq("unidad", unidad)
            gt("saldo", 0.toDouble())
        }
        return [ingresos: ingresos, bodega: bodega, item: item, unidad: unidad]
    }

}
