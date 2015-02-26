package arazu.reportes

import arazu.inventario.Ingreso
import arazu.solicitudes.Cotizacion
import arazu.solicitudes.Pedido

class ReportesInventarioController {


    def ingresoDeBodega() {
        def ingreso = Ingreso.get(params.id)
        if (!ingreso)
            response.sendError(404)
        [ingreso: ingreso]
    }

    def notaDePedido() {
        println "nota de pedido " + params
        def nota = Pedido.get(params.id)
        if (!nota)
            response.sendError(404)
        def cots = Cotizacion.findAllByPedido(nota)
        return [nota: nota, cots: cots]
    }
}
