package arazu.parametros

/**
 * Clase para conectar con la tabla 'tpsl' de la base de datos
 */
class TipoSolicitud {

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
        table 'tpsl'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'tpsl__id'
            codigo column: 'tpslcdgo'
            nombre column: 'tpslnmbr'
            descripcion column: 'tpsldscr'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        descripcion nullable: true
        codigo maxSize: 4
    }
}
