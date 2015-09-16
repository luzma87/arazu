package arazu.nomina

import arazu.parametros.Parametros
import arazu.parametros.TipoAsistencia
import arazu.proyectos.Proyecto
import arazu.seguridad.Persona
import arazu.seguridad.Shield
import groovy.json.JsonBuilder

/**
 * Controlador que muestra las pantallas de manejo de asistencias
 */
class AsistenciaController extends Shield {

    def verAsistencia() {
        def now = new Date();
        def dia = now.format("dd").toInteger()
        def min, max
        def mycal = new GregorianCalendar(now.format("yyyy").toInteger(), now.format("MM").toInteger() - 1, dia);
        def daysInMonth = mycal.getActualMaximum(Calendar.DAY_OF_MONTH)
        min = 1
        max = daysInMonth

        def proy = null
        if (params.id) {
            proy = Proyecto.get(params.id)
        }
        def proyectos = Proyecto.list([sort: 'nombre'])

        def empleados = Persona.list()
        if (proy) {
            empleados = empleados.findAll { it.proyecto == proy }
        }
        empleados = empleados.sort { it.proyecto }

        [min: min, max: max, now: now, empleados: empleados, dia: dia, proy: proy, proyectos: proyectos]
    }

    def verHorasExtra() {
        def now = new Date();
        def dia = now.format("dd").toInteger()
        def min, max
        def mycal = new GregorianCalendar(now.format("yyyy").toInteger(), now.format("MM").toInteger() - 1, dia);
        def daysInMonth = mycal.getActualMaximum(Calendar.DAY_OF_MONTH)

        min = 1
        max = daysInMonth

        def proy = null
        if (params.id) {
            proy = Proyecto.get(params.id)
        }
        def proyectos = Proyecto.list([sort: 'nombre'])

        def empleados = Persona.list()
        if (proy) {
            empleados = empleados.findAll { it.proyecto == proy }
        }
        empleados = empleados.sort { it.proyecto }

        [min: min, max: max, now: now, empleados: empleados, dia: dia, proy: proy, proyectos: proyectos]
    }

    def verComidas() {
        def now = new Date();
        def dia = now.format("dd").toInteger()
        def min, max
        def mycal = new GregorianCalendar(now.format("yyyy").toInteger(), now.format("MM").toInteger() - 1, dia);
        def daysInMonth = mycal.getActualMaximum(Calendar.DAY_OF_MONTH)
        min = 1
        max = daysInMonth

        def proy = null
        if (params.id) {
            proy = Proyecto.get(params.id)
        }
        def proyectos = Proyecto.list([sort: 'nombre'])

        def empleados = Persona.list()
        if (proy) {
            empleados = empleados.findAll { it.proyecto == proy }
        }
        empleados = empleados.sort { it.proyecto }

        return [min: min, max: max, now: now, empleados: empleados, dia: dia, proy: proy, proyectos: proyectos]
    }

    def registroAsistencia() {

        def now = new Date();
        def dia = now.format("dd").toInteger()
        def min = 1, max = 10
        def mycal = new GregorianCalendar(now.format("yyyy").toInteger(), now.format("MM").toInteger() - 1, dia);
        def daysInMonth = mycal.getActualMaximum(Calendar.DAY_OF_MONTH)

        if (dia < 11) {
            min = 1
            max = 10
        } else {
            if (dia < 21) {
                min = 11
                max = 20
            } else {
                if (dia < 31) {
                    min = 21
                    max = daysInMonth
                }
            }
        }

        def proy = null
        if (params.id) {
            proy = Proyecto.get(params.id)
        }
        def proyectos = Proyecto.list([sort: 'nombre'])

        def empleados = Persona.list()
        if (proy) {
            empleados = empleados.findAll { it.proyecto == proy }
        }
        empleados = empleados.sort { it.proyecto }
//        //println "EMPLEADOS"
//        //println empleados

        def tiposAsistencia = []
        def tipos = TipoAsistencia.list([sort: "orden"])
        tipos.each { ta ->
            def m = [:]
            m.cod = ta.codigo
            m.label = ta.nombre
            m.color = ta.color
            m.icono = ta.icono
            m.otros = tipos.codigo.clone() - ta.codigo
            tiposAsistencia += m
        }

        def json = new JsonBuilder(tiposAsistencia)
        //println json.toPrettyString()
        return [min: min, max: max, now: now, empleados: empleados, dia: dia, proy: proy, proyectos: proyectos, tipos: json]
    }

    def registroHorasExtra() {
        def now = new Date();
        def dia = now.format("dd").toInteger()
        def min = 1, max = 10
        def mycal = new GregorianCalendar(now.format("yyyy").toInteger(), now.format("MM").toInteger() - 1, dia);
        def daysInMonth = mycal.getActualMaximum(Calendar.DAY_OF_MONTH)

        if (dia < 11) {
            min = 1
            max = 10
        } else {
            if (dia < 21) {
                min = 11
                max = 20
            } else {
                if (dia < 31) {
                    min = 21
                    max = daysInMonth
                }
            }
        }

        def proy = null
        if (params.id) {
            proy = Proyecto.get(params.id)
        }
        def proyectos = Proyecto.list([sort: 'nombre'])

        def empleados = Persona.list()
        if (proy) {
            empleados = empleados.findAll { it.proyecto == proy }
        }
        empleados = empleados.sort { it.proyecto }

        return [min: min, max: max, now: now, empleados: empleados, dia: dia, proy: proy, proyectos: proyectos]
    }

    def registroComidas_old() {
        def now = new Date();

        def proy = null
        if (params.id) {
            proy = Proyecto.get(params.id)
        }
        def proyectos = Proyecto.list([sort: 'nombre'])

        def empleados = Persona.list()
        if (proy) {
            empleados = empleados.findAll { it.proyecto == proy }
        }
        empleados = empleados.sort { it.proyecto }

        def inicioDesayuno = Parametros.inicioDesayuno
        def finDesayuno = Parametros.finDesayuno
        def inicioAlmuerzo = Parametros.inicioAlmuerzo
        def finAlmuerzo = Parametros.finAlmuerzo
        def inicioMerienda = Parametros.inicioMerienda
        def finMerienda = Parametros.finMerienda

        def horaInicioDesayuno = inicioDesayuno.split(':')[0].toInteger()
        def minInicioDesayuno = inicioDesayuno.split(':')[1].toInteger()
        def horaFinDesayuno = finDesayuno.split(':')[0].toInteger()
        def minFinDesayuno = finDesayuno.split(':')[1].toInteger()
        def horaInicioAlmuerzo = inicioAlmuerzo.split(':')[0].toInteger()
        def minInicioAlmuerzo = inicioAlmuerzo.split(':')[1].toInteger()
        def horaFinAlmuerzo = finAlmuerzo.split(':')[0].toInteger()
        def minFinAlmuerzo = finAlmuerzo.split(':')[1].toInteger()
        def horaInicioMerienda = inicioMerienda.split(':')[0].toInteger()
        def minInicioMerienda = inicioMerienda.split(':')[1].toInteger()
        def horaFinMerienda = finMerienda.split(':')[0].toInteger()
        def minFinMerienda = finMerienda.split(':')[1].toInteger()

        def ahora = new Date().format('HH:mm')
        def horaAhora = ahora.split(':')[0].toInteger()
        def minAhora = ahora.split(':')[1].toInteger()

        def okDesayuno = false
        def okAlmuerzo = false
        def okMerienda = false

        if (horaAhora >= horaInicioDesayuno) {
            if (horaAhora <= horaFinDesayuno) {
                if (minAhora >= minInicioDesayuno) {
                    if (minAhora <= minFinDesayuno) {
                        okDesayuno = true
                    }
                }
            }
        }

        if (horaAhora >= horaInicioAlmuerzo) {
            if (horaAhora <= horaFinAlmuerzo) {
                if (minAhora >= minInicioAlmuerzo) {
                    if (minAhora <= minFinAlmuerzo) {
                        okAlmuerzo = true
                    }
                }
            }
        }

        if (horaAhora >= horaInicioMerienda) {
            if (horaAhora <= horaFinMerienda) {
                if (minAhora >= minInicioMerienda) {
                    if (minAhora <= minFinMerienda) {
                        okMerienda = true
                    }
                }
            }
        }

        return [now               : now, empleados: empleados, proy: proy, proyectos: proyectos,
                inicioDesayuno    : inicioDesayuno, finDesayuno: finDesayuno,
                inicioAlmuerzo    : inicioAlmuerzo, finAlmuerzo: finAlmuerzo,
                inicioMerienda    : inicioMerienda, finMerienda: finMerienda,
                horaInicioDesayuno: horaInicioDesayuno, minInicioDesayuno: minInicioDesayuno,
                horaInicioAlmuerzo: horaInicioAlmuerzo, minInicioAlmuerzo: minInicioAlmuerzo,
                horaInicioMerienda: horaInicioMerienda, minInicioMerienda: minInicioMerienda,
                okDesayuno        : okDesayuno, okAlmuerzo: okAlmuerzo, okMerienda: okMerienda]
    }

    def registroComidas() {
        def now = new Date();

        def proy = null
        if (params.id) {
            proy = Proyecto.get(params.id)
        }
        def proyectos = Proyecto.list([sort: 'nombre'])

        def empleados = Persona.list()
        if (proy) {
            empleados = empleados.findAll { it.proyecto == proy }
        }
        empleados = empleados.sort { it.proyecto }

        def inicioDesayuno = Parametros.inicioDesayuno
        def finDesayuno = Parametros.finDesayuno
        def inicioAlmuerzo = Parametros.inicioAlmuerzo
        def finAlmuerzo = Parametros.finAlmuerzo
        def inicioMerienda = Parametros.inicioMerienda
        def finMerienda = Parametros.finMerienda

        def horaInicioDesayuno = inicioDesayuno.split(':')[0].toInteger()
        def minInicioDesayuno = inicioDesayuno.split(':')[1].toInteger()
        def horaFinDesayuno = finDesayuno.split(':')[0].toInteger()
        def minFinDesayuno = finDesayuno.split(':')[1].toInteger()
        def horaInicioAlmuerzo = inicioAlmuerzo.split(':')[0].toInteger()
        def minInicioAlmuerzo = inicioAlmuerzo.split(':')[1].toInteger()
        def horaFinAlmuerzo = finAlmuerzo.split(':')[0].toInteger()
        def minFinAlmuerzo = finAlmuerzo.split(':')[1].toInteger()
        def horaInicioMerienda = inicioMerienda.split(':')[0].toInteger()
        def minInicioMerienda = inicioMerienda.split(':')[1].toInteger()
        def horaFinMerienda = finMerienda.split(':')[0].toInteger()
        def minFinMerienda = finMerienda.split(':')[1].toInteger()

        def ahora = new Date().format('HH:mm')
        def horaAhora = ahora.split(':')[0].toInteger()
        def minAhora = ahora.split(':')[1].toInteger()

        def okDesayuno = false
        def okAlmuerzo = false
        def okMerienda = false

        if (horaAhora >= horaInicioDesayuno) {
            if (horaAhora <= horaFinDesayuno) {
                if (minAhora >= minInicioDesayuno) {
                    if (minAhora <= minFinDesayuno) {
                        okDesayuno = true
                    }
                }
            }
        }

        if (horaAhora >= horaInicioAlmuerzo) {
            if (horaAhora <= horaFinAlmuerzo) {
                if (minAhora >= minInicioAlmuerzo) {
                    if (minAhora <= minFinAlmuerzo) {
                        okAlmuerzo = true
                    }
                }
            }
        }

        if (horaAhora >= horaInicioMerienda) {
            if (horaAhora <= horaFinMerienda) {
                if (minAhora >= minInicioMerienda) {
                    if (minAhora <= minFinMerienda) {
                        okMerienda = true
                    }
                }
            }
        }

        return [now               : now, empleados: empleados, proy: proy, proyectos: proyectos,
                inicioDesayuno    : inicioDesayuno, finDesayuno: finDesayuno,
                inicioAlmuerzo    : inicioAlmuerzo, finAlmuerzo: finAlmuerzo,
                inicioMerienda    : inicioMerienda, finMerienda: finMerienda,
                horaInicioDesayuno: horaInicioDesayuno, minInicioDesayuno: minInicioDesayuno,
                horaInicioAlmuerzo: horaInicioAlmuerzo, minInicioAlmuerzo: minInicioAlmuerzo,
                horaInicioMerienda: horaInicioMerienda, minInicioMerienda: minInicioMerienda,
                okDesayuno        : okDesayuno, okAlmuerzo: okAlmuerzo, okMerienda: okMerienda]
    }

    def guardarComidas_ajax() {
        //println params

        def errores = ""

//      data:p_1;desayuno;3|5;desayuno;S|3;desayuno;S|7;desayuno;S|

        def data = params.data.split("\\|")
        data.each { d ->
            def parts = d.split(";")

//            println "PARTS: " + parts

            def id = parts[0].toString()
            def tipo = parts[1].toString()
            def cant = parts[2]

            if (id.startsWith("p")) {

                tipo += "sInvitado"

                //println "1"
                //println "proy"
                id = id.split("_")[1]
                def proy = Proyecto.get(id.toLong())

                def asistenciaInvitado = Asistencia.findAllByFechaAndProyecto(new Date().clearTime(), proy)
                if (asistenciaInvitado.size() == 0) {
                    //println "2"
                    asistenciaInvitado = new Asistencia()
                    asistenciaInvitado.fecha = new Date().clearTime()
                    asistenciaInvitado.proyecto = proy
                    asistenciaInvitado.registra = session.usuario
                    asistenciaInvitado.tipo = TipoAsistencia.findByCodigo("ASTE")
                } else if (asistenciaInvitado.size() >= 1) {
                    //println "3"
                    println "Hay ${asistenciaInvitado.size()} asistencia invitado date: ${new Date()} $proy"
                    asistenciaInvitado = asistenciaInvitado.first()
                }
//                println "TIPO: " + tipo
//                println "CANT: " + cant
//                params[tipo] = cant.toInteger()
//
//                println params
//
//                asistenciaInvitado.properties = params

                asistenciaInvitado[tipo] = cant.toInteger()

                if (!asistenciaInvitado.save(flush: true)) {
                    //println "4"
                    errores += renderErrors(bean: asistenciaInvitado)
                }
            } else {
                //println "5"
                def pers = Persona.get(id.toLong())
                def asistencia = Asistencia.findAllByFechaAndEmpleado(new Date().clearTime(), pers)
                if (asistencia.size() == 0) {
                    //println "6"
                    asistencia = new Asistencia()
                    asistencia.fecha = new Date().clearTime()
                    asistencia.empleado = pers
                    asistencia.tipo = TipoAsistencia.findByCodigo("ASTE")
                    asistencia.registra = session.usuario
                } else if (asistencia.size() >= 1) {
                    //println "7"
                    println "Hay ${asistencia.size()} asistencia  date: ${new Date()} $pers"
                    asistencia = asistencia.first()
                }
                asistencia[tipo] = cant
                if (!asistencia.save(flush: true)) {
                    //println "8"
                    errores += renderErrors(bean: asistencia)
                }
            }
        }
        if (errores == "") {
            //println "9"
            render "SUCCESS*Comidas guardadas exitosamente"
        } else {
            //println "10"
            render "ERROR*" + errores
        }
    }

    def form_ajax() {
        def asistenciaInstance
        //println "params " + params
        def empleado = Persona.get(params.empleado)
        if (params.id && params.id != "" && params.id != "undefined") {
            asistenciaInstance = Asistencia.get(params.id)
        } else {
            asistenciaInstance = new Asistencia()
        };
        [asistenciaInstance: asistenciaInstance, empleado: empleado, fecha: params.fecha]
    }

    def cambiarEstadoComidaInvitado_ajax() {
        //println "COMIDA INV: " + params
        def proyecto = Proyecto.get(params.proy.toLong())
        def usu = Persona.get(session.usuario.id)
        def comida = params.comida
        def cant = params.cant.toInteger()

        def asistencia = Asistencia.findAllByFechaAndProyecto(new Date().clearTime(), proyecto)

        if (asistencia.size() == 1) {
            //println "1"
            asistencia = asistencia.first()
            asistencia[comida + "sInvitado"] = cant
            if (asistencia.save(flush: true)) {
                //println "2"
                render "SUCCESS*" + comida.capitalize() + " registrad" + (comida == "merienda" ? "a" : "o")
            } else {
                //println "3"
                render "ERROR*" + renderErrors(bean: asistencia)
            }
        } else if (asistencia.size() == 0) {
            //println "4"
            asistencia = new Asistencia()
            asistencia.fecha = new Date().clearTime()
            asistencia.fechaRegistro = new Date()
            asistencia.tipo = TipoAsistencia.findByCodigo("ASTE")
            asistencia.proyecto = proyecto
            asistencia.registra = usu
            asistencia[comida + "sInvitado"] = cant
            if (asistencia.save(flush: true)) {
                //println "5"
                render "SUCCESS*" + comida.capitalize() + " registrad" + (comida == "merienda" ? "a" : "o")
            } else {
                //println "6"
                render "ERROR*" + renderErrors(bean: asistencia)
            }
        } else {
            //println "7"
            render "ERROR*Ha ocurrido un error grave"
        }
    }

    def cambiarEstadoComida_ajax() {
        //println "COMIDA: " + params
        def persona = Persona.get(params.persona.toLong())
        def usu = Persona.get(session.usuario.id)
        def comida = params.comida
        def comio = params.comio

        def asistencia = Asistencia.findAllByFechaAndEmpleado(new Date().clearTime(), persona)

        if (asistencia.size() == 1) {
            //println "1"
            asistencia = asistencia.first()
            asistencia[comida] = comio
            if (asistencia.save(flush: true)) {
                //println "2"
                render "SUCCESS*" + comida.capitalize() + " registrad" + (comida == "merienda" ? "a" : "o")
            } else {
                //println "3"
                render "ERROR*" + renderErrors(bean: asistencia)
            }
        } else if (asistencia.size() == 0) {
            //println "4"
            asistencia = new Asistencia()
            asistencia.fecha = new Date().clearTime()
            asistencia.fechaRegistro = new Date()
            asistencia.tipo = TipoAsistencia.findByCodigo("ASTE")
            asistencia.empleado = persona
            asistencia.registra = usu
            asistencia[comida] = comio
            if (asistencia.save(flush: true)) {
                //println "5"
                render "SUCCESS*" + comida.capitalize() + " registrad" + (comida == "merienda" ? "a" : "o")
            } else {
                //println "6"
                render "ERROR*" + renderErrors(bean: asistencia)
            }
        } else {
            //println "7"
            render "ERROR*Ha ocurrido un error grave"
        }
    }

    def guardarDatos_ajax() {
        //println "params guardar datos " + params
        def datos = params.data.split("\\|")
        ////println "datos "+datos
        datos.each { d ->
            if (d != "") {
//                println "d "+d
                def celda = d.split(";")
//                println "celda "+celda
                if(celda.size() == 3) {
                    def persona = Persona.get(celda[0])
                    def fecha = new Date().parse("dd-MM-yyyy", celda[1])
                    def asistencia = Asistencia.findByEmpleadoAndFecha(persona, fecha)
                    if (!asistencia) {
                        asistencia = new Asistencia();
                        asistencia.empleado = persona
                        asistencia.fecha = fecha
                    }
                    asistencia.tipo = TipoAsistencia.findByCodigo(celda[2])

                    asistencia.registra = session.usuario
                    if (!asistencia.save(flush: true)) {
                        //println "error save asistencia " + asistencia.errors
                    }
                }
            }
        }
        render "ok"
    }

    /* todo esta para que solo pueda editar en la fecha actual, eso hay que cambiar*/

    def guardarDatosHoras_ajax() {
        //println "params guardar datos " + params
        def datos = params.data.split("\\|")
        ////println "datos "+datos
        datos.each { d ->
            if (d != "") {
                ////println "d "+d
                def celda = d.split(";")
                ////println "celda "+celda
                def persona = Persona.get(celda[0])
                def fecha = new Date().parse("dd-MM-yyyy", celda[1])
                def asistencia = Asistencia.findByEmpleadoAndFecha(persona, fecha)
                if (!asistencia) {
                    //println "wtf no hay asistencia "
                    render "error"
                    return
                }
                asistencia.horas50 = celda[2].toInteger()
                asistencia.horas100 = celda[3].toInteger()
                if (!asistencia.save(flush: true)) {
                    //println "error save asistencia " + asistencia.errors
                }

            }

        }
        render "ok"

    }

}
