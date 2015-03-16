package arazu.parametros

import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de TipoSolicitud
 */
class TipoSolicitudController extends Shield {

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
            def c = TipoSolicitud.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                    ilike("nombre", "%" + params.search + "%")
                }
            }
        } else {
            list = TipoSolicitud.list(params)
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
        def tipoSolicitudInstanceList = getList_funcion(params, false)
        def tipoSolicitudInstanceCount = getList_funcion(params, true).size()
        return [tipoSolicitudInstanceList: tipoSolicitudInstanceList, tipoSolicitudInstanceCount: tipoSolicitudInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def tipoSolicitudInstance = TipoSolicitud.get(params.id)
            if (!tipoSolicitudInstance) {
                render "ERROR*No se encontró TipoSolicitud."
                return
            }
            return [tipoSolicitudInstance: tipoSolicitudInstance]
        } else {
            render "ERROR*No se encontró TipoSolicitud."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def tipoSolicitudInstance = new TipoSolicitud()
        if (params.id) {
            tipoSolicitudInstance = TipoSolicitud.get(params.id)
            if (!tipoSolicitudInstance) {
                render "ERROR*No se encontró TipoSolicitud."
                return
            }
        }
        tipoSolicitudInstance.properties = params
        return [tipoSolicitudInstance: tipoSolicitudInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def tipoSolicitudInstance = new TipoSolicitud()
        if (params.id) {
            tipoSolicitudInstance = TipoSolicitud.get(params.id)
            if (!tipoSolicitudInstance) {
                render "ERROR*No se encontró TipoSolicitud."
                return
            }
        }
        tipoSolicitudInstance.properties = params
        if (!tipoSolicitudInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar TipoSolicitud: " + renderErrors(bean: tipoSolicitudInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de TipoSolicitud exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def tipoSolicitudInstance = TipoSolicitud.get(params.id)
            if (!tipoSolicitudInstance) {
                render "ERROR*No se encontró TipoSolicitud."
                return
            }
            try {
                tipoSolicitudInstance.delete(flush: true)
                render "SUCCESS*Eliminación de TipoSolicitud exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar TipoSolicitud"
                return
            }
        } else {
            render "ERROR*No se encontró TipoSolicitud."
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
            def obj = TipoSolicitud.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render TipoSolicitud.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render TipoSolicitud.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

}
