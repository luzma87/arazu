package arazu.items

import arazu.parametros.Color
import arazu.parametros.TipoMaquinaria

/**
 *  Clase para conectar con la tabla 'maqn' de la base de datos
 */
class Maquinaria {
    /**
     * Tipo de maquinaria
     */
    TipoMaquinaria tipo
    /**
     * Descripción de la maquinaria
     */
    String descripcion
    /**
     * Placa de la maquinaria
     */
    String placa
    /**
     * Año de la maquinaria
     */
    int anio
    /**
     * Marca de la maquinaria
     */
    String marca
    /**
     * Modelo de la maquinaria
     */
    String modelo
    /**
     * Observaciones
     */
    String observaciones
    /**
     * Color de la maquinaria
     */
    Color color
    /**
     * Código de la maquinaria
     */
    String codigo

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'maqn'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort descripcion: "asc"
        columns {
            id column: 'maqn__id'
            tipo column: 'tpmq__id'
            descripcion column: 'maqndscr'
            placa column: 'maqnplca'
            anio column: 'maqnanio'
            marca column: 'maqnmrca'
            observaciones column: 'maqnobsr'
            color column: 'clor__id'
            codigo column: 'maqncdgo'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        descripcion(nullable: true, blank: true, size: 1..255)
        observaciones(nullable: true, blank: true, size: 1..1023)
        tipo(nullable: false, blank: false)
        placa(nullable: true, blank: true, size: 1..20)
        marca(nullable: true, blank: true, size: 1..50)
        modelo(nullable: true, blank: true, size: 1..50)
        color(nullable: false, blank: false)
        codigo(nullable: true, blank: true, size: 1..50)
    }

    /**
     * Genera un string para mostrar
     * @return la descripción
     */
    String toString() {
        "${this.codigo ? this.codigo + ' - ' : ''}${this.marca} ${this.modelo} - " +
                "${this.descripcion.size() > 40 ? this.descripcion[0..40] + '...' : this.descripcion}"
    }
}
