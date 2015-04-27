package arazu.nomina

import arazu.parametros.TipoAsistencia;
import arazu.seguridad.Persona
import arazu.seguridad.Shield

class AsistenciaController extends Shield {



	def registroAsistencia(){

		def now = new Date();
		def dia = now.format("dd").toInteger()
		def min,max
		def mycal = new GregorianCalendar(now.format("yyyy").toInteger(), now.format("MM").toInteger()-1, dia);
		def daysInMonth = mycal.getActualMaximum(Calendar.DAY_OF_MONTH)

		if(dia<11){
			min = 1
			max = 10
		}else{
			if(dia<21){
				min = 11
				max = 20
			}else{
				if(dia<31){
					min = 21
					max = daysInMonth
				}
			}
		}

		def empleados= Persona.list()

		[min:min,max:max,now:now,empleados:empleados,dia:dia]
	}
	
	def registroHorasExtra(){
		def now = new Date();
		def dia = now.format("dd").toInteger()
		def min,max
		def mycal = new GregorianCalendar(now.format("yyyy").toInteger(), now.format("MM").toInteger()-1, dia);
		def daysInMonth = mycal.getActualMaximum(Calendar.DAY_OF_MONTH)

		if(dia<11){
			min = 1
			max = 10
		}else{
			if(dia<21){
				min = 11
				max = 20
			}else{
				if(dia<31){
					min = 21
					max = daysInMonth
				}
			}
		}

		def empleados= Persona.list()

		[min:min,max:max,now:now,empleados:empleados,dia:dia]
	}

	def form_ajax(){
		def asistenciaInstance
		println "params "+params
		def empleado = Persona.get(params.empleado)
		if(params.id && params.id!=""  && params.id!="undefined")
			asistenciaInstance= Asistencia.get(params.id)
		else
			asistenciaInstance = new Asistencia();
			[asistenciaInstance:asistenciaInstance,empleado:empleado,fecha:params.fecha]
	}
	
	def guardarDatos_ajax(){
		//println "params guardar datos "+params
		def datos = params.data.split("\\|")
		//println "datos "+datos
		datos.each{d->
			if(d!=""){
				//println "d "+d
				def celda = d.split(";")
				//println "celda "+celda
				def persona = Persona.get(celda[0])
				def fecha = new Date().parse("dd-MM-yyyy",celda[1])
				def asistencia = Asistencia.findByEmpleadoAndFecha(persona,fecha)
				if(!asistencia){
					asistencia = new Asistencia();
					asistencia.empleado=persona
					asistencia.fecha = fecha
				}
				if(celda[2]=="1")
				asistencia.tipo=TipoAsistencia.findByCodigo("ASTE")
				else
				asistencia.tipo=TipoAsistencia.findByCodigo("NAST")
				asistencia.registra = session.usuario
				if(!asistencia.save(flush:true))
					println "error save asistencia "+asistencia.errors
				
			}
		
		}
		render "ok"
	
	}
	
	/* todo esta para que solo pueda editar en la fecha actual, eso hay que cambiar*/
	def guardarDatosHoras_ajax(){
		println "params guardar datos "+params
		def datos = params.data.split("\\|")
		//println "datos "+datos
		datos.each{d->
			if(d!=""){
				//println "d "+d
				def celda = d.split(";")
				//println "celda "+celda
				def persona = Persona.get(celda[0])
				def fecha = new Date().parse("dd-MM-yyyy",celda[1])
				def asistencia = Asistencia.findByEmpleadoAndFecha(persona,fecha)
				if(!asistencia){
					println "wtf no hay asistencia "
					render "error"
					return
				}
				asistencia.horas50=celda[2].toInteger()
				asistencia.horas100=celda[3].toInteger()
				if(!asistencia.save(flush:true))
					println "error save asistencia "+asistencia.errors
				
			}
		
		}
		render "ok"
	
	}
	
}
