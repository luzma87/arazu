package arazu.solicitudes

import arazu.items.Maquinaria
import arazu.parametros.EstadoSolicitud
import arazu.proyectos.Proyecto
import arazu.seguridad.Persona

/**
 * Clase para conectar con la tabla 'smin' de la base de datos
 * Guarda los datos de una solicitud de mantenimiento interno
 */
class SolicitudMantenimientoInterno {
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
     * Persona que hace el pedido
     */
    Persona de
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
     * Número de solicitud
     */
    int numero = 0
    /**
     * Firma del que pide
     */
    Firma firmaSolicita
    /**
     * Firma del que aprueba (jefe o gerente)
     */
    Firma firmaAprueba
    /**
     * Firma del que niega
     */
    Firma firmaNiega
    /**
     * Firma del que devuelve
     */
    Firma firmaDevuelve
    /**
     * Observaciones para guardar al momento de cambiar de estado el pedido
     */
    String observaciones
    /**
     * Localización
     */
    String localizacion
    /**
     * Horómetro
     */
    Double horometro
    /**
     * Kilometraje
     */
    Double kilometraje
    /**
     * Detalles del trabajo a realizar
     */
    String detalles
    /**
     * Mecánico encargado del mantenimiento interno
     */
    Persona encargado

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
        table 'smin'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort fecha: "desc"
        columns {
            id column: 'smin__id'
            estadoSolicitud column: 'essl__id'
            codigo column: 'smincdgo'
            fecha column: 'sminfcha'
            de column: 'sminprde'
            paraAF column: 'sminpraf'
            proyecto column: 'proy__id'
            maquinaria column: 'maqn__id'
            numero column: 'sminnmro'
            firmaSolicita column: 'sminfrsl'
            firmaAprueba column: 'sminfrap'
            firmaNiega column: 'sminfrng'
            firmaDevuelve column: 'sminfrdv'
            observaciones column: 'sminobsv'
            observaciones type: "text"
            localizacion column: 'sminlclz'
            horometro column: 'sminhrmt'
            kilometraje column: 'sminklmt'
            detalles column: 'smindtll'
            detalles type: 'text'
            encargado column: 'sminpren'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        codigo maxSize: 10
        maquinaria nullable: true

        proyecto nullable: true

        paraAF nullable: true

        firmaSolicita nullable: true
        firmaAprueba nullable: true
        firmaNiega nullable: true
        firmaDevuelve nullable: true
        observaciones blank: true, nullable: true

        encargado nullable: true
    }

    /**
     * Función que retorna las observaciones con un formato amigable para el usuario
     * @return String observaciones con formato HTML
     */
    def getObservacionesFormat() {
        def html = ""
        if (this.observaciones) {
            def parts = this.observaciones.split("\\|\\|")
            html = "<ul>"
            parts.each { p ->
                html += "<li>" + p + "</li>"
            }
            html += "</ul>"
        }
        return html
    }

    /**
     * Función que retorna las observaciones con un formato amigable para el usuario
     * @return String observaciones con formato HTML
     */
    def getUltimaObservacion() {
        def html = ""
        if (this.observaciones) {
            def parts = this.observaciones.split("\\|\\|")
            html = parts.first()
//            html = "<ul>"
//            parts.each { p ->
//                html += "<li>" + p + "</li>"
//            }
//            html += "</ul>"
        }
        return html
    }

    /**
     * Función que retorna el número de la solicitud
     * @return
     */
    String toString() {
        return "Solicitud de mantenimiento interno ${this.codigo}"
    }
}
