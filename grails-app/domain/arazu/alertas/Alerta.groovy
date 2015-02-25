package arazu.alertas

import arazu.seguridad.Persona

/**
 * Clase para conectar con la tabla 'alertas' de la base de datos
 */
class Alerta {

    /**
     * Usuario que envía la alerta
     */
    Persona envia
    /**
     * Usuario que recibe la alerta
     */
    Persona recibe
    /**
     * Fecha de envío de la alerta
     */
    Date fechaEnvio
    /**
     * Fecha de recepción de la alerta
     */
    Date fechaRecibido
    /**
     * Mensaje a enviar con la alerta
     */
    String mensaje
    /**
     * Controlador al cual se va a redireccionar al hacer clic en la alerta
     */
    String controlador
    /**
     * Acción a la cual se va a redireccionar al hacer clic en la alerta
     */
    String accion
    /**
     * Id necesario para el redireccionamiento
     */
    int id_remoto

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: ['fechaEnvio', 'fechaRecibido']]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'alrt'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort fechaEnvio: "desc"
        columns {
            id column: 'alrt__id'
            envia column: 'alrtfrom'
            recibe column: 'alrt__to'
            fechaEnvio column: 'alrtfcen'
            fechaRecibido column: 'alrtfcrc'
            mensaje column: 'alrtmesn'
            controlador column: 'alrtctrl'
            accion column: 'alrtaccn'
            id_remoto column: 'alrtidrm'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        envia(blank: false)
        recibe(blank: false)
        fechaEnvio(blank: false)
        fechaRecibido(nullable: true, blank: true)
        mensaje(size: 5..200, blank: false)
        controlador(nullable: true, blank: true)
        accion(nullable: true, blank: true)
        id_remoto(nullable: true, blank: true)
    }

    /**
     * Genera un string para mostrar
     * @return el id y el mensaje concatenados
     */
    String toString() {
        return "${this.id} ${this.mensaje}"
    }

    def static cantAlertasPersonaPorTipo(Persona usuario) {
        def count = [:]
        def alertas = alertasPersona(usuario)
        def c = alertas.size()
        alertas.each { alerta ->
            def tipo = "d" + (((new Date()) - alerta.fechaEnvio) > 2) ? "mas" : (new Date()) - alerta.fechaEnvio
            if (!count[tipo]) {
                count[tipo] = 0
            }
            count[tipo] += 1
        }
        count.total = c
        return count
    }

    def static alertasPersona(Persona usuario) {
        return findAllByRecibeAndFechaRecibidoIsNull(usuario)
    }

    def static cantAlertasPersona(Persona usuario) {
        return alertasPersona(usuario).size()
    }

}
