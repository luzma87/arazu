package arazu.proyectos

import arazu.parametros.Cargo
import arazu.seguridad.Persona

/**
 * Clase para conectar con la tabla 'fncn' de la base de datos
 */
class Funcion {
    /**
     * Persona
     */
    Persona persona
    /**
     * Proyecto
     */
    Proyecto proyecto
    /**
     * Cargo o función que cumple en el proyecto
     */
    Cargo cargo
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'fncn'
        version false
        id generator: 'identity'

        columns {
            id column: 'fncn__id'
            persona column: 'prsn__id'
            proyecto column: 'proy__id'
            cargo column: 'crgo__id'
        }
    }
}
