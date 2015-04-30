package arazu.solicitudes

import arazu.items.Item
import arazu.parametros.Unidad

/**
 * Clase para conectar con la tabla 'dtrp' de la base de datos
 * Guarda los detalles de repuestos utilizados de una solicitud de mantenimiento interno
 */
class DetalleRepuestos {
    /**
     * Solicitud de mantenimiento que genera el detalle
     */
    SolicitudMantenimientoInterno solicitud
    /**
     * Cantidad de repuesto utilizado
     */
    Double cantidad
    /**
     * Unidad para el repuesto utilizado
     */
    Unidad unidad
    /**
     * Repuesto utilizado
     */
    Item item
    /**
     * C�digo o n�mero de parte
     */
    String codigo
    /**
     * Marca
     */
    String marca
    /**
     * Observaciones
     */
    String observaciones

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'dtrp'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dtrp__id'
            solicitud column: 'smin__id'
            cantidad column: 'dtrpcntd'
            unidad column: 'undd__id'
            item column: 'item__id'
            codigo column: 'dtrpcdgo'
            marca column: 'dtrpmrca'
            observaciones column: 'dtrpobsv'
            observaciones type: "text"
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        observaciones blank: true, nullable: true
    }
}
