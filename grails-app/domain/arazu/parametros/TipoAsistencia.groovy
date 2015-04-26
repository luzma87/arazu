package arazu.parametros

class TipoAsistencia {

	String nombre
	String codigo

	static mapping = {
		table 'tpas'
		cache usage: 'read-write', include: 'non-lazy'
		version false
		id generator: 'identity'
		sort nombre: "asc"
		columns {
			id column: 'tpas__id'
			nombre column: 'ptasnmbr'
			codigo column: 'ptascdgo'
			
		}
	}
	
	static constraints = {
		nombre(nullable:false,blank:false,size:1..100)
		codigo(nullable:false,blank:false,size:1..4)
	}
}
