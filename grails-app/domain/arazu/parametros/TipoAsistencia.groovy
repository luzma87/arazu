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
     * Color del tipo de asistencia (para las tablas)
     */
    String color
    /**
     * Icono del tipo de asistencia (para las tablas)
     */
    String icono
    /**
     * Orden para mostrar en las tablas
     */
    Integer orden

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
            nombre column: 'tpasnmbr'
            codigo column: 'tpascdgo'
            color column: 'tpasclor'
            icono column: 'tpasicno'
            orden column: 'tpasordn'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        nombre size: 1..100
        codigo size: 1..4
        color maxSize: 9
    }
    /**
     * Genera un string para mostrar
     * @return el nombre
     */
    String toString() {
        "${this.nombre}"
    }
}
