package arazu.solicitudes

import arazu.parametros.Parametros
import arazu.seguridad.Persona

/**
 * Servicio para firmar electronicamente documentos
 */
class FirmaService {
    /*
      *Ubicación de la carpeta de firmas
      */
    String path = "firmas/"
//    def qrCodeService
    def QRCodeService

    def servletContext
    static transactional = true
    def g = new org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib()

    /**
     * Firma digitalmente un documento (firma existente)
     * @param usuario es el usuario que firma
     * @param password es la contraseña de autorizacion del usuario encriptada con MD5
     * @param firma es el objeto de tipo firma que se va a generar
     * @param baseUri es el path base de la aplicación (def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort)
     * @return un objeto de tipo firma con la información de la firma electrónica
     */
    def firmarDocumento(Long usuario, String password, Firma firma, String baseUri) {
        def user = Persona.get(usuario)
        if (firma.persona != user) {
            return "El usuario no concuerda con la firma"
        }
        if (user.autorizacion == password) {
            try {
                def now = new Date()
                def key = ""
                def texto = baseUri + g.createLink(controller: "firma", action: "verDocumento") + "?ky="
                def pathQr = servletContext.getRealPath("/") + path
                new File(pathQr).mkdirs()
                key = now.format("ddMMyyyyhhmmss.SSS").encodeAsMD5() + (user.login.encodeAsMD5().substring(0, 10)) + (user.autorizacion.substring(10, 20))
                texto += key

                def nombre = user.login + "_" + now.format("yyyyMMdd_HHmm") + ".png"

                def logo = servletContext.getRealPath("/") + "images/" + Parametros.getLogoQr()
                Map information = [chl: texto]
                information.chs = "250x250"
                QRCodeService.createQRCode(information, logo, pathQr, nombre)

                firma.key = key
                firma.path = nombre
//                firma.estado = "F"
                if (!firma.save(flush: true)) {
                    println "Ha ocurrido un error al firmar el documento: " + firma.errors
                    return "No se pudo generar la firma: " + g.renderErrors(bean: firma)
                }
                return firma
            } catch (e) {
                println "error al generar la firma \n " + e.printStackTrace()
                return "No se pudo generar la firma"
            }
        } else {
            return "La clave de autorización es incorrecta"
        }
    }
}