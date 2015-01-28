package arazu.items

import arazu.parametros.TipoMaquinaria
import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Maquinaria
 */
class MaquinariaController extends Shield {

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
            def c = Maquinaria.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                    ilike("marca", "%" + params.search + "%")
                    ilike("modelo", "%" + params.search + "%")
                    ilike("observaciones", "%" + params.search + "%")
                    ilike("placa", "%" + params.search + "%")
                }
            }
        } else {
            list = Maquinaria.list(params)
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
        def maquinariaInstanceList = getList(params, false)
        def maquinariaInstanceCount = getList(params, true).size()
        return [maquinariaInstanceList: maquinariaInstanceList, maquinariaInstanceCount: maquinariaInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def maquinariaInstance = Maquinaria.get(params.id)
            if (!maquinariaInstance) {
                render "ERROR*No se encontró Maquinaria."
                return
            }
            return [maquinariaInstance: maquinariaInstance]
        } else {
            render "ERROR*No se encontró Maquinaria."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def maquinariaInstance = new Maquinaria()
        if (params.id) {
            maquinariaInstance = Maquinaria.get(params.id)
            if (!maquinariaInstance) {
                render "ERROR*No se encontró Maquinaria."
                return
            }
        }
        maquinariaInstance.properties = params
        def current = new Date().format("yyyy").toInteger()
        def ini = current - 35
        def fin = current + 1
        def anios = ini..fin
        if (params.padre) {
            maquinariaInstance.tipo = TipoMaquinaria.get(params.padre.toLong())
        }
        return [maquinariaInstance: maquinariaInstance, anios: anios, current: current]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def maquinariaInstance = new Maquinaria()
        if (params.id) {
            maquinariaInstance = Maquinaria.get(params.id)
            if (!maquinariaInstance) {
                render "ERROR*No se encontró Maquinaria."
                return
            }
        }
        maquinariaInstance.properties = params
        if (!maquinariaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Maquinaria: " + renderErrors(bean: maquinariaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Maquinaria exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def maquinariaInstance = Maquinaria.get(params.id)
            if (!maquinariaInstance) {
                render "ERROR*No se encontró Maquinaria."
                return
            }
            try {
                maquinariaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Maquinaria exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Maquinaria"
                return
            }
        } else {
            render "ERROR*No se encontró Maquinaria."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción que muestra la administración de tipos de items, items y bodegas en forma de árbol
     */
    def arbol() {
        return [arbol: makeTree(params), params: params]
    }

    /**
     * Función que genera el árbol de items
     */
    private String makeTree(params) {
        def res = ""
        res += "<ul>"
        res += "<li id='root' data-level='0' class='root jstree-open' data-jstree='{\"type\":\"root\"}'>"
        res += "<a href='#' class='label_arbol'>HINSA</a>"
        res += "<ul>"
        res += imprimeHijos(null, params)
        res += "</li>"
        res += "</ul>"
        return res
    }

    /**
     * Función que imprime los hijos del árbol
     */
    private String imprimeHijos(padre, params) {
        def arbol = ""
        def hijos = []
        def tipo
        if (!padre) {
            hijos = TipoMaquinaria.list([sort: "nombre"])
            tipo = "tm"
        } else {
            if (padre instanceof TipoMaquinaria) {
                hijos = Maquinaria.findAllByTipo(padre)
                tipo = "mq"
            }
        }

        hijos.each { hijo ->
            def id = "", clase = "", rel = "", label = ""

            if (tipo == "tm") {
                id = "liTm_" + hijo.id
                clase = "jstree-open"
                rel = "tipoMaquinaria"
                label = hijo.nombre
            } else if (tipo == "mq") {
                id = "liMq_" + hijo.id
                clase = "jstree-open"
                rel = "maquinaria"
                label = hijo.descripcion
            }

            arbol += "<li id='${id}' data-level='0' class='${clase}' data-jstree='{\"type\":\"${rel}\"}'>"
            arbol += "<a href='#' class='label_arbol'>${label}</a>"
            if (tipo != "bd") {
                arbol += "<ul>"
                arbol += imprimeHijos(hijo, params)
                arbol += "</ul>"
            }
            arbol += "</li>"
        }
        return arbol
    }

    /**
     * Acción llamada con ajax que permite realizar búsquedas en el árbol
     */
    def arbolSearch_ajax() {
        def search = params.str.trim()
        if (search != "") {
            def find = TipoMaquinaria.findAllByNombreIlike("%" + params.str.trim() + "%")
            def find2 = Maquinaria.findAllByDescripcionIlike("%" + params.str.trim() + "%")

            def tipos = (find + find2.tipo).unique()

            def ids = "["
            if (find.size() > 0) {
                ids += "\"#root\","
                tipos.each { TipoMaquinaria pr ->
                    ids += "\"#liTi_" + pr.id + "\","
                }
                ids = ids[0..-2]
            }
            ids += "]"
            render ids
        } else {
            render ""
        }
    }

}