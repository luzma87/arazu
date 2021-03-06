package arazu.parametros

/**
 * Clase para conectar con la tabla 'tpit' de la base de datos
 * Guarda los posibles tipos de items ('familias' de items)
 */
class TipoItem {

    /**
     * Código del tipo de item
     */
    String codigo
    /**
     * Nombre del tipo de item
     */
    String nombre
    /**
     * Descripción del tipo de item
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
        table 'tpit'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: 'tpit__id'
            codigo column: 'tpitcdgo'
            nombre column: 'tpitnmbr'
            descripcion column: 'tpitdscr'
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
