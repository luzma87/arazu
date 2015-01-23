package arazu.items

import arazu.parametros.Color
import arazu.parametros.TipoMaquinaria

class Maquinaria {

    TipoMaquinaria tipo
    String descripcion
    String placa
    int anio
    String marca
    String modelo
    String observaciones
    Color color

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'maqn__id'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort descripcion: "asc"
        columns {
            id column: 'maqn__id'
            tipo column: 'tpmq__id'
            descripcion column: 'maqndscr'
            placa column: 'maqnplca'
            anio column: 'maqnanio'
            marca column: 'maqnmrca'
            observaciones column: 'maqnobsr'
            color column: 'clor__id'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        descripcion(nullable: true,blank: true,size: 1..255)
        observaciones(nullable: true,blank: true,size: 1..1023)
        tipo(nullable: false,blank:false)
        placa(nullable: true,blank: true,size: 1..20)
        marca(nullable: true,blank: true,size: 1..50)
        modelo(nullable: true,blank: true,size: 1..50)
        color(nullable: false,blank:false)
    }
}
