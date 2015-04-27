package arazu.seguridad

/**
 * Clase para conectar con la tabla 'accn' de la base de datos
 */
class Accion {
    /**
     * Nombre de la acción
     */
    String nombre
    /**
     * Descripción de la acción
     */
    String descripcion
    /**
     * Indica si la acción es o no auditable
     */
    int esAuditable
    /**
     * Controlador al cual pertenece la acción
     */
    Controlador control
    /**
     * Módulo al cual pertenece la acción
     */
    Modulo modulo
    /**
     * Tipo de acción
     */
    TipoAccion tipo
    /**
     * Orden en el cual deben aparecer los items en el menú
     */
    Integer orden
    /**
     * Clase para el ícono (fontawesome, glyohicons, mfizz, flaticons)
     */
    String icono = ""
    /**
     * Sistema al que pertenece la acción
     */
    Sistema sistema

    /**
     * Define las relaciones uno a varios
     */
    static hasMany = [permisos: Permiso]
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'accn'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        control sort: ['nombre': 'asc']
        columns {
            id column: 'accn__id'
            nombre column: 'accnnmbr'
            descripcion column: 'accndscr'
            esAuditable column: 'accnaudt'
            control column: 'ctrl__id'
            modulo column: 'mdlo__id'
            tipo column: 'tpac__id'
            orden column: 'accnordn'
            icono column: 'accnicno'
            sistema column: 'sstm__id'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        nombre blank: false, size: 0..50
        esAuditable nullable: true
        sistema nullable: true
    }

    /**
     * Genera un string para mostrar
     * @return el nombre de controlador y el nombre de la acción concatenados
     */
    String toString() {
        "${this.control.nombre} : ${this.nombre} "
    }
}
