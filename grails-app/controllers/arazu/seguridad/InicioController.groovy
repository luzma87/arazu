package arazu.seguridad

import arazu.alertas.Alerta
import arazu.inventario.Bodega
import arazu.parametros.EstadoSolicitud
import arazu.proyectos.Proyecto
import arazu.solicitudes.Pedido

class InicioController extends Shield {

    def index() {
        def pr = Pedido.findAllByEstadoSolicitud(EstadoSolicitud.findByCodigo("E01"))
        def pa = Pedido.findAllByEstadoSolicitud(EstadoSolicitud.findByCodigo("E02"))
        def aprobadas = Pedido.findAllByEstadoSolicitud(EstadoSolicitud.findByCodigo("A01"))
        def ejecutadas = Pedido.findAllByEstadoSolicitud(EstadoSolicitud.findByCodigo("C01"))
        def alertas = Alerta.findAllByRecibeAndFechaRecibidoIsNull(session.usuario)
        def bodegas = Bodega.findAllByActivo(1)
        def proyectos = Proyecto.findAllByFechaFinIsNullOrFechaFinGreaterThan(new Date())
        [pr:pr,pa:pa,aprobadas:aprobadas,ejecutadas:ejecutadas,alertas:alertas,bodegas:bodegas,proyectos:proyectos]
    }

    def demoUI() {

    }

    def parametros() {

    }
}


