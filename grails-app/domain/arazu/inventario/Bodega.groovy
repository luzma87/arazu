package arazu.inventario

import arazu.proyectos.Proyecto
import arazu.seguridad.Persona

/**
 *  Clase para conectar con la tabla 'bdga' de la base de datos
 */
class Bodega {
    /**
     * Proyecto al cual pertenece la bodega
     */
    Proyecto proyecto
    /**
     * Descripción de la bodega
     */
    String descripcion
    /**
     * Bodeguero
     */
    Persona responsable
    /**
     * Bodeguero suplente
     */
    Persona suplente
    /**
     * Observaciones
     */
    String observaciones
    /**
     * Indica si está o no activa la bodega (1 --> activo 0 --> inactivo)
     */
    int activo = 1
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'bdga'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort descripcion: "asc"
        columns {
            id column: 'bdga__id'
            proyecto column: 'proy__id'
            descripcion column: 'bdgadscr'
            responsable column: 'prsnrspn'
            suplente column: 'prsnspln'
            observaciones column: 'bdgaobsr'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        descripcion(nullable: true, blank: true, size: 1..50)
        observaciones(nullable: true, blank: true, size: 1..1023)
        proyecto(nullable: true, blank: true)
        responsable(nullable: false, blank: false)
        suplente(nullable: true, blank: true)
    }

    /**
     * Genera un string para mostrar
     * @return la descripción
     */
    String toString() {
        return this.descripcion
    }

    def actualizaObservaciones(Persona usuario, String nuevaObs) {
        if (nuevaObs && nuevaObs != "" && nuevaObs != null) {
            def str = "<strong><em>" + usuario.login + "</em> " + new Date().format("dd-MM-yyyy HH:mm") + ":</strong> " + nuevaObs
            if (this.observaciones && this.observaciones.trim() != "") {
                this.observaciones = str + "; " + this.observaciones
            } else {
                this.observaciones = str
            }
        }
    }
}
