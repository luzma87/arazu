package arazu.reportes

import arazu.nomina.PersonalProyecto
import arazu.proyectos.Proyecto

class ReportesPersonalController {

    /**
     * Acción llamada con ajax que muestra una tabla con los resultados del filtro aplicado para el reporte de personal de proyecto
     */
    def reportePersonalProyecto_ajax() {
        return [notas: buscaPersonalProyecto_funcion(params)]
    }

    /**
     * Acción que muestra el reporte de personal de proyecto en formato PDF
     */
    def reportePersonalProyectoPdf() {
        return [notas: buscaPersonalProyecto_funcion(params)]
    }

    /**
     * Función que recibe como parámetros los filtros ingresados por el usuario y retorna el arreglo de personal de proyecto filtrado
     */
    def buscaPersonalProyecto_funcion(params) {
        def personal = PersonalProyecto.withCriteria {
            if (params.proyecto && params.proyecto != "-1") {
                eq("proyecto", Proyecto.get(params.proyecto))
            }
            if (params.desde && params.desde != "") {
                or {
                    ge("fechaInicio", new Date().parse("dd-MM-yyyy", params.desde))
                    ge("fechaFin", new Date().parse("dd-MM-yyyy", params.desde))
                    isNull("fechaFin")
                }
            }
            if (params.hasta && params.hasta != "") {
                or {
                    le("fechaInicio", new Date().parse("dd-MM-yyyy", params.hasta))
                    le("fechaFin", new Date().parse("dd-MM-yyyy", params.hasta))
                    isNull("fechaFin")
                }
            }
        }
        return personal
    }
}
