package arazu.parametros

import arazu.seguridad.Persona
import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de TipoUsuario
 */
class TipoUsuarioController extends Shield {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    /**
     * Acción que muestra la estructura departamental en forma de árbol
     */
    def arbol() {
        if (!params.inactivos) {
            params.inactivos = "S"
        }
        return [arbol: makeTree_funcion(params), params: params]
    }

    /**
     * Acción que muestra la estructura departamental en forma de árbol para administración
     */
    def arbolAdmin() {
        if (!params.inactivos) {
            params.inactivos = "S"
        }
        return [arbol: makeTree_funcion(params), params: params]
    }

    /**
     * Función que genera el árbol de estructura departamental
     */
    private String makeTree_funcion(params) {
        def res = ""
        res += "<ul>"
        res += "<li id='root' data-level='0' class='root jstree-open' data-jstree='{\"type\":\"root\"}'>"
        res += "<a href='#' class='label_arbol'>HINSA</a>"
        res += "<ul>"
        res += imprimeTipoUsuarios_funcion(null, params)
        res += "</li>"
        res += "</ul>"
        return res
    }

    /**
     * Función que genera las hojas tipo tipoUsuario del árbol de un padre específico
     */
    private String imprimeUsuario_funcion(Persona usuario, params) {
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
        if (usuario.mail) {
            txt += " - " + usuario.mail
        } else {
            txt += " - <span class='text-danger'><i class='fa fa-envelope-o'></i> No ha registrado un e-mail! No podrá recibir notificaciones ni reestablecer contraseñas</span>"
        }
        if (usuario.activo != 1) {
            txt += "</span>"
        }
        txt += "</a>"
        txt += "</li>"

        return txt
    }

    /**
     * Función que genera las hojas tipo tipoUsuario del árbol de un padre específico
     */
    private String imprimeTipoUsuarios_funcion(TipoUsuario dpto, params) {
        def txt = ""
        def activos = [1]
        if (params.inactivos == "S") {
            activos = [0, 1]
        }
        def hijosDep = 0, hijosUsu = 0;

        def tipoUsuarios, usuarios
        if (dpto) {
            tipoUsuarios = TipoUsuario.findAllByPadreAndActivoInList(dpto, activos)
            usuarios = Persona.findAllByTipoUsuarioAndActivoInList(dpto, activos)
            hijosDep = TipoUsuario.countByPadre(dpto)
            hijosUsu = Persona.countByTipoUsuario(dpto)
        } else {
            tipoUsuarios = TipoUsuario.findAllByPadreIsNullAndActivoInList(activos, [sort: "nombre"])
            usuarios = Persona.findAllByTipoUsuarioIsNullAndActivoInList(activos, [sort: "apellido"])
            hijosDep = tipoUsuarios.size()
            hijosUsu = usuarios.size()
        }
        if (dpto) {
            def clase = "jstree-open"
            def rel = "dpto"
            if (tipoUsuarios.size() > 0) {
                clase = ""
            }
            if (dpto.activo != 1) {
                rel += "Inactivo"
            }
            txt += "<li title='test' id='liDep_" + dpto.id + "' class='" + clase + "' data-hijos='${hijosDep + hijosUsu}' data-jstree='{\"type\":\"${rel}\"}'>"
            txt += "<a href='#' class='label_arbol'>"
            if (dpto.activo != 1) {
                txt += "<span class='text-muted'>"
            }
            txt += dpto.nombre + " (" + dpto.codigo + ") - <span class='text-info small'>" + dpto.descripcion + "</span>"
            if (dpto.activo != 1) {
                txt += "</span>"
            }
            txt += "</a>"
            txt += "<ul>"
        }
        usuarios.each { usu ->
            txt += imprimeUsuario_funcion(usu, params)
        }
        tipoUsuarios.each { h ->
            txt += imprimeTipoUsuarios_funcion(h, params)
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
                    tipoUsuario {
                        ilike("nombre", "%" + search + "%")
                        ilike("codigo", "%" + search + "%")
                    }
                }
            }
            def find2 = TipoUsuario.withCriteria {
                or {
                    ilike("nombre", "%" + search + "%")
                    ilike("codigo", "%" + search + "%")
                }
            }
            def tipoUsuarios = []
            (find.tipoUsuario + find2).each { TipoUsuario dp ->
                if (dp && !tipoUsuarios.contains(dp)) {
                    def pr = dp
                    while (pr) {
                        if (pr && !tipoUsuarios.contains(pr)) {
                            tipoUsuarios.add(pr)
                        }
                        pr = pr.padre
                    }
                }
            }
            tipoUsuarios = tipoUsuarios.reverse()

            def ids = "["
            if (find.size() > 0) {
                ids += "\"#root\","
                tipoUsuarios.each { TipoUsuario pr ->
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
            def c = TipoUsuario.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                    ilike("nombre", "%" + params.search + "%")
                }
            }
        } else {
            list = TipoUsuario.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList_funcion(params, all)
        }
        return list
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def tipoUsuarioInstance = TipoUsuario.get(params.id)
            if (!tipoUsuarioInstance) {
                render "ERROR*No se encontró Tipo de Usuario."
                return
            }
            return [tipoUsuarioInstance: tipoUsuarioInstance]
        } else {
            render "ERROR*No se encontró Tipo de Usuario."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def tipoUsuarioInstance = new TipoUsuario()
        if (params.id) {
            tipoUsuarioInstance = TipoUsuario.get(params.id)
            if (!tipoUsuarioInstance) {
                render "ERROR*No se encontró Tipo de Usuario."
                return
            }
        }
        tipoUsuarioInstance.properties = params
        if (params.padre) {
            def padre = TipoUsuario.get(params.padre.toLong())
            tipoUsuarioInstance.padre = padre
        }
        return [tipoUsuarioInstance: tipoUsuarioInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def tipoUsuarioInstance = new TipoUsuario()
        if (params.id) {
            tipoUsuarioInstance = TipoUsuario.get(params.id)
            if (!tipoUsuarioInstance) {
                render "ERROR*No se encontró Tipo de Usuario."
                return
            }
        }
        if (params.codigo) {
            params.codigo = params.codigo.toString().toUpperCase()
        }
        tipoUsuarioInstance.properties = params
        if (!tipoUsuarioInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Tipo de Usuario: " + renderErrors(bean: tipoUsuarioInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Tipo de Usuario exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def tipoUsuarioInstance = TipoUsuario.get(params.id)
            if (!tipoUsuarioInstance) {
                render "ERROR*No se encontró Tipo de Usuario."
                return
            }
            try {
                tipoUsuarioInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Tipo de Usuario exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Tipo de Usuario"
                return
            }
        } else {
            render "ERROR*No se encontró Tipo de Usuario."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción llamada con ajax que permite activar/desactivar un tipoUsuario
     */
    def cambiarActivo_ajax() {
        def dep = TipoUsuario.get(params.id)
        dep.activo = params.activo.toInteger()
        if (dep.save(flush: true)) {
            render "SUCCESS*Tipo de Usuario " + (dep.activo == 1 ? "activado" : "desactivado") + " exitosamente"
        } else {
            render "ERROR*" + renderErrors(bean: dep)
        }
    }

    /**
     * Acción llamada con ajax que permite modificar el padre de un tipoUsuario
     */
    def cambiarPadre_ajax() {
//        println "CAMBAIR PADRE:::: " + params
        def dep = TipoUsuario.get(params.id.toLong())
        def padre = null
        if (params.padre) {
            padre = TipoUsuario.get(params.padre.toLong())
        }
        dep.padre = padre
        if (dep.save(flush: true)) {
            render "SUCCESS*Tipo de Usuario reubicado exitosamente"
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
            def obj = TipoUsuario.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render TipoUsuario.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render TipoUsuario.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

}
