package arazu.reportes

import arazu.inventario.Ingreso

class ReportesInventarioController {


    def ingresoDeBodega(){
        def ingreso = Ingreso.get(param.id)
        [ingreso:ingreso]
    }
}
