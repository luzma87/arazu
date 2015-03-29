package arazu.solicitudes

import arazu.items.Maquinaria
import arazu.parametros.EstadoSolicitud
import arazu.proyectos.Proyecto
import arazu.seguridad.Persona

/**
 * Clase para conectar con la tabla 'smin' de la base de datos
 */
class SolicitudMantenimientoInterno {
    /**
     * Estado del pedido
     */
    EstadoSolicitud estadoSolicitud
    /**
     * C�digo del pedido
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
     * Persona que recibe el pedido: jefe o gerente para aprobaci�n final
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
     * N�mero de solicitud
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
     * Observaciones para guardar al momento de cambiar de estado el pedido
     */
    String observaciones
    /**
     * Localizaci�n
     */
    String localizacion
    /**
     * Hor�metro
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
            observaciones column: 'sminobsv'
            observaciones type: "text"
            localizacion column: 'sminlclz'
            horometro column: 'sminhrmt'
            kilometraje column: 'sminklmt'
            detalles column: 'smindtll'
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

        paraAF nullable: true

        firmaSolicita nullable: true
        firmaAprueba nullable: true
        firmaNiega nullable: true
        observaciones blank: true, nullable: true
    }

    /**
     * Funci�n que retorna las observaciones con un formato amigable para el usuario
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
     * Funci�n que retorna el n�mero de la solicitud
     * @return
     */
    String toString() {
        return "Solicitud de mantenimiento interno n�m. ${this.numero}"
    }
}
