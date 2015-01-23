package arazu.items

import arazu.parametros.TipoItem

class Item {

    TipoItem tipo
    /**
     * Descripción del item
     */
    String descripcion

    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'item'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort descripcion: "asc"
        columns {
            id column: 'item__id'
            descripcion column: 'itemdscr'
            tipo column: 'tpit__id'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        descripcion(nullable: true,blank: true,size: 1..500)
        tipo(nullable: false,blank:false)
    }
}
