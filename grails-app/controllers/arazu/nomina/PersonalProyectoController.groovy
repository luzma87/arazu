package arazu.nomina

import arazu.proyectos.Proyecto
import arazu.seguridad.Persona
import arazu.seguridad.Shield

/**
 * Controlador que muestra las pantallas de manejo de PersonalProyecto
 */
class PersonalProyectoController extends Shield {

    def agregarPersonalProyecto_ajax() {
        def ids = params.ids.split(",")
        def proyecto = Proyecto.get(params.id)
//        List<PersonalProyecto> personal = []
        def c = 0
        Persona.findAllByIdInList(ids*.toLong()).each { p ->
            def personalProyecto = new PersonalProyecto()
            personalProyecto.fechaInicio = new Date()
            personalProyecto.persona = p
            personalProyecto.proyecto = proyecto
            if (!personalProyecto.save(flush: true)) {
                println "Error al asignar ${p} al proyecto ${proyecto}"
            } else {
                c++
//                personal += personalProyecto
            }
        }
        render "SUCCESS*${c} de ${ids.size()} personas asignadas correctamente"
//        return [personal: personal]
    }

    def quitarPersonalProyecto_ajax() {
        def ids = params.ids.split(",")
        def c = 0
        PersonalProyecto.findAllByIdInList(ids*.toLong()).each { p ->
            p.fechaFin = new Date()
            if (!p.save(flush: true)) {
                println "Error al quitar ${p.persona} del proyecto ${p.proyecto}"
            } else {
                c++
//                personal += personalProyecto
            }
        }
        render "SUCCESS*${c} de ${ids.size()} personas des asignadas correctamente"
    }

    def validarFechas_ajax() {
        def ids = params.ids.split(",")

        def datos = [:]

        Persona.findAllByIdInList(ids*.toLong()).each { p ->
            def key = p.id
            if (!datos[key]) {
                datos[key] = [:]
            }
            datos[key].persona = p
            datos[key].maxDate = null
            datos[key].disabledDates = []  // ("MM/dd/YYYY")

            /*
             * de los personalProyecto: los rangos son disabled dates
             * si no tiene fecha fin, la fecha ini es max date
             * si no exisste, no hay max date
             */

            def pp = PersonalProyecto.withCriteria {
                eq("persona", p)
                order("fechaInicio", "asc")
            }

            pp.each {
                if (pp.fechaFin) {
                    def d = pp.fechaInicio.clone()
                    while (d <= pp.fechaFin) {
                        datos[key].disabledDates += d.format("MM/dd/yyyy")
                        d++
                    }
                } else {
                    if (!datos[key].maxDate || datos[key].maxDate > pp.fechaInicio) {
                        datos[key].maxDate = pp.fechaInicio
                    }
                }
            }
        }
        return [datos: datos]
    }

    def asignarPersonal() {
        def proyecto = Proyecto.get(params.id)
        if (!proyecto) {
            response.sendError(404)
        }

        def personalProyecto = proyecto.personal
        List<PersonalProyecto> personalDisponible = []

        Persona.list().each { p ->
            def personal = PersonalProyecto.withCriteria {
                eq("persona", p)
                le("fechaInicio", new Date())
                or {
                    isNull("fechaFin")
                    ge("fechaFin", new Date())
                }
            }
            if (personal.size() == 0) {
                personalDisponible += p
            }
        }

        return [proyecto: proyecto, personalProyecto: personalProyecto, personalDisponible: personalDisponible]
    }

    /**
     * Acción llamada con ajax que guarda las modificaciones de fechas de inicio y fin de asignación de una persona a un proyecto
     */
    def saveFechas_ajax() {
        println params
        def errores = ""
        params.each { k, v ->
            def parts = k.toString().split("_")
            if (parts.size() == 3) {
                def tipo = parts[0]
                def id = parts[1].toLong()
                def personal = PersonalProyecto.get(id)
                if (tipo == "desde") {
                    personal.fechaInicio = new Date().parse("dd-MM-yyyy HH:mm", v.toString())
                } else if (tipo == "hasta") {
                    personal.fechaFin = new Date().parse("dd-MM-yyyy HH:mm", v.toString())
                }
                if (!personal.save(flush: true)) {
                    println "Error al guardar fechas de personal proyecto: " + personal.errors
                    errores += renderErrors(bean: personal)
                }
            }
        }
        if (errores == "") {
            render "SUCCESS*Fechas modificadas exitosamente"
        } else {
            render "ERROR*" + errores
        }
    }

    /**
     * Acción que muestra y permite modificar las fechas de inicio y fin de asignación de una persona a un proyecto
     */
    def personalProyectosAdmin() {
        def personal = PersonalProyecto.withCriteria {
            le("fechaInicio", new Date())
            or {
                isNull("fechaFin")
                ge("fechaFin", new Date())
            }
            order("proyecto", "asc")
            order("persona", "asc")
        }

        def proy = null
        if (params.id) {
            proy = Proyecto.get(params.id)
        }
        def proyectos = Proyecto.list([sort: 'nombre'])

        return [personal: personal, proy: proy, proyectos: proyectos]
    }

    /**
     * Acción que muestra las fechas de inicio y fin de asignación de una persona a un proyecto
     */
    def personalProyectos() {
        def personal = PersonalProyecto.withCriteria {
            le("fechaInicio", new Date())
            or {
                isNull("fechaFin")
                ge("fechaFin", new Date())
            }
            order("proyecto", "asc")
            order("persona", "asc")
        }

        def proy = null
        if (params.id) {
            proy = Proyecto.get(params.id)
        }
        def proyectos = Proyecto.list([sort: 'nombre'])

        return [personal: personal, proy: proy, proyectos: proyectos]
    }
}
