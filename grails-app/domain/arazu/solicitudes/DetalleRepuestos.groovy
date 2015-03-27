package arazu.solicitudes

import arazu.items.Item

/**
 * Clase para conectar con la tabla 'dtrp' de la base de datos
 */
class DetalleRepuestos {
    /**
     * NotaPedido que genera el detalle
     */
    NotaPedido pedido
    /**
     * Repuesto utilizado
     */
    Item item
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
            pedido column: 'ntpd__id'
            item column: 'item__id'
        }
    }
}
