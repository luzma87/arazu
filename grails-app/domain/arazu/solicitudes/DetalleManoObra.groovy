package arazu.solicitudes

import arazu.seguridad.Persona

/**
 * Clase para conectar con la tabla 'dtrp' de la base de datos
 * Guarda los detalles de mano de obra de una solicitud de mantenimiento interno
 */
class DetalleManoObra {
    /**
     * Solicitud de mantenimiento que genera el detalle
     */
    SolicitudMantenimientoInterno solicitud
    /**
     * Persona
     */
    Persona persona
    /**
     * Horas de trabajo
     */
    Double horasTrabajo
    /**
     * Fecha
     */
    Date fecha
    /**
     * Observaciones
     */
    String observaciones
    /**
     * Indica si es planificado 'P' o real 'R'
     */
    String tipo = 'R'

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'dtmo'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dtmo__id'
            solicitud column: 'smin__id'
            persona column: 'prsn__id'
            horasTrabajo column: 'dtmohrtr'
            fecha column: 'dtmofcha'
            observaciones column: 'dtmoobsv'
            observaciones type: 'text'
            tipo column: 'dtmotipo'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        observaciones blank: true, nullable: true
    }
}
