package arazu.solicitudes

import arazu.items.Item
import arazu.items.Maquinaria
import arazu.parametros.EstadoSolicitud
import arazu.parametros.TipoSolicitud
import arazu.parametros.Unidad
import arazu.proyectos.Proyecto
import arazu.seguridad.Persona

/**
 * Clase para conectar con la tabla 'pddo' de la base de datos
 */
class Pedido {
    /**
     * Tipo de solicitud para el pedido
     */
    TipoSolicitud tipoSolicitud
    /**
     * Estado del pedido
     */
    EstadoSolicitud estadoSolicitud
    /**
     * Código del pedido
     */
    String codigo
    /**
     * Fecha del pedido
     */
    Date fecha
    /**
     * Persona que hacce el pedido
     */
    Persona de
    /**
     * Persona que recibe el pedido
     */
    Persona para
    /**
     * Proyecto para el cual se hace el pedido
     */
    Proyecto proyecto
    /**
     * Maquinaria para la cual se hace el pedido
     */
    Maquinaria maquinaria
    /**
     * Cantidad del item que se requiere
     */
    Double cantidad
    /**
     * Unidad en la cual se hace el pedido
     */
    Unidad unidad
    /**
     * Item requerido
     */
    Item item
    /**
     * Persona que aprueba el pedido
     */
    Persona aprobadoPor
    /**
     * Fecha en la que fue aprobado el pedido
     */
    Date aprobacion

    /**
     * Define las relaciones uno a varios
     */
    static hasMany = [cotizaciones: Cotizacion]
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'pddo'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort fecha: "desc"
        columns {
            id column: 'pddo__id'
            tipoSolicitud column: 'tpsl__id'
            estadoSolicitud column: 'essl__id'
            codigo column: 'pddocdgo'
            fecha column: 'pddofcha'
            de column: 'pddoprde'
            para column: 'pddoprpr'
            proyecto column: 'proy__id'
            maquinaria column: 'maqn__id'
            cantidad column: 'pddocntd'
            unidad column: 'undd__id'
            item column: 'item__id'
            aprobadoPor column: 'pddoprap'
            aprobacion column: 'pddofcap'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        codigo maxSize: 4
        maquinaria nullable: true
        aprobadoPor nullable: true
        aprobacion nullable: true
    }
}
