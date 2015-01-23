package arazu.parametros

/**
 * Clase para conectar con la tabla 'colr' de la base de datos
 */
class Color {
    /**
     * Nombre del color
     */
    String nombre
    /**
     * Valor hexadecimal para mostrar (formato: #rrggbb o #rrggbbaa)
     */
    String hex

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'colr'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false
        columns {
            id column: 'colr__id'
            nombre column: 'colrnmr'
            hex column: 'colr_hex'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        hex nullable: true, maxSize: 9
    }

    /**
     * Genera un string para mostrar
     * @return el nombre
     */
    String toString() {
        "${this.nombre}"
    }
}
