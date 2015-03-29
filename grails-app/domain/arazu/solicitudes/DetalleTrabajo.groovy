package arazu.solicitudes

import arazu.parametros.TipoTrabajo

/**
 * Clase para conectar con la tabla 'dttr' de la base de datos
 */
class DetalleTrabajo {
    /**
     * Solicitud de mantenimiento externo que genera el detalle
     */
    SolicitudMantenimientoExterno solicitudMantenimientoExterno
    /**
     * Solicitud de mantenimiento interno que genera el detalle
     */
    SolicitudMantenimientoInterno solicitudMantenimientoInterno
    /**
     * Tipo de trabajo a realizar
     */
    TipoTrabajo tipoTrabajo
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'dttr'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort tipoTrabajo: "asc"
        columns {
            id column: 'dttr__id'
            solicitudMantenimientoExterno column: 'smex__id'
            solicitudMantenimientoInterno column: 'smin__id'
            tipoTrabajo column: 'tptr__id'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        solicitudMantenimientoExterno nullable: true
        solicitudMantenimientoInterno nullable: true
    }
}
