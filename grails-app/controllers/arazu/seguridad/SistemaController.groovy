package arazu.seguridad

import arazu.alertas.Alerta
import arazu.inventario.Bodega
import arazu.parametros.EstadoSolicitud
import arazu.proyectos.Proyecto
import arazu.solicitudes.NotaPedido
import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Sistema
 */
class SistemaController extends Shield {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    def limitGreen = 2
    def limitYellow = 5

    def classGreen = "card-bg-green"
    def classYellow = "svt-bg-warning"
    def classRed = "svt-bg-danger"

    /**
     * Acción que muestra el seleccionador de sistema
     */
    def index() {

    }

    /**
     * Acción que muestra el dashboard de administración
     */
    def inicioAdmin() {
        def sistema = Sistema.findByCodigo("ADMN")
        session.sistema = sistema

        def bodegas = Bodega.findAllByActivo(1)
        def proyectos = Proyecto.findAllByFechaFinIsNullOrFechaFinGreaterThan(new Date())
        return [bodegas: bodegas, proyectos: proyectos]
    }

    /**
     * Acción que muestra el dashboard de nómina
     */
    def inicioNomina() {
        def sistema = Sistema.findByCodigo("NMNA")
        session.sistema = sistema
    }

    /**
     * Acción que muestra el dashboard de solicitudes
     */
    def inicioSolicitudes() {
        def sistema = Sistema.findByCodigo("SLCT")
        session.sistema = sistema

        def np = [
                E01: [
                        estado: EstadoSolicitud.findByCodigo("E01"), // NP pendiente de aprobacion
                        cant  : 0,
                        clase : classGreen
                ],
                E02: [
                        estado: EstadoSolicitud.findByCodigo("E02"), // NP pendiente de asignacion
                        cant  : 0,
                        clase : classGreen
                ],
                E03: [
                        estado: EstadoSolicitud.findByCodigo("E03"), // NP pendientes cotizaciones
                        cant  : 0,
                        clase : classGreen
                ],
                E04: [
                        estado: EstadoSolicitud.findByCodigo("E04"), // NP pendiente de aprobacion final
                        cant  : 0,
                        clase : classGreen
                ],
                A01: [
                        estado: EstadoSolicitud.findByCodigo("A01"), // NP aprobada
                        cant  : 0,
                        clase : classGreen
                ],
                B01: [
                        estado: EstadoSolicitud.findByCodigo("B01"), // NP en bodega
                        cant  : 0,
                        clase : classGreen
                ]
        ]

        def mx = [
                E11: [
                        estado: EstadoSolicitud.findByCodigo("E11"), // MX pendiente de asignacion
                        cant  : 0,
                        clase : classGreen
                ],
                E12: [
                        estado: EstadoSolicitud.findByCodigo("E12"), // MX pendientes cotizaciones
                        cant  : 0,
                        clase : classGreen
                ],
                E13: [
                        estado: EstadoSolicitud.findByCodigo("E13"), // MX pendiente de aprobacion final
                        cant  : 0,
                        clase : classGreen
                ]
        ]

        def mi = [
                E21: [
                        estado: EstadoSolicitud.findByCodigo("E21"), // MI pendiente de aprobacion final
                        cant  : 0,
                        clase : classGreen
                ],
                A21: [
                        estado: EstadoSolicitud.findByCodigo("A21"), // MI aprobadas
                        cant  : 0,
                        clase : classGreen
                ]
        ]

        (np + mx + mi).each { k, v ->
            v.cant = NotaPedido.countByEstadoSolicitud(v.estado)
            if (v.cant >= limitGreen) {
                v.clase = classYellow
            }
            if (v.cant >= limitYellow) {
                v.clase = classRed
            }
        }

        return [np: np, mx: mx, mi: mi]
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
        if (!params.sort) {
            params.sort = "orden"
        }
        def list
        if (params.search) {
            def c = Sistema.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                    ilike("icono", "%" + params.search + "%")
                    ilike("nombre", "%" + params.search + "%")
                    ilike("pathImagen", "%" + params.search + "%")
                }
            }
        } else {
            list = Sistema.list(params)
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
        def sistemaInstanceList = getList_funcion(params, false)
        def sistemaInstanceCount = getList_funcion(params, true).size()
        return [sistemaInstanceList: sistemaInstanceList, sistemaInstanceCount: sistemaInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def sistemaInstance = Sistema.get(params.id)
            if (!sistemaInstance) {
                render "ERROR*No se encontró Sistema."
                return
            }
            return [sistemaInstance: sistemaInstance]
        } else {
            render "ERROR*No se encontró Sistema."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def sistemaInstance = new Sistema()
        if (params.id) {
            sistemaInstance = Sistema.get(params.id)
            if (!sistemaInstance) {
                render "ERROR*No se encontró Sistema."
                return
            }
        }
        sistemaInstance.properties = params
        return [sistemaInstance: sistemaInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def sistemaInstance = new Sistema()
        if (params.id) {
            sistemaInstance = Sistema.get(params.id)
            if (!sistemaInstance) {
                render "ERROR*No se encontró Sistema."
                return
            }
        }
        sistemaInstance.properties = params
        if (!sistemaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Sistema: " + renderErrors(bean: sistemaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Sistema exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def sistemaInstance = Sistema.get(params.id)
            if (!sistemaInstance) {
                render "ERROR*No se encontró Sistema."
                return
            }
            try {
                sistemaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Sistema exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Sistema"
                return
            }
        } else {
            render "ERROR*No se encontró Sistema."
            return
        }
    } //delete para eliminar via ajax

}
