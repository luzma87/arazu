package arazu.solicitudes

import arazu.items.Maquinaria
import arazu.parametros.EstadoSolicitud
import arazu.proyectos.Proyecto
import arazu.seguridad.Persona

/**
 * Clase para conectar con la tabla 'smex' de la base de datos
 */
class SolicitudMantenimientoExterno {
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
     * Número de solicitud
     */
    int numero = 0
    /**
     * Firma del que pide
     */
    Firma firmaSolicita
    /**
     * Firma del jefe de compras
     */
    Firma firmaJefeCompras
    /**
     * Firma del asistente de compras
     */
    Firma firmaAsistenteCompras
    /**
     * Firma del que aprueba (jefe si <200, gerente si >=200)
     */
    Firma firmaAprueba
    /**
     * Firma del que niega
     */
    Firma firmaNiega
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
        table 'smex'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort fecha: "desc"
        columns {
            id column: 'smex__id'
            estadoSolicitud column: 'essl__id'
            codigo column: 'smexcdgo'
            fecha column: 'smexfcha'
            de column: 'smexprde'
            paraJC column: 'smexprjc'
            paraAC column: 'smexprac'
            paraAF column: 'smexpraf'
            proyecto column: 'proy__id'
            maquinaria column: 'maqn__id'
            numero column: 'smexnmro'
            firmaSolicita column: 'smexfrsl'
            firmaJefeCompras column: 'smexfrjc'
            firmaAsistenteCompras column: 'smexfrac'
            firmaAprueba column: 'smexfrap'
            firmaNiega column: 'smexfrng'
            observaciones column: 'smexobsv'
            observaciones type: "text"
            localizacion column: 'smexlclz'
            horometro column: 'smexhrmt'
            kilometraje column: 'smexklmt'
            detalles column: 'smexdtll'
            detalles type: 'text'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        codigo maxSize: 10
        maquinaria nullable: true

        proyecto nullable: true

        paraJC nullable: true
        paraAC nullable: true
        paraAF nullable: true

        firmaSolicita nullable: true
        firmaJefeCompras nullable: true
        firmaAsistenteCompras nullable: true
        firmaAprueba nullable: true
        firmaNiega nullable: true
        observaciones blank: true, nullable: true
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
     * Función que retorna el número de la solicitud
     * @return
     */
    String toString() {
        return "Solicitud de mantenimiento externo núm. ${this.numero}"
    }
}
