package arazu.inventario

import arazu.seguridad.Persona

/**
 *  Clase para conectar con la tabla 'egrs' de la base de datos
 */
class Egreso {
    /**
     * Ingreso del cual se retira
     */
    Ingreso ingreso
    /**
     * Responsable del material retirado
     */
    Persona persona
    /**
     * Fecha de retiro
     */
    Date fecha = new Date()
    /**
     * Observaciones
     */
    String observaciones
    /**
     * Responsable en caso de que sea externo
     */
    String responsable
    /**
     * Cantidad retirada
     */
    Double cantidad = 1

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'egrs'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort fecha: "desc"
        columns {
            id column: 'egrs__id'
            ingreso column: 'ingr__id'
            persona column: 'prsn__id'
            fecha column: 'egrsfcha'
            observaciones column: 'egrsobsr'
            responsable column: 'egrsresp'
            cantidad column: 'egrscant'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        observaciones(nullable: true, blank: true, size: 1..1023)
        persona(nullable: true, blank: true)
        ingreso(nullable: false, blank: false)
        fecha(nullable: false, blank: false)
        responsable(nullable: true, blank: true, size: 1..255)
    }
}
