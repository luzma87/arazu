package arazu.reportes

import arazu.nomina.Asistencia
import arazu.nomina.PersonalProyecto
import arazu.parametros.TipoAsistencia
import arazu.proyectos.Proyecto

class ReportesPersonalController {

    /**
     * Acción llamada con ajax que muestra una tabla con los resultados del filtro aplicado para el reporte de personal de proyecto
     */
    def reportePersonalProyecto_ajax() {
        return [personas: buscaPersonalProyecto_funcion(params)]
    }

    /**
     * Acción que muestra el reporte de personal de proyecto en formato PDF
     */
    def reportePersonalProyectoPdf() {
        return [personas: buscaPersonalProyecto_funcion(params)]
    }

    /**
     * Acción llamada con ajax que muestra una tabla con los resultados del filtro aplicado para el reporte de asistencias
     */
    def reporteAsistencias_ajax() {
        return [asistencia: buscaAsistencias_funcion(params)]
    }

    /**
     * Acción que muestra el reporte de asistencias en formato PDF
     */
    def reporteAsistenciasPdf() {
        return [asistencia: buscaAsistencias_funcion(params)]
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
                ge("fechaInicio", new Date().parse("dd-MM-yyyy HH:mm", params.desde + " 00:00"))
//                or {
//                    ge("fechaFin", new Date().parse("dd-MM-yyyy HH:mm", params.desde + " 23:59"))
//                    isNull("fechaFin")
//                }
            }
            if (params.hasta && params.hasta != "") {
//                le("fechaInicio", new Date().parse("dd-MM-yyyy HH:mm", params.hasta + " 00:00"))
                or {
                    le("fechaFin", new Date().parse("dd-MM-yyyy HH:mm", params.hasta + " 23:59"))
                    isNull("fechaFin")
                }
            }
        }
        return personal
    }

    /**
     * Función que recibe como parámetros los filtros ingresados por el usuario y retorna el arreglo de asistencias filtrado
     */
    def buscaAsistencias_funcion(params) {
        def personas = []
        if (params.proyecto && params.proyecto != "-1") {
            def proy = Proyecto.get(params.proyecto)
            personas = proy.personal.persona
        }
        def asistencia = Asistencia.withCriteria {
            if (personas.size() > 0) {
                inList("empleado", personas)
            }
            if (params.tipo) {
                eq("tipo", TipoAsistencia.get(params.tipo))
            }
            if (params.desde && params.desde != "") {
                ge("fecha", new Date().parse("dd-MM-yyyy HH:mm", params.desde + " 00:00"))
            }
            if (params.hasta && params.hasta != "") {
                le("fecha", new Date().parse("dd-MM-yyyy HH:mm", params.hasta + " 23:59"))
            }
        }
        return asistencia
    }
}
