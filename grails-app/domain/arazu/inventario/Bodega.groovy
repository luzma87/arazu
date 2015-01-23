package arazu.inventario

import arazu.proyectos.Proyecto
import arazu.seguridad.Persona

class Bodega {
    Proyecto proyecto
    String descripcion
    Persona persona
    String observaciones
    int activo = 1 /*1 --> activo 0--> inactivo*/
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'bdga'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort descripcion: "asc"
        columns {
            id column: 'bdga__id'
            proyecto column: 'proy__id'
            descripcion column: 'bdgadscr'
            persona column: 'prsn__id'
            observaciones column: 'bdgaobsr'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        descripcion(nullable: true,blank: true,size: 1..50)
        observaciones(nullable: true,blank: true,size: 1..1023)
        proyecto(nullable: true,blank: true)
        persona(nullable: false,blank: false)
    }
}
