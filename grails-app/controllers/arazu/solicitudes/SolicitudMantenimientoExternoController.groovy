package arazu.solicitudes

import arazu.items.Item
import arazu.parametros.TipoUsuario
import arazu.seguridad.Persona
import arazu.seguridad.Shield

class SolicitudMantenimientoExternoController extends Shield {

    def firmaService
    def notificacionService

    /**
     * Acción que muestra la pantalla de ingreso de una nueva nsolicitud de mantenimiento externo
     */
    def pedido() {
        def usu = Persona.get(session.usuario.id)
        if (!usu.autorizacion) {
            flash.message = "Tiene que establecer una clave de autorización para poder firmar los documentos. " +
                    "<br/>Presione el botón 'Olvidé mi autorización' e ingrese su e-mail registrado para recibir una clave temporal que puede después modificar." +
                    "<br/>Si no tiene un e-mail registrado contáctese con un administrador del sistema."
            flash.tipo = "error"
            redirect(controller: "persona", action: "personal")
            return
        }
        def numero = NotaPedido.list([sort: "numero", order: "desc", limit: 1])
        if (numero.size() > 0)
            numero = numero.first().numero + 1
        else
            numero = 1
        def items = Item.list([sort: "descripcion"])
        def itemStr = ""
        itemStr += items.collect { '"' + it.descripcion.trim() + '"' }

        def jefes = Persona.findAllByTipoUsuario(TipoUsuario.findByCodigo("JFCM"), [sort: 'apellido'])

        return [numero: numero, items: itemStr, jefes: jefes]
    }
}
