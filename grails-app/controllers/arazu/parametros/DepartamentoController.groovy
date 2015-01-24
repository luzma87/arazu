package arazu.parametros

import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Departamento
 */
class DepartamentoController extends Shield {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    /**
     * Acción que muestra la estructura departamental en forma de árbol
     */
    def arbol() {
        return [arbol: makeTree()]
    }

    /**
     * Función que genera el árbol de estructura departamental
     */
    private String makeTree() {
        def lista = Departamento.findAllByPadreIsNull([sort: "nombre"]).id//Presupuesto.list(sort: "codigo")
        def res = ""
        res += "<ul>"
        res += "<li id='root' data-level='0' class='root jstree-open' data-jstree='{\"type\":\"root\"}'>"
        res += "<a href='#' class='label_arbol'>HINSA</a>"
        res += "<ul>"
        lista.each {
            res += imprimeHijos(it)
        }
        res += "</ul>"
        res += "</ul>"
    }

    /**
     * Función que genera las hojas del árbol de un padre específico
     */
    private String imprimeHijos(Long padre) {
//        def band = true
        def t = ""
        def txt = ""

        def dpto = Departamento.get(padre)
        def departamentos = Departamento.findAllByPadre(dpto)

        def clase = "jstree-open"
        def rel = "dpto"
        if (departamentos.size() > 0) {
            clase = ""
        }
        if (dpto.activo != 1) {
            rel += "Inactivo"
        }
        txt += "<li id='li_" + dpto.id + "' class='" + clase + "' data-jstree='{\"type\":\"${rel}\"}'>"
        txt += "<a href='#' class='label_arbol'>" + dpto + "</a>"
        txt += "<ul>"
        departamentos.each { h ->
            txt += imprimeHijos(h.id)
        }
        txt += "</ul>"
        txt += "</li>"

        return txt
    }

    /**
     * Acción que redirecciona al árbol
     */
    def index() {
        redirect(action: "arbol", params: params)
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
            def c = Departamento.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                    ilike("nombre", "%" + params.search + "%")
                }
            }
        } else {
            list = Departamento.list(params)
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
        def departamentoInstanceList = getList(params, false)
        def departamentoInstanceCount = getList(params, true).size()
        return [departamentoInstanceList: departamentoInstanceList, departamentoInstanceCount: departamentoInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def departamentoInstance = Departamento.get(params.id)
            if (!departamentoInstance) {
                render "ERROR*No se encontró Departamento."
                return
            }
            return [departamentoInstance: departamentoInstance]
        } else {
            render "ERROR*No se encontró Departamento."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def departamentoInstance = new Departamento()
        if (params.id) {
            departamentoInstance = Departamento.get(params.id)
            if (!departamentoInstance) {
                render "ERROR*No se encontró Departamento."
                return
            }
        }
        departamentoInstance.properties = params
        return [departamentoInstance: departamentoInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def departamentoInstance = new Departamento()
        if (params.id) {
            departamentoInstance = Departamento.get(params.id)
            if (!departamentoInstance) {
                render "ERROR*No se encontró Departamento."
                return
            }
        }
        departamentoInstance.properties = params
        if (!departamentoInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Departamento: " + renderErrors(bean: departamentoInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Departamento exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def departamentoInstance = Departamento.get(params.id)
            if (!departamentoInstance) {
                render "ERROR*No se encontró Departamento."
                return
            }
            try {
                departamentoInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Departamento exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Departamento"
                return
            }
        } else {
            render "ERROR*No se encontró Departamento."
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
            def obj = Departamento.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render Departamento.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render Departamento.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

}
