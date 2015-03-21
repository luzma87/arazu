package arazu.reportes

import arazu.inventario.Ingreso

class ReportesInventarioController {
    def ingresoDeBodega() {
        def ingreso = Ingreso.get(params.id)
        if (!ingreso)
            response.sendError(404)
        [ingreso: ingreso]
    }
}
