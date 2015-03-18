import arazu.parametros.EstadoSolicitud
import arazu.parametros.MotivoSolicitud
import arazu.parametros.TipoSolicitud
import arazu.parametros.TipoUsuario
import arazu.seguridad.Accion
import arazu.seguridad.Controlador
import arazu.seguridad.Modulo
import arazu.seguridad.Permiso
import arazu.seguridad.Persona
import arazu.seguridad.Perfil
import arazu.seguridad.Sesion
import arazu.seguridad.TipoAccion

class BootStrap {

    def init = { servletContext ->
//        if (Modulo.count() == 0) {
//            def noAsignado = new Modulo()
//            noAsignado.nombre = "noAsignado"
//            noAsignado.descripcion = "Módulo por defecto"
//            noAsignado.orden = 9999
//            if (noAsignado.save(flush: true)) {
//                println "Creado modulo noAsignado"
//            } else {
//                println "error al crear modulo noAsignado: " + noAsignado.errors
//            }
//        }
//
//        if (TipoAccion.count() == 0) {
//            def menu = new TipoAccion()
//            menu.codigo = "M"
//            menu.tipo = "Menú"
//            if (menu.save(flush: true)) {
//                println "Creado tipo de acción Menú"
//            } else {
//                println "error al crear tipo de acción menú: " + menu.errors
//            }
//            def proceso = new TipoAccion()
//            proceso.codigo = "P"
//            proceso.tipo = "Proceso"
//            if (proceso.save(flush: true)) {
//                println "Creado tipo de acción Proceso"
//            } else {
//                println "error al crear tipo de acción Proceso: " + proceso.errors
//            }
//        }
//
//        if (TipoUsuario.count() == 0) {
//            def admins = new TipoUsuario()
//            admins.codigo = "ADMN"
//            admins.nombre = "Administradores"
//            admins.descripcion = "Administradores del sistema"
//            admins.activo = 1
//            if (admins.save(flush: true)) {
//                println "Creado tipo de usuario ADMN"
//            } else {
//                println "error al crear tipo de usuario ADMN: " + admins.errors
//            }
//
//            def usu = new TipoUsuario()
//            usu.codigo = "USRO"
//            usu.nombre = "Usuarios"
//            usu.descripcion = "Usuarios normales"
//            usu.activo = 1
//            if (usu.save(flush: true)) {
//                println "Creado tipo de usuario USU"
//            } else {
//                println "error al crear tipo de usuario USU: " + usu.errors
//            }
//
//            def jefes = new TipoUsuario()
//            jefes.codigo = "JEFE"
//            jefes.nombre = "Jefes"
//            jefes.descripcion = "Usuarios que pueden aprobar las notas de pedido de menos de \$100"
//            jefes.activo = 1
//            if (jefes.save(flush: true)) {
//                println "Creado tipo de usuario JEFE"
//            } else {
//                println "error al crear tipo de usuario JEFE: " + jefes.errors
//            }
//
//            def jefeC = new TipoUsuario()
//            jefeC.codigo = "JFCM"
//            jefeC.nombre = "Jefes de compras"
//            jefeC.descripcion = "Usuarios que asignan Asistentes de compras"
//            jefeC.activo = 1
//            if (jefeC.save(flush: true)) {
//                println "Creado tipo de usuario JFCM"
//            } else {
//                println "error al crear tipo de usuario JFCM: " + jefeC.errors
//            }
//
//            def asistenteC = new TipoUsuario()
//            asistenteC.codigo = "ASCM"
//            asistenteC.nombre = "Asistentes de compras"
//            asistenteC.descripcion = "Usuarios que cargan cotizaciones"
//            asistenteC.activo = 1
//            if (asistenteC.save(flush: true)) {
//                println "Creado tipo de usuario ASCM"
//            } else {
//                println "error al crear tipo de usuario ASCM: " + asistenteC.errors
//            }
//
//            def gerentes = new TipoUsuario()
//            gerentes.codigo = "GRNT"
//            gerentes.nombre = "Gerentes"
//            gerentes.descripcion = "Personas que pueden aprobar compras mayores a \$100"
//            gerentes.activo = 1
//            if (gerentes.save(flush: true)) {
//                println "Creado tipo de usuario GRNT"
//            } else {
//                println "error al crear tipo de usuario GRNT: " + gerentes.errors
//            }
//
//            def bodegas = new TipoUsuario()
//            bodegas.codigo = "RSBD"
//            bodegas.nombre = "Responsables de bodega"
//            bodegas.descripcion = "Personas que pueden ser asignadas como responsable principal o suplente de bodega"
//            bodegas.activo = 1
//            if (bodegas.save(flush: true)) {
//                println "Creado tipo de usuario RSBD"
//            } else {
//                println "error al crear tipo de usuario RSBD: " + bodegas.errors
//            }
//        }
//
//        if (Persona.count() == 0) {
//            def admin = new Persona()
//
//            admin.cedula = "1234567890"
//            admin.nombre = "Admin"
//            admin.apellido = "Admin"
//            admin.sexo = "F"
//            admin.fechaNacimiento = new Date().parse("dd-MM-yyyy", "23-01-1987")
//            admin.mail = "luzma_87@yahoo.com"
//            admin.login = "admin"
//            admin.password = "123".encodeAsMD5()
//            admin.autorizacion = "456".encodeAsMD5()
//            admin.activo = 1
//            admin.tipoUsuario = TipoUsuario.findByCodigo("ADMN")
//            if (admin.save(flush: true)) {
//                println "Creado el admin"
//            } else {
//                println "error al crear el admin: " + admin.errors
//            }
//
//            def perfil = new Perfil()
//            perfil.nombre = "Administrador"
//            perfil.descripcion = "Perfil de administración"
//            perfil.codigo = "ADM"
//            if (perfil.save(flush: true)) {
//                println "Creado el perfil admin"
//            } else {
//                println "error al crear el perfil admin: " + perfil.errors
//            }
//
//            def sesion = new Sesion()
//            sesion.usuario = admin
//            sesion.perfil = perfil
//            if (sesion.save(flush: true)) {
//                println "Creada la sesion para admin"
//            } else {
//                println "error al crear la sesion para admin: " + sesion.errors
//            }
//        }
//
//        if (EstadoSolicitud.count() == 0) {
//            def estado = new EstadoSolicitud()
//            estado.codigo = "E01"
//            estado.descripcion = "Fue solicitada y está a la espera de que un jefe la apruebe"
//            estado.nombre = "Pendiente de aprobación"
//            if (!estado.save(flush: true)) {
//                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
//            }
//            estado = new EstadoSolicitud()
//            estado.codigo = "E02"
//            estado.descripcion = "Fue aprobada por un jefe y está a la espera de que un jefe de compras asigne a un asistente de compras para las cotizaciones"
//            estado.nombre = "Pendiente de asignación"
//            if (!estado.save(flush: true)) {
//                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
//            }
//            estado = new EstadoSolicitud()
//            estado.codigo = "E03"
//            estado.descripcion = "Un asistente de compras fue asignado y está a la espera del registro de las cotizaciones"
//            estado.nombre = "Pendientes cotizaciones"
//            if (!estado.save(flush: true)) {
//                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
//            }
//            estado = new EstadoSolicitud()
//            estado.codigo = "E04"
//            estado.descripcion = "Las cotizaciones fueron registradas y está a la espera de la aprobación final"
//            estado.nombre = "Pendiente de aprobación final"
//            if (!estado.save(flush: true)) {
//                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
//            }
//            estado = new EstadoSolicitud()
//            estado.codigo = "N01"
//            estado.descripcion = "La solicitud fue negada"
//            estado.nombre = "Negada"
//            if (!estado.save(flush: true)) {
//                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
//            }
//            estado = new EstadoSolicitud()
//            estado.codigo = "A01"
//            estado.descripcion = "La solicitud fue aprobada y se procederá a su adquisición"
//            estado.nombre = "Aprobada"
//            if (!estado.save(flush: true)) {
//                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
//            }
//            estado = new EstadoSolicitud()
//            estado.codigo = "B01"
//            estado.descripcion = "El item solicitado existe en bodega y se procederá al envío"
//            estado.nombre = "En bodega"
//            if (!estado.save(flush: true)) {
//                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
//            }
//            estado = new EstadoSolicitud()
//            estado.codigo = "C01"
//            estado.descripcion = "El item solicitado fue ingresado en una bodega"
//            estado.nombre = "Completada"
//            if (!estado.save(flush: true)) {
//                println "ocurrio un error al guardar ${estado.nombre}: " + estado.errors
//            }
//        }
//
//        if (TipoSolicitud.count() == 0) {
//            def ts = new TipoSolicitud()
//            ts.codigo = "NTPD"
//            ts.nombre = "Nota de pedido"
//            ts.descripcion = "Notas de pedido de compra de repuestos"
//            if (ts.save(flush: true)) {
//                println "Creado tipo de solicitud ${ts.nombre}"
//            } else {
//                println "Error al crear tipo de solicitud ${ts.nombre}: " + ts.errors
//            }
//
//            ts = new TipoSolicitud()
//            ts.codigo = "SMNE"
//            ts.nombre = "Mantenimiento externo"
//            ts.descripcion = "Solicitud de mantenimiento de vehículos y maquinaria externo"
//            if (ts.save(flush: true)) {
//                println "Creado tipo de solicitud ${ts.nombre}"
//            } else {
//                println "Error al crear tipo de solicitud ${ts.nombre}: " + ts.errors
//            }
//
//            ts = new TipoSolicitud()
//            ts.codigo = "SMNI"
//            ts.nombre = "Mantenimiento interno"
//            ts.descripcion = "Solicitud de mantenimiento interno"
//            if (ts.save(flush: true)) {
//                println "Creado tipo de solicitud ${ts.nombre}"
//            } else {
//                println "Error al crear tipo de solicitud ${ts.nombre}: " + ts.errors
//            }
//        }
//
//        if (MotivoSolicitud.count() == 0) {
//            def mtv = new MotivoSolicitud()
//            mtv.nombre = "Mantenimiento"
//            if (mtv.save(flush: true)) {
//                println "Creado motivo de solicitud ${mtv.nombre}"
//            } else {
//                println "Error al crear motivo de solicitud ${mtv.nombre}: " + mtv.errors
//            }
//
//            mtv = new MotivoSolicitud()
//            mtv.nombre = "Reparación"
//            if (mtv.save(flush: true)) {
//                println "Creado motivo de solicitud ${mtv.nombre}"
//            } else {
//                println "Error al crear motivo de solicitud ${mtv.nombre}: " + mtv.errors
//            }
//
//            mtv = new MotivoSolicitud()
//            mtv.nombre = "Stock"
//            if (mtv.save(flush: true)) {
//                println "Creado motivo de solicitud ${mtv.nombre}"
//            } else {
//                println "Error al crear motivo de solicitud ${mtv.nombre}: " + mtv.errors
//            }
//        }
//
//        if (Permiso.count() == 0) {
//            def controlador = Controlador.findAllByNombre("Acciones")
//            if (controlador.size() == 0) {
//                controlador = new Controlador()
//                controlador.nombre = "Acciones"
//                if (controlador.save(flush: true)) {
//                    println "Creado controlador Acciones"
//                } else {
//                    println "error al crear controlador Acciones: " + controlador.errors
//                }
//            } else {
//                controlador = controlador.first()
//            }
//            if (Accion.countByNombre("acciones") == 0) {
//                def accion = new Accion()
//                accion.nombre = "acciones"
//                accion.descripcion = "Configuración del menú"
//                accion.esAuditable = 1
//                accion.control = controlador
//                accion.modulo = Modulo.findByNombre("noAsignado")
//                accion.tipo = TipoAccion.findByCodigo("M")
//                accion.orden = 1
//                accion.icono = "fa fa-server"
//                if (accion.save(flush: true)) {
//                    println "Creada accion acciones"
//                } else {
//                    println "error al crear accion acciones: " + accion.errors
//                }
//            }
//
//            def admin = Perfil.findByCodigo("ADM")
//
//            def permiso = new Permiso()
//            permiso.accion = Accion.findByNombre("acciones")
//            permiso.perfil = admin
//            if (permiso.save(flush: true)) {
//                println "Creado permiso para acciones para admin"
//            } else {
//                println "error al crear permiso para acciones para admin: " + permiso.errors
//            }
//        }
    }
    def destroy = {
    }
}
