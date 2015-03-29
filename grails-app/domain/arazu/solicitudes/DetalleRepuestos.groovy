package arazu.solicitudes

import arazu.items.Item

/**
 * Clase para conectar con la tabla 'dtrp' de la base de datos
 */
class DetalleRepuestos {
    /**
     * Solicitud de mantenimiento que genera el detalle
     */
    SolicitudMantenimientoInterno solicitud
    /**
     * Cantidad de repuesto utilizado
     */
    Double cantidad
    /**
     * Repuesto utilizado
     */
    Item item
    /**
     * C�digo o n�mero de parte
     */
    String codigo
    /**
     * Marca
     */
    String marca

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'dtrp'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: 'dtrp__id'
            solicitud column: 'smin__id'
            cantidad column: 'dtrpcntd'
            item column: 'item__id'
            codigo column: 'dtrpcdgo'
            marca column: 'dtrpmrca'
        }
    }
}
