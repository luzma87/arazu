package arazu.parametros

/**
 * Clase para conectar con la tabla 'crgo' de la base de datos
 * Guarda los diferentes cargos que puede tener un empleado
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
        id generator: 'identity'
        version false
        sort descripcion: "asc"
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
        descripcion size: 1..63
        codigo maxSize: 4
    }

    /**
     * Genera un string para mostrar
     * @return la descripción
     */
    String toString() {
        "${this.descripcion}"
    }
}