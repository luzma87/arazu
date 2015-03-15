package arazu.proyectos

import arazu.inventario.Bodega
import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Proyecto
 */
class ProyectoController extends Shield {

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
            def c = Proyecto.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                    ilike("entidad", "%" + params.search + "%")
                    ilike("nombre", "%" + params.search + "%")
                }
            }
        } else {
            list = Proyecto.list(params)
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
        def proyectoInstanceList = getList(params, false)
        def proyectoInstanceCount = getList(params, true).size()
        return [proyectoInstanceList: proyectoInstanceList, proyectoInstanceCount: proyectoInstanceCount]
    }

    /**
     * Acción que muestra la lista de elementos para administración
     */
    def listAdmin() {
        def proyectoInstanceList = getList(params, false)
        def proyectoInstanceCount = getList(params, true).size()
        return [proyectoInstanceList: proyectoInstanceList, proyectoInstanceCount: proyectoInstanceCount]
    }

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def proyectoInstance = Proyecto.get(params.id)
            if (!proyectoInstance) {
                render "ERROR*No se encontró Proyecto."
                return
            }
            try {
                proyectoInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Proyecto exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Proyecto"
                return
            }
        } else {
            render "ERROR*No se encontró Proyecto."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción que muestra el formulario de creación de proyecto
     */
    def form() {
        def proyectoInstance = new Proyecto()
        if (params.id) {
            proyectoInstance = Proyecto.get(params.id)
            if (!proyectoInstance) {
                proyectoInstance = null
            }
        }
        proyectoInstance.properties = params
        return [proyectoInstance: proyectoInstance]
    }

    /**
     * Acción que guarda la información de un elemento
     */
    def save() {
        def proyectoInstance = new Proyecto()
        if (params.id) {
            proyectoInstance = Proyecto.get(params.id)
            if (!proyectoInstance) {
                flash.message = "No se encontró el proyecto"
                flash.tipo = "error"
                redirect(action: "form")
                return
            }
        }
        proyectoInstance.properties = params
        if (!proyectoInstance.save(flush: true)) {
            flash.message = "Ha ocurrido un error al guardar Proyecto: " + renderErrors(bean: proyectoInstance)
            flash.tipo = "error"
            redirect(action: "form")
            return
        }
        flash.message = "${params.id ? 'Actualización' : 'Creación'} de Proyecto exitosa."
        flash.tipo = "success"
        redirect(action: "list")
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show() {
        if (params.id) {
            def proyectoInstance = Proyecto.get(params.id)
            if (!proyectoInstance) {
                flash.message = "No se encontró el proyecto"
                flash.tipo = "error"
            }
            return [proyectoInstance: proyectoInstance]
        } else {
            flash.message = "No se encontró el proyecto"
            flash.tipo = "error"
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción que muestra la antalla de configuración del proyecto: asignación de funciones,
     */
    def config() {
        if (params.id) {
            def proyectoInstance = Proyecto.get(params.id)
            if (!proyectoInstance) {
                flash.message = "No se encontró el proyecto"
                flash.tipo = "error"
            }

            def bodegas = Bodega.findAllByProyecto(proyectoInstance)
            def funciones = Funcion.findAllByProyecto(proyectoInstance)

            return [proyectoInstance: proyectoInstance, bodegas: bodegas, funciones: funciones, params: params]
        } else {
            flash.message = "No se encontró el proyecto"
            flash.tipo = "error"
        }
    }

}
