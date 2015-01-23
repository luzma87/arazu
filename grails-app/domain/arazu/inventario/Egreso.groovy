package arazu.inventario

import arazu.seguridad.Persona

class Egreso {

    Ingreso ingreso
    Persona persona
    Date fecha
    String observaciones
    String responsable
    int cantidad

    static constraints = {
    }
}
