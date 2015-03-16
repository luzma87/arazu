package arazu.parametros

import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Color
 */
class ColorController extends Shield {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
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
        if (params.search) {
            def c = Color.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("hex", "%" + params.search + "%")
                    ilike("nombre", "%" + params.search + "%")
                }
            }
        } else {
            list = Color.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList_funcion(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     */
    def list() {
        def colorInstanceList = getList_funcion(params, false)
        def colorInstanceCount = getList_funcion(params, true).size()
        return [colorInstanceList: colorInstanceList, colorInstanceCount: colorInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def colorInstance = Color.get(params.id)
            if (!colorInstance) {
                render "ERROR*No se encontró Color."
                return
            }
            return [colorInstance: colorInstance]
        } else {
            render "ERROR*No se encontró Color."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def colorInstance = new Color()
        if (params.id) {
            colorInstance = Color.get(params.id)
            if (!colorInstance) {
                render "ERROR*No se encontró Color."
                return
            }
        }
        colorInstance.properties = params
        return [colorInstance: colorInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def colorInstance = new Color()
        if (params.id) {
            colorInstance = Color.get(params.id)
            if (!colorInstance) {
                render "ERROR*No se encontró Color."
                return
            }
        }
        colorInstance.properties = params
        if (!colorInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Color: " + renderErrors(bean: colorInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Color exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def colorInstance = Color.get(params.id)
            if (!colorInstance) {
                render "ERROR*No se encontró Color."
                return
            }
            try {
                colorInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Color exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Color"
                return
            }
        } else {
            render "ERROR*No se encontró Color."
            return
        }
    } //delete para eliminar via ajax

}
