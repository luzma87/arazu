import arazu.parametros.EstadoSolicitud
import arazu.parametros.TipoUsuario
import arazu.seguridad.Modulo
import arazu.seguridad.Persona
import arazu.seguridad.Perfil
import arazu.seguridad.Sesion
import arazu.seguridad.TipoAccion

class BootStrap {

    def init = { servletContext ->

        if (Modulo.count() == 0) {
            def noAsignado = new Modulo()
            noAsignado.nombre = "noAsignado"
            noAsignado.descripcion = "Módulo por defecto"
            noAsignado.orden = 9999
            if (noAsignado.save(flush: true)) {
                println "Creado modulo noAsignado"
            } else {
                println "error al crear modulo noAsignado: " + noAsignado.errors
            }
        }

        if (TipoAccion.count() == 0) {
            def menu = new TipoAccion()
            menu.codigo = "M"
            menu.tipo = "Menú"
            if (menu.save(flush: true)) {
                println "Creado tipo de acción Menú"
            } else {
                println "error al crear tipo de acción menú: " + menu.errors
            }
            def proceso = new TipoAccion()
            proceso.codigo = "P"
            proceso.tipo = "Proceso"
            if (proceso.save(flush: true)) {
                println "Creado tipo de acción Proceso"
            } else {
                println "error al crear tipo de acción Proceso: " + proceso.errors
            }
        }

        if (TipoUsuario.count() == 0) {
            def admins = new TipoUsuario()
            admins.codigo = "ADMN"
            admins.nombre = "Administradores"
            admins.descripcion = "Administradores del sistema"
            admins.activo = 1
            if (admins.save(flush: true)) {
                println "Creado tipo de usuario ADMN"
            } else {
                println "error al crear tipo de usuario ADMN: " + admins.errors
            }

            def gerentes = new TipoUsuario()
            gerentes.codigo = "GRNT"
            gerentes.nombre = "Gerentes"
            gerentes.descripcion = "Personas que pueden aprobar compras mayores a \$100"
            gerentes.activo = 1
            if (gerentes.save(flush: true)) {
                println "Creado tipo de usuario GRNT"
            } else {
                println "error al crear tipo de usuario GRNT: " + gerentes.errors
            }

            def jefes = new TipoUsuario()
            jefes.codigo = "JEFE"
            jefes.nombre = "Jefes"
            jefes.descripcion = "Usuarios que pueden aprobar las notas de pedido de menos de \$100"
            jefes.activo = 1
            if (jefes.save(flush: true)) {
                println "Creado tipo de usuario JEFE"
            } else {
                println "error al crear tipo de usuario JEFE: " + jefes.errors
            }

            def bodegas = new TipoUsuario()
            bodegas.codigo = "RSBD"
            bodegas.nombre = "Responsables de bodega"
            bodegas.descripcion = "Personas que pueden ser asignadas como responsable principal o suplente de bodega"
            bodegas.activo = 1
            if (bodegas.save(flush: true)) {
                println "Creado tipo de usuario RSBD"
            } else {
                println "error al crear tipo de usuario RSBD: " + bodegas.errors
            }
        }

        if (Persona.count() == 0) {
            def admin = new Persona()

            admin.cedula = "1715068159"
            admin.nombre = "Luz"
            admin.apellido = "Unda"
            admin.sexo = "F"
            admin.fechaNacimiento = new Date().parse("dd-MM-yyyy", "23-01-1987")
            admin.mail = "luzma_87@yahoo.com"
            admin.login = "admin"
            admin.password = "123".encodeAsMD5()
            admin.autorizacion = "456".encodeAsMD5()
            admin.activo = 1
            admin.tipoUsuario = TipoUsuario.findByCodigo("ADMN")
            if (admin.save(flush: true)) {
                println "Creado el admin"
            } else {
                println "error al crear el admin: " + admin.errors
            }

            def perfil = new Perfil()
            perfil.nombre = "Administrador"
            perfil.descripcion = "Perfil de administración"
            perfil.codigo = "ADM"
            if (perfil.save(flush: true)) {
                println "Creado el perfil admin"
            } else {
                println "error al crear el perfil admin: " + perfil.errors
            }

            def sesion = new Sesion()
            sesion.usuario = admin
            sesion.perfil = perfil
            if (sesion.save(flush: true)) {
                println "Creada la sesion para admin"
            } else {
                println "error al crear la sesion para admin: " + sesion.errors
            }
        }

        if (EstadoSolicitud.count() == 0) {
            def estado = new EstadoSolicitud()
            estado.codigo = "E01"
            estado.descripcion = "Fue solicitada y está a la espera de que un jefe la apruebe"
            estado.nombre = "Pendiente de aprobación"
            if (!estado.save(flush: true)) {
                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
            }
            estado = new EstadoSolicitud()
            estado.codigo = "E02"
            estado.descripcion = "Fue aprobada por un jefe y está a la espera de que un jefe de compras asigne a un asistente de compras para las cotizaciones"
            estado.nombre = "Pendiente de asignación"
            if (!estado.save(flush: true)) {
                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
            }
            estado = new EstadoSolicitud()
            estado.codigo = "E03"
            estado.descripcion = "Un asistente de compras fue asignado y está a la espera del registro de las cotizaciones"
            estado.nombre = "Pendientes cotizaciones"
            if (!estado.save(flush: true)) {
                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
            }
            estado = new EstadoSolicitud()
            estado.codigo = "E04"
            estado.descripcion = "Las cotizaciones fueron registradas y está a la espera de la aprobación final"
            estado.nombre = "Pendiente de aprobación final"
            if (!estado.save(flush: true)) {
                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
            }
            estado = new EstadoSolicitud()
            estado.codigo = "N01"
            estado.descripcion = "La solicitud fue negada"
            estado.nombre = "Negada"
            if (!estado.save(flush: true)) {
                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
            }
            estado = new EstadoSolicitud()
            estado.codigo = "A01"
            estado.descripcion = "La solicitud fue aprobada y se procederá a su adquisición"
            estado.nombre = "Aprobada"
            if (!estado.save(flush: true)) {
                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
            }
            estado = new EstadoSolicitud()
            estado.codigo = "B01"
            estado.descripcion = "El item solicitado existe en bodega y se procederá al envío"
            estado.nombre = "En bodega"
            if (!estado.save(flush: true)) {
                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
            }
        }
    }
    def destroy = {
    }
}
