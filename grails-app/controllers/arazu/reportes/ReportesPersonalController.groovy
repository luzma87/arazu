package arazu.reportes

import arazu.nomina.Asistencia
import arazu.nomina.PersonalProyecto
import arazu.parametros.TipoAsistencia
import arazu.proyectos.Proyecto
import arazu.seguridad.Persona

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
        def d = buscaAsistencias_funcion(params)
        return [datos: d.datos, tipos: d.tipos]
    }

    /**
     * Acción que muestra el reporte de asistencias en formato PDF
     */
    def reporteAsistenciasPdf() {
        def d = buscaAsistencias_funcion(params)
        return [datos: d.datos, tipos: d.tipos]
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
        def proyecto = null

        if (params.proyecto == "-1") {
            personas = Persona.list([sort: "apellido"])
        } else {
            proyecto = Proyecto.get(params.proyecto)
            personas = PersonalProyecto.findAllByProyecto(proyecto).persona
        }
        //println "personas "+personas
        def desde
        def hasta
        if (params.desde && params.desde != "") {
            desde = new Date().parse("dd-MM-yyyy", params.desde)
        } else {
            desde = new Date().parse("dd-MM-yyyy", "01-01-2015")
        }
        if (params.hasta && params.hasta != "") {
            hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        } else {
            hasta = new Date().parse("dd-MM-yyyy", "01-01-2115")
        }
        def asistencias = Asistencia.findAllByEmpleadoInListAndFechaBetween(personas, desde, hasta)
        asistencias = asistencias.sort { it.empleado.apellido }

        def asistencias2
        if (proyecto) {
            asistencias2 = Asistencia.findAllByProyectoAndFechaBetween(proyecto, desde, hasta)
        } else {
            asistencias2 = Asistencia.findAllByProyectoIsNotNullAndFechaBetween(desde, hasta)
        }

        def tipos = TipoAsistencia.list([sort: "id"])
        def datos = [:]
        asistencias2.each { a ->
            if (!datos["invitado_" + a.proyecto.id]) {
                def tmp = [:]
                tmp["proyecto"] = [a.proyecto]
                tmp["desayunos"] = a.desayunosInvitado
                tmp["almuerzos"] = a.almuerzosInvitado
                tmp["meriendas"] = a.meriendasInvitado
                datos["invitado_" + a.proyecto.id] = tmp
            } else {
                datos["invitado_" + a.proyecto.id]["desayunos"] += a.desayunosInvitado
                datos["invitado_" + a.proyecto.id]["almuerzos"] += a.almuerzosInvitado
                datos["invitado_" + a.proyecto.id]["meriendas"] += a.meriendasInvitado
            }
        }
        asistencias.each { a ->
            def p = a.empleado.getProyectoPorFecha(a.fecha)
            if (!proyecto || p == proyecto) {
                if (!datos[a.empleado]) {
                    def tmp = [:]
                    tipos.each { t ->
                        tmp[t.nombre] = 0
                    }
                    tmp["Horas extra 50%"] = a.horas50
                    tmp["Horas extra 100%"] = a.horas100

                    tmp["desayunos"] = 0
                    tmp["almuerzos"] = 0
                    tmp["meriendas"] = 0

                    if (a.desayuno == "S") {
                        tmp["desayunos"] = 1
                    }
                    if (a.almuerzo == "S") {
                        tmp["almuerzos"] = 1
                    }
                    if (a.merienda == "S") {
                        tmp["meriendas"] = 1
                    }

                    if (p) {
                        tmp["proyecto"] = [p]
                    } else {
                        tmp["proyecto"] = []
                    }
                    //println "tmp 1 " + tmp
                    tmp[a.tipo.nombre]++
                    //println "add temp "+tmp+"  "+a.tipo+"  "+a.empleado
                    datos[a.empleado] = tmp
                } else {
                    datos[a.empleado][a.tipo.nombre]++
                    datos[a.empleado]["Horas extra 50%"] += a.horas50
                    datos[a.empleado]["Horas extra 100%"] += a.horas100
                    if (a.desayuno == "S") {
                        datos[a.empleado]["desayunos"] += 1
                    }
                    if (a.almuerzo == "S") {
                        datos[a.empleado]["almuerzos"] += 1
                    }
                    if (a.merienda == "S") {
                        datos[a.empleado]["meriendas"] += 1
                    }
                    if (p) {
                        if (!datos[a.empleado]["proyecto"].contains(p)) {
                            datos[a.empleado]["proyecto"].add(p)
                        }
                    }
                    //println "plus "+datos[a.empleado][a.tipo.nombre]
                }
                datos[a.empleado]["proyecto"] = datos[a.empleado]["proyecto"].sort { it.nombre }
            }
        }
        datos = datos.sort { it.value.proyecto }
        return [datos: datos, tipos: tipos]
    }
}
