package arazu.solicitudes

import arazu.seguridad.Persona

/**
 * Clase para conectar con la tabla 'dtrp' de la base de datos
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
            id column: 'dtrp__id'
            solicitud column: 'smin__id'
            persona column: 'prsn__id'
            horasTrabajo column: 'dtmohrtr'
            fecha column: 'dtmofcha'
            observaciones column: 'dtmoobsv'
            observaciones type: 'text'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        observaciones blank: true, nullable: true
    }
}
