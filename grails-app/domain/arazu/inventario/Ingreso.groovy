package arazu.inventario

import arazu.items.Item
import arazu.parametros.Unidad
import arazu.solicitudes.Pedido

class Ingreso {

    Unidad unidad
    Item item
    Bodega bodega
    Date fecha
    int cantidad
    Pedido pedido



    static constraints = {
    }
}
