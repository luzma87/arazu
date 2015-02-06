package arazu.items

/**
 *  Clase para conectar con la tabla 'itmq' de la base de datos
 */
class ItemMaquinaria {

    /**
     * Item
     */
    Item item
    /**
     * Maquinaria para la cual es el item
     */
    Maquinaria maquinaria
    /**
     * Observaciones
     */
    String observaciones
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'itmq'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort descripcion: "asc"
        columns {
            id column: 'itmq__id'
            item column: 'item__id'
            maquinaria column: 'maqn__id'
            observaciones column: 'itmqobsv'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        observaciones(nullable: true, blank: true, size: 1..500)
    }
    /**
     * Genera un string para mostrar
     * @return el item y la maquinaria concatenados
     */
    String toString() {
        return "${this.item} - ${this.maquinaria}"
    }

}
