package arazu.solicitudes

import arazu.items.Item

class NotaDePedidoController {

    def pedido(){
        def numero = Pedido.list([sort: "numero",order: "desc",limit:1])
        if(numero.size()>0)
            numero=numero.first().numero+1
        else
            numero=1
        def items = Item.list([sort: "descripcion"])
        def itemStr = ""
        itemStr += items.collect { '"' + it.descripcion.trim() + '"' }
        [numero:numero,items:itemStr]

    }

}
