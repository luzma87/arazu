package arazu.parametros

import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Cargo
 */
class CargoController extends Shield {

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
            def c = Cargo.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            list = Cargo.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return cargoInstanceList: la lista de elementos filtrados, cargoInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def cargoInstanceList = getList(params, false)
        def cargoInstanceCount = getList(params, true).size()
        return [cargoInstanceList: cargoInstanceList, cargoInstanceCount: cargoInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return cargoInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if (params.id) {
            def cargoInstance = Cargo.get(params.id)
            if (!cargoInstance) {
                render "ERROR*No se encontró Cargo del Personal."
                return
            }
            return [cargoInstance: cargoInstance]
        } else {
            render "ERROR*No se encontró Cargo del Personal."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return cargoInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def band
        def cargoInstance = new Cargo()
        if (params.id) {
            cargoInstance = Cargo.get(params.id)
            if (!cargoInstance) {
                render "ERROR*No se encontró Cargo del Personal."
                return
            }
        }else{
            band = 1
            cargoInstance.properties = params
        }

        return [cargoInstance: cargoInstance, band: band]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        def cargoInstance = new Cargo()
        if (params.id) {
            cargoInstance = Cargo.get(params.id)
            if (!cargoInstance) {
                render "ERROR*No se encontró Cargo del Personal."
                return
            }
        }
        cargoInstance.properties = params
        if (!cargoInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Cargo del Personal: " + renderErrors(bean: cargoInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Cargo del Personal exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def cargoInstance = Cargo.get(params.id)
            if (!cargoInstance) {
                render "ERROR*No se encontró Cargo del Personal."
                return
            }
            try {
                cargoInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Cargo del Personal exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Cargo del Personal"
                return
            }
        } else {
            render "ERROR*No se encontró Cargo del Personal."
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
            def obj = Cargo.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render Cargo.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render Cargo.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

}
