package arazu.solicitudes

import arazu.parametros.TipoTrabajo

/**
 * Clase para conectar con la tabla 'dttr' de la base de datos
 */
class DetalleTrabajo {
    /**
     * NotaPedido que genera el detalle
     */
    SolicitudMantenimientoExterno solicitud
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
            solicitud column: 'smex__id'
            tipoTrabajo column: 'tptr__id'
        }
    }
}
