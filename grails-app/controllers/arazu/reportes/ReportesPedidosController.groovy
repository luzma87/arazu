package arazu.reportes

import arazu.solicitudes.BodegaPedido
import arazu.solicitudes.Cotizacion
import arazu.solicitudes.NotaPedido
import arazu.solicitudes.SolicitudMantenimientoExterno

class ReportesPedidosController {

    def notaDePedido() {
        //println "nota de pedido " + params
        def nota = NotaPedido.get(params.id)
        if (!nota) {
            response.sendError(404)
        }
        def cots = Cotizacion.findAllByPedido(nota)
        def bodegas = BodegaPedido.findAllByPedido(nota)
        return [nota: nota, cots: cots, bodegas: bodegas]
    }

    def solicitudMantenimientoExterno() {
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        if (!solicitud) {
            response.sendError(404)
        }
        def cots = Cotizacion.findAllBySolicitudMantenimientoExterno(solicitud)
        return [solicitud: solicitud, cots: cots]
    }
}
