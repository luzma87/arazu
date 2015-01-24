package arazu.parametros

import arazu.seguridad.Persona
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
        if (!params.inactivos) {
            params.inactivos = "S"
        }
        return [arbol: makeTree(params), params: params]
    }

    /**
     * Función que genera el árbol de estructura departamental
     */
    private String makeTree(params) {
        def res = ""
        res += "<ul>"
        res += "<li id='root' data-level='0' class='root jstree-open' data-jstree='{\"type\":\"root\"}'>"
        res += "<a href='#' class='label_arbol'>HINSA</a>"
        res += "<ul>"
        res += imprimeDepartamentos(null, params)
        res += "</ul>"
        res += "</ul>"
        return res
    }

    /**
     * Función que genera las hojas tipo departamento del árbol de un padre específico
     */
    private String imprimeUsuario(Persona usuario, params) {
        def txt = ""

        def rel = "usuario"
        if (usuario.activo != 1) {
            rel += "Inactivo"
        }

        txt += "<li id='liUsu_" + usuario.id + "' data-jstree='{\"type\":\"${rel}\"}'>"
        txt += "<a href='#' class='label_arbol'>"
        if (usuario.activo != 1) {
            txt += "<span class='text-muted'>"
        }
        txt += usuario.apellido + " " + usuario.nombre + " (" + usuario.login + ")"
        if (usuario.activo != 1) {
            txt += "</span>"
        }
        txt += "</a>"
        txt += "</li>"

        return txt
    }

    /**
     * Función que genera las hojas tipo departamento del árbol de un padre específico
     */
    private String imprimeDepartamentos(Departamento dpto, params) {
        def txt = ""
        def activos = [1]
        if (params.inactivos == "S") {
            activos = [0, 1]
        }
        def hijosDep = 0, hijosUsu = 0;

        def departamentos, usuarios
        if (dpto) {
            departamentos = Departamento.findAllByPadreAndActivoInList(dpto, activos)
            usuarios = Persona.findAllByDepartamentoAndActivoInList(dpto, activos)
            hijosDep = Departamento.countByPadre(dpto)
            hijosUsu = Persona.countByDepartamento(dpto)
        } else {
            departamentos = Departamento.findAllByPadreIsNullAndActivoInList(activos, [sort: "nombre"])
            usuarios = Persona.findAllByDepartamentoIsNullAndActivoInList(activos, [sort: "apellido"])
            hijosDep = departamentos.size()
            hijosUsu = usuarios.size()
        }
        if (dpto) {
            def clase = "jstree-open"
            def rel = "dpto"
            if (departamentos.size() > 0) {
                clase = ""
            }
            if (dpto.activo != 1) {
                rel += "Inactivo"
            }
            txt += "<li id='liDep_" + dpto.id + "' class='" + clase + "' data-hijos='${hijosDep + hijosUsu}' data-jstree='{\"type\":\"${rel}\"}'>"
            txt += "<a href='#' class='label_arbol'>"
            if (dpto.activo != 1) {
                txt += "<span class='text-muted'>"
            }
            txt += dpto.nombre + " (" + dpto.codigo + ")"
            if (dpto.activo != 1) {
                txt += "</span>"
            }
            txt += "</a>"
            txt += "<ul>"
        }
        usuarios.each { usu ->
            txt += imprimeUsuario(usu, params)
        }
        departamentos.each { h ->
            txt += imprimeDepartamentos(h, params)
        }
        if (dpto) {
            txt += "</ul>"
            txt += "</li>"
        }
        return txt
    }

    /**
     * Acción llamada con ajax que permite realizar búsquedas en el árbol
     */
    def arbolSearch_ajax() {
        def search = params.str.trim()
        if (search != "") {
            def find = Persona.withCriteria {
                or {
                    ilike("nombre", "%" + search + "%")
                    ilike("apellido", "%" + search + "%")
                    ilike("login", "%" + search + "%")
                    departamento {
                        ilike("nombre", "%" + search + "%")
                        ilike("codigo", "%" + search + "%")
                    }
                }
            }
            def find2 = Departamento.withCriteria {
                or {
                    ilike("nombre", "%" + search + "%")
                    ilike("codigo", "%" + search + "%")
                }
            }
            def departamentos = []
            (find.departamento + find2).each { Departamento dp ->
                if (dp && !departamentos.contains(dp)) {
                    def pr = dp
                    while (pr) {
                        if (pr && !departamentos.contains(pr)) {
                            departamentos.add(pr)
                        }
                        pr = pr.padre
                    }
                }
            }
            departamentos = departamentos.reverse()

            def ids = "["
            if (find.size() > 0) {
                ids += "\"#root\","
                departamentos.each { Departamento pr ->
                    ids += "\"#liDep_" + pr.id + "\","
                }
                ids = ids[0..-2]
            }
            ids += "]"
            render ids
        } else {
            render ""
        }
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
        if (params.padre) {
            def padre = Departamento.get(params.padre.toLong())
            departamentoInstance.padre = padre
        }
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
     * Acción llamada con ajax que permite activar/desactivar un departamento
     */
    def cambiarActivo_ajax() {
        def dep = Departamento.get(params.id)
        dep.activo = params.activo.toInteger()
        if (dep.save(flush: true)) {
            render "SUCCESS*Departamento " + (dep.activo == 1 ? "activado" : "desactivado") + " exitosamente"
        } else {
            render "ERROR*" + renderErrors(bean: dep)
        }
    }

    /**
     * Acción llamada con ajax que permite modificar el padre de un departamento
     */
    def cambiarPadre_ajax() {
        def dep = Departamento.get(params.id.toLong())
        def padre = Departamento.get(params.padre.toLong())
        if (padre) {
            dep.padre = padre
        } else {
            dep.padre = null
        }
        if (dep.save(flush: true)) {
            render "SUCCESS*Departamento reubicado exitosamente"
        } else {
            render "ERROR*" + renderErrors(bean: dep)
        }
    }

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
