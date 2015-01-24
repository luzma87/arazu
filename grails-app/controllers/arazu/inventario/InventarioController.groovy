package arazu.inventario

import arazu.items.Item
import arazu.seguridad.Shield

class InventarioController extends Shield {

    def ingresoDeBodega(){
        def bodegas = Bodega.findAllByPersona(session.usuario)
        def items = Item.list([sort: "descripcion"])
        def itemStr = ""
        itemStr+=items.collect{'"'+it.descripcion+'"'}

        println "items "+itemStr
        [bodegas:bodegas,items:itemStr]
    }
}
