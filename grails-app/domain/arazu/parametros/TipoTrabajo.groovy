package arazu.parametros

/**
 * Clase para conectar con la tabla 'tptr' de la base de datos
 */
class TipoTrabajo {
    /**
     * Código del tipo de trabajo
     */
    String codigo
    /**
     * Nombre del tipo de trabajo
     */
    String nombre

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'tptr'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: 'tptr__id'
            codigo column: 'tptrcdgo'
            nombre column: 'tptrnmbr'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        codigo maxSize: 4
    }
    /**
     * Genera un string para mostrar
     * @return el nombre
     */
    String toString() {
        "${this.nombre}"
    }
}
