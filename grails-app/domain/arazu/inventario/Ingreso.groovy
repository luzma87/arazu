package arazu.inventario

import arazu.items.Item
import arazu.parametros.Unidad
import arazu.solicitudes.Pedido

class Ingreso {

    Unidad unidad
    Item item
    Bodega bodega
    Date fecha = new Date()
    int cantidad = 1
    Pedido pedido


/**
 * Define los campos que se van a ignorar al momento de hacer logs
 */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'ingr'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort fecha: "asc"
        columns {
            id column: 'ingr__id'
            unidad column: 'undd__id'
            item column: 'item__id'
            bodega column: 'bdga__id'
            fecha column: 'ingrfcha'
            cantidad column: 'ingrcant'
            pedido column: 'pddo__id'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        unidad(nullable: false,blank: false)
        fecha(nullable: false,blank: false)
        item(nullable: false,blank: false)
        bodega(nullable: false,blank: false)
        fecha(nullable: false,blank: false)
        pedido(nullable: false,blank: false)

    }
}
