package arazu.parametros

/**
 * Clase para conectar con la tabla 'dpto' de la base de datos
 */
class Departamento {
    /**
     * Código del departamento
     */
    String codigo
    /**
     * Nombre del departamento
     */
    String nombre
    /**
     * Descripción del departamento
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
        table 'dpto'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: 'dpto__id'
            codigo column: 'dptocdgo'
            nombre column: 'dptonmbr'
            descripcion column: 'dptodscr'
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
