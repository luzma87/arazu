package arazu.solicitudes

import arazu.alertas.Alerta
import arazu.parametros.Parametros
import arazu.seguridad.Persona
import grails.util.Holders

/**
 * Servicio para realizar notificaciones: alerta en el sistema y e-mail
 */
class NotificacionService {

    def g = new org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib()
    def mailService

    def notificacionCompleta(Persona envia, Persona recibe, paramsAlerta, paramsMail) {
        def now = new Date()
        def msg = ""
        def alerta = new Alerta()
        alerta.envia = envia
        alerta.recibe = recibe
        alerta.fechaEnvio = now
        alerta.mensaje = paramsAlerta.mensaje
        alerta.controlador = paramsAlerta.controlador
        alerta.accion = paramsAlerta.accion
        if (!alerta.save(flush: true)) {
            println "Error al generar la alerta: " + alerta.errors
            msg += "<li>Ha ocurrido un error al generar la alerta: " + alerta.errors + "</li>"
        }

        def logo = Parametros.getLogoLogin()
        def logoFile = Holders.getGrailsApplication().mainContext.getResource('/images/' + logo).getFile().readBytes()

        try {
            println "Mandando email a " + alerta.recibe.mail + "...."
            mailService.sendMail {
                multipart true
                to alerta.recibe.mail
                subject paramsMail.subject
                html g.render(template: paramsMail.template, model: paramsMail.model)
                inline 'logo', 'image/png', logoFile
            }
        } catch (Exception e) {
            println "error en el mail: "
            e.printStackTrace()
            msg += "<li>Ha ocurrido un error al enviar el mail</li>"
        }
        return msg
    }
}
