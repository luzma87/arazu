package arazu.parametros

/**
 * Clase para conectar con la tabla 'tpas' de la base de datos
 * Guarda los posibles tipos de asistencia (asiste, no asiste, vacación de jornada, vacación anual)
 */
class TipoAsistencia {
    /**
     * Nombre del tipo de asistencia
     */
    String nombre
    /**
     * Código del tipo de asistencia
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
        table 'tpas'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: 'tpas__id'
            nombre column: 'ptasnmbr'
            codigo column: 'ptascdgo'

        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        nombre size: 1..100
        codigo size: 1..4
    }
    /**
     * Genera un string para mostrar
     * @return el nombre
     */
    String toString() {
        "${this.nombre}"
    }
}
