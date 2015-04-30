package arazu.proyectos

/**
 * Clase para conectar con la tabla 'proy' de la base de datos
 * Guarda todos los datos de un proyecto
 */
class Proyecto {

    /**
     * Nombre del proyecto
     */
    String nombre
    /**
     * Descripción del proyecto
     */
    String descripcion
    /**
     * Fecha de inicio del proyecto
     */
    Date fechaInicio
    /**
     * Fecha de fin del proyecto
     */
    Date fechaFin
    /**
     * Entidad contratante
     */
    String entidad
    /**
     * Latitud
     */
    Double latitud
    /**
     * Longitud
     */
    Double longitud
    /**
     * Zoom para mostrar en el mapa
     */
    Integer zoom
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'proy'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: 'proy__id'
            nombre column: 'proynmbr'
            descripcion column: 'proydscr'
            fechaInicio column: 'proyfcin'
            fechaFin column: 'proyfcfn'
            entidad column: 'proyentd'
            latitud column: 'proylttd'
            longitud column: 'proylngt'
            zoom column: 'proyzoom'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        fechaFin nullable: true
    }
    /**
     * Genera un string para mostrar
     * @return el nombre
     */
    String toString() {
        "${this.nombre}"
    }
}
