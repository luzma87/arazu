package arazu.parametros

/**
 * Clase para conectar con la tabla 'tpus' de la base de datos
 */
class TipoUsuario {
    /**
     * Departamento padre
     */
    TipoUsuario padre
    /**
     * Código del tipoUsuario
     */
    String codigo
    /**
     * Nombre del tipoUsuario
     */
    String nombre
    /**
     * Descripción del tipoUsuario
     */
    String descripcion
    /**
     * Indica si el usuario está o no activo (1->Sí, 0->No)
     */
    int activo

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'tpus'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort nombre: "asc"
        columns {
            id column: 'tpus__id'
            padre column: 'tpuspdre'
            codigo column: 'tpuscdgo'
            nombre column: 'tpusnmbr'
            descripcion column: 'tpusdscr'
            activo column: 'tpusactv'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        padre nullable: true
        descripcion nullable: true
        codigo maxSize: 4
        nombre maxSize: 25
        descripcion maxSize: 127
    }
    /**
     * Genera un string para mostrar
     * @return el nombre
     */
    String toString() {
        "${this.nombre}"
    }
}
