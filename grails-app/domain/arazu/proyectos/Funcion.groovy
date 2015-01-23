package arazu.proyectos

import arazu.parametros.Cargo
import arazu.seguridad.Persona

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

    static constraints = {
    }
}
