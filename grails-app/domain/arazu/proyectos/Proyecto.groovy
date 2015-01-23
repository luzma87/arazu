package arazu.proyectos

/**
 * Clase para conectar con la tabla 'proy' de la base de datos
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

        columns {
            id column: 'proy__id'
            nombre column: 'proynmbr'
            descripcion column: 'proydscr'
        }
    }
}
