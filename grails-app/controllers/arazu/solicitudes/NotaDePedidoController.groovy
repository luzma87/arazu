package arazu.solicitudes

import arazu.items.Item
import arazu.parametros.EstadoSolicitud

class NotaDePedidoController {

    def pedido(){
        def numero = Pedido.list([sort: "numero",order: "desc",limit:1])
        if(numero.size()>0)
            numero=numero.first().numero+1
        else
            numero=1
        session.numero = numero
        def items = Item.list([sort: "descripcion"])
        def itemStr = ""
        itemStr += items.collect { '"' + it.descripcion.trim() + '"' }
        [numero:numero,items:itemStr]

    }

    def saveSolicitud(){
        println "save solicitud "+params

        def item = Item.findByDescripcion(params.item.trim())
        params.remove("item")
        params["item.id"]=item.id
        def solicitud = new Pedido(params)
        solicitud.estadoSolicitud = EstadoSolicitud.findByCodigo("E01")
        solicitud.fecha=new Date()
        solicitud.de=session.usuario
        solicitud.numero=session.numero
        solicitud.codigo="NP-"+session.numero
        if(!solicitud.save(flush: true)){
            println "error  "+solicitud.errors
            flash.message="Error al guardar la solicitud"
            redirect(action: "pedido")
        }else{
            flash.message="Solicitud envidada"
            redirect(action: "lista")
        }

    }
    def lista(){
        def notas = Pedido.findAllByEstadoSolicitudNotEqual(EstadoSolicitud.findByCodigo("E03"),[sort: "numero"])
        [notas:notas]
    }

}
