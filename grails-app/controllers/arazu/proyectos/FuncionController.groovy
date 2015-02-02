package arazu.proyectos

import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Funcion
 */
class FuncionController extends Shield {

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
            def c = Funcion.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                }
            }
        } else {
            list = Funcion.list(params)
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
        def funcionInstanceList = getList(params, false)
        def funcionInstanceCount = getList(params, true).size()
        return [funcionInstanceList: funcionInstanceList, funcionInstanceCount: funcionInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def funcionInstance = Funcion.get(params.id)
            if (!funcionInstance) {
                render "ERROR*No se encontró Funcion."
                return
            }
            return [funcionInstance: funcionInstance]
        } else {
            render "ERROR*No se encontró Funcion."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def funcionInstance = new Funcion()
        if (params.id) {
            funcionInstance = Funcion.get(params.id)
            if (!funcionInstance) {
                render "ERROR*No se encontró Funcion."
                return
            }
        }
        funcionInstance.properties = params
        return [funcionInstance: funcionInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def funcionInstance = new Funcion()
        if (params.id) {
            funcionInstance = Funcion.get(params.id)
            if (!funcionInstance) {
                render "ERROR*No se encontró Función."
                return
            }
        }
        funcionInstance.properties = params
        if (!funcionInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Función: " + renderErrors(bean: funcionInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Asignación'} de Función exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def funcionInstance = Funcion.get(params.id)
            if (!funcionInstance) {
                render "ERROR*No se encontró Función."
                return
            }
            try {
                funcionInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Función exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Función"
                return
            }
        } else {
            render "ERROR*No se encontró Función."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Función llamada con ajax que muestra la lista de funciones de un proyecto
     */
    def list_ajax() {
        def proyecto = Proyecto.get(params.id)
        def funciones = Funcion.findAllByProyecto(proyecto)
        return [funciones: funciones]
    }

}
