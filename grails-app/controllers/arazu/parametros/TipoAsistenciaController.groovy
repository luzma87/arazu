package arazu.parametros

import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de TipoAsistencia
 */
class TipoAsistenciaController extends Shield {

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
        if(all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if(params.search) {
            def c = TipoAsistencia.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    
                    ilike("codigo", "%" + params.search + "%")  
                    ilike("nombre", "%" + params.search + "%")  
                }
            }
        } else {
            list = TipoAsistencia.list(params)
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
        def tipoAsistenciaInstanceList = getList_funcion(params, false)
        def tipoAsistenciaInstanceCount = getList_funcion(params, true).size()
        return [tipoAsistenciaInstanceList: tipoAsistenciaInstanceList, tipoAsistenciaInstanceCount: tipoAsistenciaInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if(params.id) {
            def tipoAsistenciaInstance = TipoAsistencia.get(params.id)
            if(!tipoAsistenciaInstance) {
                render "ERROR*No se encontró TipoAsistencia."
                return
            }
            return [tipoAsistenciaInstance: tipoAsistenciaInstance]
        } else {
            render "ERROR*No se encontró TipoAsistencia."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def tipoAsistenciaInstance = new TipoAsistencia()
        if(params.id) {
            tipoAsistenciaInstance = TipoAsistencia.get(params.id)
            if(!tipoAsistenciaInstance) {
                render "ERROR*No se encontró TipoAsistencia."
                return
            }
        }
        tipoAsistenciaInstance.properties = params
        return [tipoAsistenciaInstance: tipoAsistenciaInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def tipoAsistenciaInstance = new TipoAsistencia()
        if(params.id) {
            tipoAsistenciaInstance = TipoAsistencia.get(params.id)
            if(!tipoAsistenciaInstance) {
                render "ERROR*No se encontró TipoAsistencia."
                return
            }
        }
        tipoAsistenciaInstance.properties = params
        if(!tipoAsistenciaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar TipoAsistencia: " + renderErrors(bean: tipoAsistenciaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de TipoAsistencia exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if(params.id) {
            def tipoAsistenciaInstance = TipoAsistencia.get(params.id)
            if (!tipoAsistenciaInstance) {
                render "ERROR*No se encontró TipoAsistencia."
                return
            }
            try {
                tipoAsistenciaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de TipoAsistencia exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar TipoAsistencia"
                return
            }
        } else {
            render "ERROR*No se encontró TipoAsistencia."
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
            def obj = TipoAsistencia.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render TipoAsistencia.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render TipoAsistencia.countByCodigoIlike(params.codigo) == 0
            return
        }
    }
        
}
