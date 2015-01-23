package arazu.parametros

/**
 * Clase para conectar con la tabla 'tpmq' de la base de datos
 */
class TipoMaquinaria {

    /**
     * Código del tipo de maquinaria
     */
    String codigo
    /**
     * Nombre del tipo de maquinaria
     */
    String nombre
    /**
     * Descripción del tipo de maquinaria
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
        table 'tpmq'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: 'tpmq__id'
            codigo column: 'tpmqcdgo'
            nombre column: 'tpmqnmbr'
            descripcion column: 'tpmqdscr'
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
