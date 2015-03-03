package arazu.solicitudes

import arazu.inventario.Bodega
import arazu.parametros.Unidad

/**
 * Clase para conectar con la tabla 'bdpd' de la base de datos
 */
class BodegaPedido {

    /**
     * Bodega de la cual se van a retirar los items
     */
    Bodega bodega
    /**
     * Pedido para el cual se van a retirar los items
     */
    Pedido pedido
    /**
     * Cantidad de items a retirar de la bodega
     */
    Double cantidad
    /**
     * Cantidad entregada
     */
    Double entregado = 0

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'bdpd'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort bodega: "asc"
        columns {
            id column: 'bdpd__id'
            bodega column: 'bdga__id'
            pedido column: 'pddo__id'
            cantidad column: 'bdpdcntd'
            entregado column: 'bdpdentr'
        }
    }
}
