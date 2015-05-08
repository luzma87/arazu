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
        def desde = null, hasta = null
        if (params.desde) {
            desde = new Date().parse("dd-MM-yyyy", params.desde)
        }
        if (params.hasta) {
            hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        }
        def bodegasIds = params.bodegas.split(",")*.toLong()
        def bodegas = Bodega.findAllByIdInList(bodegasIds)
        def tiposDatos = params.datos.split(",")
        return [datos: reporteBodegas_funcion(bodegas, tiposDatos, desde, hasta)]
    }

    def bodegasPdf() {
        def desde = null, hasta = null
        if (params.desde) {
            desde = new Date().parse("dd-MM-yyyy", params.desde)
        }
        if (params.hasta) {
            hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        }
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
        if (desde) {
            title += " desde el " + desde.format("dd-MM-yyyy")
        }
        if (hasta) {
            title += " hasta el " + hasta.format("dd-MM-yyyy")
        }
        return [datos: reporteBodegas_funcion(bodegas, tiposDatos, desde, hasta), title: title]
    }

    def reporteBodegas_funcion(bodegas, tiposDatos, desde, hasta) {
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
                    if (desde) {
                        ge("fecha", desde)
                    }
                    if (hasta) {
                        le("fecha", hasta)
                    }
                    order("fecha", "desc")
                }
                datos[bd.id].ingresos = arr
            }
            if (tiposDatos.contains("ind")) {
                def arr = Ingreso.withCriteria {
                    eq("bodega", bd)
                    gt("saldo", 0.toDouble())
                    eq("desecho", 1)
                    if (desde) {
                        ge("fecha", desde)
                    }
                    if (hasta) {
                        le("fecha", hasta)
                    }
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
                    if (desde) {
                        ge("fecha", desde)
                    }
                    if (hasta) {
                        le("fecha", hasta)
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
                    if (desde) {
                        ge("fecha", desde)
                    }
                    if (hasta) {
                        le("fecha", hasta)
                    }
                    order("fecha", "desc")
                }
                datos[bd.id].egresosDesecho = arr
            }
        }
        return datos
    }

}
