package arazu.parametros

/**
 * Clase para conectar con la tabla 'undd' de la base de datos
 */
class Unidad {

    /**
     * Código de la unidad
     */
    String codigo
    /**
     * Descripción de la unidad
     */
    String descripcion
    /**
     * Unidad padre
     */
    Unidad padre
    /**
     * Valor por el cual hay que multiplicar el padre para convertir al hijo
     */
    Double conversion = 1

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'undd'
        version false
        id generator: 'identity'

        columns {
            id column: 'undd__id'
            codigo column: "unddcdgo"
            descripcion column: "undddscr"
            padre column: "unddpdre"
            conversion column: "unddcnvr"
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        padre nullable: true
        codigo maxSize: 4
    }
}
