package arazu.parametros

/**
 * Clase para conectar con la tabla 'essl' de la base de datos
 */
class EstadoSolicitud {

    /**
     * Código del tipo de solicitud
     */
    String codigo
    /**
     * Nombre del tipo de solicitud
     */
    String nombre
    /**
     * Descripción del tipo de solicitud
     */
    String descripcion

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'essl'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: 'essl__id'
            codigo column: 'esslcdgo'
            nombre column: 'esslnmbr'
            descripcion column: 'essldscr'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        descripcion nullable: true
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
