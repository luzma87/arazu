package arazu.inventario

import arazu.items.Item
import arazu.parametros.Unidad
import arazu.seguridad.Shield

class InventarioController extends Shield {

    def ingresoDeBodega(){
        def bodega
        def bodegas = []
        if(params.bodega){
            bodega=Bodega.get(params.bodega)
            if(session.usuario.id != bodega.persona.id){
                flash.message="Solo el responsable de bodega puede realizar ingresos."
                response.sendError("403")
            }else{
                bodegas.add(bodega)
            }
        }else{
            bodegas = Bodega.findAllByPersona(session.usuario)
        }
        def items = Item.list([sort: "descripcion"])
        def itemStr = ""
        itemStr+=items.collect{'"'+it.descripcion.trim()+'"'}

        //println "items "+itemStr
        [bodegas:bodegas,items:itemStr]
    }

    def saveIngreso(){
        println "save ingreso "+params
        def parts = params.data.split("\\|\\|")
        println "parts "+parts
        parts.each {
            if(it!=""){
                def data = it.split("!!")
                println "data "+data
                def ingreso = new Ingreso()
                ingreso.bodega=Bodega.get(params.bodega)
                ingreso.item=Item.findByDescripcion(data[0].trim())
                ingreso.cantidad=data[1].toDouble()
                ingreso.unidad=Unidad.get(data[2])
                ingreso.valor=data[3].toDouble()
                ingreso.saldo = data[1].toDouble()
                if(!ingreso.save(flush: true)){
                    println "error en el save de ingreso "+ingreso.errors
                }
            }

        }
        render "ok"
    }

    def inventario(){
        def bodega = Bodega.get(params.id)
        def ingresos = Ingreso.findAllByBodegaAndSaldoGreaterThan(bodega,0)
        [ingresos:ingresos,bodega:bodega]
    }
}
