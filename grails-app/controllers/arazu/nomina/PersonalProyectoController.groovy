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
        return [personal: personal]
    }
}
