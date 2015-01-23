package arazu.items

class HistorialItem {

    Item item
    Maquinaria maquinaria
    Date fecha = new Date()
    String texto
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'hsit'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort fecha: "asc"
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
        item(nullable: true,blank: true)
        maquinaria(nullable: true,blank: true)
        fecha(nullable: false,blank: false)
        texto(nullable: false,blank: false)
    }
}
