package arazu.nomina

import arazu.parametros.TipoAsistencia;
import arazu.seguridad.Persona

class Asistencia {

	Date fecha
	Date fechaRegistro = new Date()
	TipoAsistencia tipo
	Date entrada
	Date salida
	Integer horas50 = 0
	Integer horas100 = 0
	Persona empleado
	Persona registra
	String observaciones
	
	
	static mapping = {
		table 'asst'
		cache usage: 'read-write', include: 'non-lazy'
		version false
		id generator: 'identity'
		sort fecha: "asc"
		columns {
			id column: 'asst__id'
			fecha column:'asstfcha'
			fechaRegistro column:'asstfcrg'
			tipo column: 'tpas__id'
			entrada column:'asstentr'
			salida column:'asstslda'
			horas50 column:'assth_50'
			horas100 column:'assth100'
			empleado column:'prsn__id'
			registra column:'prsnrgst'
			observaciones column: 'asstobrs'
			observaciones type:"text"
		}
	}
	
    static constraints = {
		fecha(nullable:false,blank:false)
		tipo(nullable:false,blank:false)
		entrada(nullable:true,blank:true)
		salida(nullable:true,blank:true)
		empleado(nullable:false,blank:false)
		registra(nullable:false,blank:false)
		observaciones (blank:true,nullable:true) 
    }
}
