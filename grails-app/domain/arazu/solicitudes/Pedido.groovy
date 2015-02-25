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
     * Persona que recibe el pedido: jefe
     */
    Persona para
    /**
     * Persona que recibe el pedido: jefe de compras
     */
    Persona paraJC
    /**
     * Persona que recibe el pedido: asistente de compras
     */
    Persona paraAC
    /**
     * Persona que recibe el pedido: jefe o gerente para aprobación final
     */
    Persona paraAF
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
     * Fecha en la que fue aprobado el pedido
     */
    Date aprobacion
    /**
     * Número de solicitud
     */
    int numero = 0
    /**
     * Firma del que pide
     */
    Firma firmaSolicita
    /**
     * Firma del jefe
     */
    Firma firmaJefe
    /**
     * Firma del jefe de compras
     */
    Firma firmaJefeCompras
    /**
     * Firma del asistente de compras
     */
    Firma firmaAsistenteCompras
    /**
     * Firma del que aprueba (jefe si <100, gerente si >=100)
     */
    Firma firmaAprueba
    /**
     * Firma del que niega
     */
    Firma firmaNiega
    /**
     * Firma del que notifica q existe en bodega
     */
    Firma firmaBodega
    /**
     * Observaciones para guardar al momento de cambiar de estado el pedido
     */
    String observaciones

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
            paraJC column: 'pddoprjc'
            paraAC column: 'pddoprac'
            paraAF column: 'pddopraf'
            proyecto column: 'proy__id'
            maquinaria column: 'maqn__id'
            cantidad column: 'pddocntd'
            unidad column: 'undd__id'
            item column: 'item__id'
            aprobacion column: 'pddofcap'
            numero column: 'pddonmro'
            firmaSolicita column: 'pddofrsl'
            firmaJefe column: 'pddofrjf'
            firmaJefeCompras column: 'pddofrjc'
            firmaAsistenteCompras column: 'pddofrac'
            firmaAprueba column: 'pddofrap'
            firmaNiega column: 'pddofrng'
            firmaBodega column: 'pddofrbd'
            observaciones column: 'pddoobsv'
            observaciones type: "text"
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        codigo maxSize: 10
        maquinaria nullable: true
        aprobacion nullable: true

        paraJC nullable: true
        paraAC nullable: true
        paraAF nullable: true

        firmaSolicita nullable: true
        firmaJefe nullable: true
        firmaJefeCompras nullable: true
        firmaAsistenteCompras nullable: true
        firmaAprueba nullable: true
        firmaNiega nullable: true
        firmaBodega nullable: true
        observaciones blank: true, nullable: true
    }
}
