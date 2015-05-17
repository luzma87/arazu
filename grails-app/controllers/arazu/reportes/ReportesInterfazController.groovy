package arazu.reportes

import arazu.seguridad.Shield

/**
 * Controlador que muestra las pantallas de manejo de interfaces para el usuario de reportes
 */
class ReportesInterfazController extends Shield {

    /**
     * Acción que muestra la pantalla para filtrar e imprimir el reporte de notas de pedido
     */
    def notasDePedido() {
        def now = new Date()
        return [now: now]
    }

    /**
     * Acción que muestra la pantalla para filtrar e imprimir el reporte de solicitudes de mantenimiento externo
     */
    def mantenimientoExterno() {
        def now = new Date()
        return [now: now]
    }

    /**
     * Acción que muestra la pantalla para filtrar e imprimir el reporte de solicitudes de mantenimiento interno
     */
    def mantenimientoInterno() {
        def now = new Date()
        return [now: now]
    }

    /**
     * Acción que muestra la pantalla para filtrar e imprimir el reporte de bodegas
     */
    def bodegas() {
        def now = new Date()
        return [now: now]
    }

    /**
     * Acción que muestra la pantalla para filtrar e imprimir el reporte de personal de proyecto
     */
    def personalProyecto() {
        def now = new Date()
        return [now: now]
    }

    /**
     * Acción que muestra la pantalla para filtrar e imprimir el reporte de asistencias
     */
    def asistencias() {
        def now = new Date()
        return [now: now]
    }

    /**
     * Acción que muestra la pantalla para filtrar e imprimir el reporte de horas extra
     */
    def horasExtra() {
        def now = new Date()
        return [now: now]
    }
}
