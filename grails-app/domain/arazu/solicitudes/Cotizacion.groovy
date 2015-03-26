package arazu.solicitudes

import arazu.parametros.EstadoSolicitud

/**
 * Clase para conectar con la tabla 'ctzn' de la base de datos
 */
class Cotizacion {

    /**
     * NotaPedido para el cual se hace la cotización
     */
    NotaPedido pedido
    /**
     * Fecha en la que se hace la cotización
     */
    Date fecha
    /**
     * Proveedor de la cotización
     */
    String proveedor
    /**
     * Valor unitario de una unidad del item de la cotización
     */
    Double valor
    /**
     * Tiempo de entrega del pedido
     */
    Integer diasEntrega
    /**
     * Estado de la cotización
     */
    EstadoSolicitud estadoSolicitud
    /**
     * Fecha de aprobación o negación de la solicitud
     */
    Date fechaFin

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'ctzn'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort fecha: "desc"
        columns {
            id column: 'ctzn__id'
            pedido column: 'pddo__id'
            fecha column: 'ctznfcha'
            proveedor column: 'ctznprvd'
            valor column: 'ctznvlor'
            diasEntrega column: 'ctzndsen'
            estadoSolicitud column: 'essl__id'
            fechaFin column: 'ctznfcfn'
        }
    }
    static constraints = {
        proveedor(nullable: false, blank: false, size: 1..255)
        fechaFin nullable: true
    }
}
