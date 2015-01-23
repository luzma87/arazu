package arazu.parametros

/**
 * Clase para conectar con la tabla 'crgo' de la base de datos
 */
class Cargo {
    /**
     * Código del cargo de personal
     */
    String codigo
    /**
     * Descipción del cargo de personal
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
        table 'crgo'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'crgo__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'crgo__id'
            descripcion column: 'crgodscr'
            codigo column: 'crgocdgo'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        descripcion(matches: /^[a-zA-Z0-9ñÑ .,áéíóúÁÉÍÚÓüÜ#_-]+$/, size: 1..63, blank: false, attributes: ["mensaje": "Descripción del cargo del personal"])
        codigo(blank: true, nullable: true, maxSize: 4)
    }

    /**
     * Genera un string para mostrar
     * @return la descripción
     */
    String toString() {
        "${this.descripcion}"
    }
}