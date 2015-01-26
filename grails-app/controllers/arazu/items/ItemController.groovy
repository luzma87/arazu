package arazu.items

import arazu.inventario.Ingreso
import arazu.parametros.Departamento
import arazu.parametros.TipoItem
import arazu.seguridad.Persona
import arazu.seguridad.TipoAccion
import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Item
 */
class ItemController extends Shield {

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
            def c = Item.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            list = Item.list(params)
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
        def itemInstanceList = getList(params, false)
        def itemInstanceCount = getList(params, true).size()
        return [itemInstanceList: itemInstanceList, itemInstanceCount: itemInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def itemInstance = Item.get(params.id)
            if (!itemInstance) {
                render "ERROR*No se encontró Item."
                return
            }
            return [itemInstance: itemInstance]
        } else {
            render "ERROR*No se encontró Item."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def itemInstance = new Item()
        if (params.id) {
            itemInstance = Item.get(params.id)
            if (!itemInstance) {
                render "ERROR*No se encontró Item."
                return
            }
        }
        if (params.msg)
            flash.message = params.msg
        itemInstance.properties = params
        return [itemInstance: itemInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def itemInstance = new Item()
        if (params.id) {
            itemInstance = Item.get(params.id)
            if (!itemInstance) {
                render "ERROR*No se encontró Item."
                return
            }
        }
        itemInstance.properties = params
        if (!itemInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Item: " + renderErrors(bean: itemInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Item exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def itemInstance = Item.get(params.id)
            if (!itemInstance) {
                render "ERROR*No se encontró Item."
                return
            }
            try {
                itemInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Item exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Item"
                return
            }
        } else {
            render "ERROR*No se encontró Item."
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
            hijos = TipoItem.list([sort: "nombre"])
            tipo = "ti"
        } else {
            if (padre instanceof TipoItem) {
                hijos = Item.findAllByTipo(padre)
                tipo = "it"
            } else if (padre instanceof Item) {
                def res = Ingreso.findAllByItemAndSaldoGreaterThan(padre, 0)
                hijos = [:]
                res.each { ing ->
                    if (!hijos[ing.item.id + "-" + ing.unidad.id]) {
                        hijos[ing.item.id + "-" + ing.unidad.id] = [:]
                        hijos[ing.item.id + "-" + ing.unidad.id].bodega = ing.bodega
                        hijos[ing.item.id + "-" + ing.unidad.id].item = ing.item
                        hijos[ing.item.id + "-" + ing.unidad.id].unidad = ing.unidad
                        hijos[ing.item.id + "-" + ing.unidad.id].saldo = ing.saldo
                    } else {
                        hijos[ing.item.id + "-" + ing.unidad.id].saldo += ing.saldo
                    }
                }
                tipo = "bd"
            }
        }

        hijos.each { hijo ->
            def id = "", clase = "", rel = "", label = ""

            if (tipo == "ti") {
                id = "liTi_" + hijo.id
                clase = "jstree-open"
                rel = "tipoItem"
                label = hijo.nombre
            } else if (tipo == "it") {
                id = "liIt_" + hijo.id
                clase = "jstree-open"
                rel = "item"
                label = hijo.descripcion
            } else if (tipo == "bd") {
                id = "liBd_" + hijo.key
                clase = ""
                rel = "bodega"
                label = hijo.value.bodega.descripcion + " (${hijo.value.saldo.toInteger()} ${hijo.value.unidad.codigo})"
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
            def find = TipoItem.findAllByNombreIlike("%" + params.str.trim() + "%")
            def find2 = Item.findAllByDescripcionIlike("%" + params.str.trim() + "%")

            def tipos = (find + find2.tipo).unique()

            def ids = "["
            if (find.size() > 0) {
                ids += "\"#root\","
                tipos.each { TipoItem pr ->
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
