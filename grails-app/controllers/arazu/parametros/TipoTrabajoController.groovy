package arazu.parametros

import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de TipoTrabajo
 */
class TipoTrabajoController extends Shield {

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
            def c = TipoTrabajo.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("codigo", "%" + params.search + "%")
                    ilike("nombre", "%" + params.search + "%")
                }
            }
        } else {
            list = TipoTrabajo.list(params)
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
        def tipoTrabajoInstanceList = getList_funcion(params, false)
        def tipoTrabajoInstanceCount = getList_funcion(params, true).size()
        return [tipoTrabajoInstanceList: tipoTrabajoInstanceList, tipoTrabajoInstanceCount: tipoTrabajoInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def tipoTrabajoInstance = TipoTrabajo.get(params.id)
            if (!tipoTrabajoInstance) {
                render "ERROR*No se encontró TipoTrabajo."
                return
            }
            return [tipoTrabajoInstance: tipoTrabajoInstance]
        } else {
            render "ERROR*No se encontró TipoTrabajo."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def tipoTrabajoInstance = new TipoTrabajo()
        if (params.id) {
            tipoTrabajoInstance = TipoTrabajo.get(params.id)
            if (!tipoTrabajoInstance) {
                render "ERROR*No se encontró TipoTrabajo."
                return
            }
        }
        tipoTrabajoInstance.properties = params
        return [tipoTrabajoInstance: tipoTrabajoInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def tipoTrabajoInstance = new TipoTrabajo()
        if (params.id) {
            tipoTrabajoInstance = TipoTrabajo.get(params.id)
            if (!tipoTrabajoInstance) {
                render "ERROR*No se encontró TipoTrabajo."
                return
            }
        }
        tipoTrabajoInstance.properties = params
        if (!tipoTrabajoInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar TipoTrabajo: " + renderErrors(bean: tipoTrabajoInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de TipoTrabajo exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def tipoTrabajoInstance = TipoTrabajo.get(params.id)
            if (!tipoTrabajoInstance) {
                render "ERROR*No se encontró TipoTrabajo."
                return
            }
            try {
                tipoTrabajoInstance.delete(flush: true)
                render "SUCCESS*Eliminación de TipoTrabajo exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar TipoTrabajo"
                return
            }
        } else {
            render "ERROR*No se encontró TipoTrabajo."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción llamada con ajax que valida que no se duplique la propiedad codigo
     * @render boolean que indica si se puede o no utilizar el valor recibido
     */
    def validar_unique_codigo_ajax() {
        params.codigo = params.codigo.toString().trim()
        if (params.id) {
            def obj = TipoTrabajo.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render TipoTrabajo.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render TipoTrabajo.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

}
