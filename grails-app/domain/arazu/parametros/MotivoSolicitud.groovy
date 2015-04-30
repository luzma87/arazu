package arazu.parametros

/**
 * Clase para conectar con la tabla 'mtsl' de la base de datos
 * Guarda los posibles motivos de realización de una solicitud (mantenimiento, reparación...)
 */
class MotivoSolicitud {
    /**
     * Nombre del motivo de solicitud
     */
    String nombre
    /**
     * Descripción del motivo de solicitud
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
        table 'mtsl'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: 'mtsl__id'
            nombre column: 'mtslnmbr'
            descripcion column: 'mtsldscr'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        descripcion nullable: true
    }
    /**
     * Genera un string para mostrar
     * @return el nombre
     */
    String toString() {
        "${this.nombre}"
    }
}
