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

    def listaPendientes(){

        def notas = Pedido.findAllByEstadoSolicitudAndPara(EstadoSolicitud.findByCodigo("E01"),session.usuario,[sort: "numero"])
        [notas:notas]
    }

    def revisar(){
        if(!params.id)
            response.sendError(404)
        def nota = Pedido.get(params.id)
        if(nota.para.id!=session.usuario.id){
            response.sendError(403)
        }
        if(nota.estadoSolicitud.codigo!="E01"){
            response.sendError(403)
        }
        def cots = Cotizacion.findAllByPedido(nota,[sort: "id"])
        [nota:nota,cots:cots]
    }

    def savaCotizacion(){
        println "save cotizacion "+params
        def cotizacion
        if(params.id){
            cotizacion= Cotizacion.get(params.id)
            cotizacion.properties=params
        }else{
            cotizacion = new Cotizacion(params)
        }
        cotizacion.fecha=new Date()
        cotizacion.estadoSolicitud= EstadoSolicitud.findByCodigo("E01")
        if(!cotizacion.save(flush: true)){
            flash.message=renderErrors(bean: cotizacion)
        }
        redirect(action: "revisar",id: params.pedido.id)
    }

    def enviarAprobacion(){

        def nota = Pedido.get(params.id)
        def cots = Cotizacion.findAllByPedido(nota,[sort: "id"])
        if(cots.size()<1){
            flash.message="Error: Está nota de pedido no tiene al menos una cotización"
            response.sendError(403)
        }else{
            nota.estadoSolicitud = EstadoSolicitud.findByCodigo("E04")
            nota.save(flush: true)
            flash.message="La nota de pedido número ${nota.numero} ha sido enviada para su aprobación"
            redirect(action: "listaPendientes")
        }
    }

    def listaAprobacion(){

        def notas = Pedido.findAllByEstadoSolicitud(EstadoSolicitud.findByCodigo("E04"),[sort: "numero"])
        [notas:notas]
    }


}
