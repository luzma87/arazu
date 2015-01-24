package arazu.inventario

class InventarioController {

    def ingresoDeBodega(){
        def bodegas = Bodega.findAllByPersona(session.usuario)
        [bodegas:bodegas]
    }
}
