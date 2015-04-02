package arazu.parametros

/**
 * Clase para conectar con la tabla 'tpds' de la base de datos
 */
class TipoDesecho {
    /**
     * Código del tipo de desecho
     */
    String codigo
    /**
     * Nombre del tipo de desecho
     */
    String nombre
    /**
     * Indica si requiere un precio o no (1:si, 0:no)
     */
    Integer requierePrecio = 0

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'tpds'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: 'tpds__id'
            codigo column: 'tpdscdgo'
            nombre column: 'tpdsnmbr'
            requierePrecio column: 'tpdsrqpr'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        codigo maxSize: 2
    }
    /**
     * Genera un string para mostrar
     * @return el nombre
     */
    String toString() {
        "${this.nombre}"
    }
}
