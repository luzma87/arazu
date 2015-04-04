package arazu.reportes

import arazu.inventario.Bodega
import arazu.inventario.Egreso
import arazu.inventario.Ingreso

class ReportesInventarioController {

    def ingresoDeBodega() {
        def ingreso = Ingreso.get(params.id)
        if (!ingreso) {
            response.sendError(404)
        }
        return [ingreso: ingreso]
    }

    def ingresoDeDesechoBodega() {
        def ingreso = Ingreso.get(params.id)
        if (!ingreso) {
            response.sendError(404)
        }
        return [ingreso: ingreso]
    }

    def bodegas_ajax() {
        def bodegasIds = params.bodegas.split(",")*.toLong()
        def bodegas = Bodega.findAllByIdInList(bodegasIds)
        def tiposDatos = params.datos.split(",")
        return [datos: reporteBodegas_funcion(bodegas, tiposDatos)]
    }

    def bodegasPdf() {
        def bodegasIds = params.bodegas.split(",")*.toLong()
        def bodegas = Bodega.findAllByIdInList(bodegasIds)
        def tiposDatos = params.datos.split(",")
        def title = "Reporte de "
        def d = ""
        tiposDatos.each { td ->
            if (td == "in") {
                d += " Ingresos"
            }
            if (td == "out") {
                if (d != "") {
                    d += ", "
                }
                d += "Egresos"
            }
            if (td == "ind") {
                if (d != "") {
                    d += ", "
                }
                d += "Ingresos de desechos"
            }
            if (td == "outd") {
                if (d != "") {
                    d += ", "
                }
                d += "Egresos de desechos"
            }
        }
        def b = ""
        bodegas.each { bd ->
            if (b != "") {
                b += ", "
            }
            b += bd.toString()
        }
        title += d + " de la${bodegas.size() == 1 ? '' : 's'} bodega${bodegas.size() == 1 ? '' : 's'} " + b
        return [datos: reporteBodegas_funcion(bodegas, tiposDatos), title: title]
    }

    def reporteBodegas_funcion(bodegas, tiposDatos) {
        def datos = [:]

        bodegas.each { bd ->
            datos[bd.id] = [
                    bodega         : bd,
                    ingresos       : [],
                    egresos        : [],
                    ingresosDesecho: [],
                    egresosDesecho : [],
            ]
            if (tiposDatos.contains("in")) {
                def arr = Ingreso.withCriteria {
                    eq("bodega", bd)
                    gt("saldo", 0.toDouble())
                    eq("desecho", 0)
                    order("fecha", "desc")
                }
                datos[bd.id].ingresos = arr
            }
            if (tiposDatos.contains("ind")) {
                def arr = Ingreso.withCriteria {
                    eq("bodega", bd)
                    gt("saldo", 0.toDouble())
                    eq("desecho", 1)
                    order("fecha", "desc")
                }
                datos[bd.id].ingresosDesecho = arr
            }
            if (tiposDatos.contains("out")) {
                def arr = Egreso.withCriteria {
                    ingreso {
                        eq("bodega", bd)
                        eq("desecho", 0)
                    }
                    order("fecha", "desc")
                }
                datos[bd.id].egresos = arr
            }
            if (tiposDatos.contains("outd")) {
                def arr = Egreso.withCriteria {
                    ingreso {
                        eq("bodega", bd)
                        eq("desecho", 1)
                    }
                    order("fecha", "desc")
                }
                datos[bd.id].egresosDesecho = arr
            }
        }
        return datos
    }

}
