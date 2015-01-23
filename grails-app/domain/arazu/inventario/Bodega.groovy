package arazu.inventario

import arazu.proyectos.Proyecto
import arazu.seguridad.Persona

class Bodega {
    Proyecto proyecto
    String descripcion
    Persona persona
    String observaciones
    int activo = 1 /*1 --> activo 0--> inactivo*/

    static constraints = {
    }
}
