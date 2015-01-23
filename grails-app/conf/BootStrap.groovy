import arazu.seguridad.Persona
import arazu.seguridad.Perfil
import arazu.seguridad.Sesion

class BootStrap {

    def init = { servletContext ->

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

    }
    def destroy = {
    }
}
