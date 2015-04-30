package arazu.seguridad

/**
 * Clase para conectar con la tabla 'tpac' de la base de datos
 * Guarda los posibles tipos de una acción (Menú para las que se muestran en el menú, Proceso para las que no)
 */
class TipoAccion {
    /**
     * Tipo
     */
    String tipo
    /**
     * Código
     */
    String codigo
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'tpac'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'tpac__id'
            tipo column: 'tpacdscr'
            codigo column: 'tpaccdgo'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        tipo maxSize: 31
        codigo maxSize: 1
    }

    /**
     * Genera un string para mostrar
     * @return el tipo
     */
    String toString() {
        "${this.tipo}"
    }

}
