package arazu.reportes

import arazu.inventario.Ingreso
import arazu.solicitudes.BodegaPedido
import arazu.solicitudes.Cotizacion
import arazu.solicitudes.Pedido

class ReportesInventarioController {
    def ingresoDeBodega() {
        def ingreso = Ingreso.get(params.id)
        if (!ingreso)
            response.sendError(404)
        [ingreso: ingreso]
    }
}
