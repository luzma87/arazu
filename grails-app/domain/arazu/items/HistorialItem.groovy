package arazu.items

/**
 *  Clase para conectar con la tabla 'hsit' de la base de datos
 *  La tabla historial item guarda un log con fechas de items o máquinas
 */
class HistorialItem {
    /**
     * Item
     */
    Item item
    /**
     * Maquinaria
     */
    Maquinaria maquinaria
    /**
     * Fecha
     */
    Date fecha = new Date()
    /**
     * Texto
     */
    String texto
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'hsit'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort fecha: "desc"
        columns {
            id column: 'hsit__id'
            item column: 'item__id'
            maquinaria column: 'maqn__id'
            fecha column: 'hsitfcha'
            texto column: 'hsittxto'
            texto type: 'text'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        item nullable: true
        maquinaria nullable: true
    }
}
