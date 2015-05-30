package arazu.alertas

import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Alerta
 */
class AlertaController extends Shield {

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
            def c = Alerta.createCriteria()
            list = c.list(params) {
                eq("recibe", session.usuario)
                isNull("fechaRecibido")
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("accion", "%" + params.search + "%")
                    ilike("controlador", "%" + params.search + "%")
                    ilike("mensaje", "%" + params.search + "%")
                }
            }
        } else {
            list = Alerta.findAllByRecibeAndFechaRecibidoIsNull(session.usuario, params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList_funcion(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return alertaInstanceList: la lista de elementos filtrados, alertaInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def alertaInstanceList = getList_funcion(params, false)
        def alertaInstanceCount = getList_funcion(params, true).size()
        return [alertaInstanceList: alertaInstanceList, alertaInstanceCount: alertaInstanceCount]
    }
    /**
     * Acción que muestra la lista de elementos
     * @return alertaInstanceList: la lista de elementos filtrados, alertaInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list_ajax() {
        def alertaInstanceList = getList_funcion(params, false)
        def alertaInstanceCount = getList_funcion(params, true).size()
        return [alertaInstanceList: alertaInstanceList, alertaInstanceCount: alertaInstanceCount]
    }

    /**
     * Acción que redirecciona a la acción necesaria según la alerta
     */
    def showAlerta = {
        def alerta = Alerta.get(params.id)

        println "ALERTA:::: " + alerta.id + "  " + alerta.controlador + "/" + alerta.accion

        alerta.fechaRecibido = new Date()
        alerta.save(flush: true)
        params.id = alerta.id_remoto
        redirect(controller: alerta.controlador, action: alerta.accion, params: params)
    }

    /**
     * Acción llamada con ajax que marca una alerta como leída para que no se muestre en la lista
     */
    def marcarLeida_ajax() {
        def alerta = Alerta.get(params.id)
        alerta.fechaRecibido = new Date()
        alerta.save(flush: true)
        def alertaInstanceCount = getList_funcion(params, true).size()
        render alertaInstanceCount
    }
}
