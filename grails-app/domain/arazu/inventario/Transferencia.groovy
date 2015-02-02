package arazu.inventario

import arazu.seguridad.Persona

/**
 *  Clase para conectar con la tabla 'trsf' de la base de datos
 */
class Transferencia {

    /**
     * Bodega de donde sale el item
     */
    Bodega origen
    /**
     * Bodega a la que llega el item
     */
    Bodega destino
    /**
     * Fecha de transferencia
     */
    Date fecha = new Date()
    /**
     * Observaciones
     */
    String observaciones
    /**
     * Usuario que realizó la transferencia
     */
    Persona usuario

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'trsf'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort fecha: "desc"
        columns {
            id column: 'trsf__id'
            origen column: 'trsfbdor'
            destino column: 'trsfbdds'
            fecha column: 'trsffcha'
            observaciones column: 'trsfobsr'
            usuario column: 'prsn__id'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        observaciones(nullable: true, blank: true, size: 1..1023)
    }
}
