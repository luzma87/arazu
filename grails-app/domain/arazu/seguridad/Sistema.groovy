package arazu.seguridad

/**
 * Clase para conectar con la tabla 'sstm' de la base de datos
 * Guarda los diferentes sistemas. Un sistema agrupa diferentes acciones del menú para mostrar diferentes elementos
 * según el sistema seleccionado
 */
class Sistema {
    /**
     * Nombre del sistema
     */
    String nombre
    /**
     * Descripción del sistema
     */
    String descripcion
    /**
     * Código del sistema para buscar
     */
    String codigo
    /**
     * Orden para mostrar los sistemas
     */
    Integer orden
    /**
     * Imagen para la pantalla de los sistemas
     */
    String pathImagen
    /**
     * Icono para el menu de los sistemas
     */
    String icono = ""
    /**
     * Controlador de la pantalla de inicio
     */
    String controlador
    /**
     * Acción de la pantalla de inicio
     */
    String accion

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'sstm'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'sstm__id'
            nombre column: 'sstmnmbr'
            descripcion column: 'sstmdscr'
            codigo column: 'sstmcdgo'
            orden column: 'sstmordn'
            pathImagen column: 'sstmptim'
            icono column: 'sstmicno'
            controlador column: 'sstmctrl'
            accion column: 'sstmaccn'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        descripcion blank: true, nullable: true
        pathImagen blank: true, nullable: true
        controlador blank: true, nullable: true
        accion blank: true, nullable: true
        codigo maxSize: 4, nullable: true
    }

    /**
     * Genera un string para mostrar
     * @return el nombre
     */
    String toString() {
        "${this.nombre}"
    }
}
