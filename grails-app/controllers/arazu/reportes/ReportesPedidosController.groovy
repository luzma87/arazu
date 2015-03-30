package arazu.reportes

import arazu.items.Item
import arazu.items.Maquinaria
import arazu.proyectos.Proyecto
import arazu.seguridad.Persona
import arazu.solicitudes.BodegaPedido
import arazu.solicitudes.Cotizacion
import arazu.solicitudes.DetalleManoObra
import arazu.solicitudes.DetalleRepuestos
import arazu.solicitudes.NotaPedido
import arazu.solicitudes.SolicitudMantenimientoExterno
import arazu.solicitudes.SolicitudMantenimientoInterno

class ReportesPedidosController {

    def notaDePedido() {
        //println "nota de pedido " + params
        def nota = NotaPedido.get(params.id)
        if (!nota) {
            response.sendError(404)
        }
        def cots = Cotizacion.findAllByPedido(nota)
        def bodegas = BodegaPedido.findAllByPedido(nota)
        return [nota: nota, cots: cots, bodegas: bodegas]
    }

    def solicitudMantenimientoExterno() {
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        if (!solicitud) {
            response.sendError(404)
        }
        def cots = Cotizacion.findAllBySolicitudMantenimientoExterno(solicitud)
        return [solicitud: solicitud, cots: cots]
    }

    def solicitudMantenimientoInterno() {
        def solicitud = SolicitudMantenimientoInterno.get(params.id)
        if (!solicitud) {
            response.sendError(404)
        }
        def detallesRepuestos = DetalleRepuestos.findAllBySolicitud(solicitud)
        def detallesManoObra = DetalleManoObra.findAllBySolicitud(solicitud)
        return [solicitud: solicitud, detallesRepuestos: detallesRepuestos, detallesManoObra: detallesManoObra]
    }

    def notasDePedido() {
        def now = new Date()
        [now: now]
    }

    def reporteNotasDePedido_ajax() {
        //println "reporte "+params
        def notas = NotaPedido.withCriteria {
            if (params.persona && params.persona != "-1") {
                eq("de", Persona.get(params.persona))
            }
            if (params.proyecto && params.proyecto != "-1") {
                eq("proyecto", Proyecto.get(params.proyecto))
            }
            if (params.maquinaria && params.maquinaria != "-1") {
                eq("maquinaria", Maquinaria.get(params.maquinaria))
            }
            if (params.item && params.item != "-1") {
                eq("item", Item.get(params.item))
            }
            if (params.desde && params.desde != "") {
                ge("fecha", new Date().parse("dd-MM-yyyy", params.desde))
            }
            if (params.hasta && params.hasta != "") {
                le("fecha", new Date().parse("dd-MM-yyyy", params.hasta))
            }
        }
        [notas: notas]
    }

    def reporteNotasDePedidoPdf() {
        println "reporte pdf" + params
        def notas = NotaPedido.withCriteria {
            if (params.persona && params.persona != "-1") {
                eq("de", Persona.get(params.persona))
            }
            if (params.proyecto && params.proyecto != "-1") {
                eq("proyecto", Proyecto.get(params.proyecto))
            }
            if (params.maquinaria && params.maquinaria != "-1") {
                eq("maquinaria", Maquinaria.get(params.maquinaria))
            }
            if (params.item && params.item != "-1") {
                eq("item", Item.get(params.item))
            }
            if (params.desde && params.desde != "") {
                ge("fecha", new Date().parse("dd-MM-yyyy", params.desde))
            }
            if (params.hasta && params.hasta != "") {
                le("fecha", new Date().parse("dd-MM-yyyy", params.hasta))
            }
        }
        [notas: notas]
    }

    def mantenimietoExterno() {
        def now = new Date()
        [now: now]
    }

    def reporteMantenimietoExterno_ajax() {
        //println "reporte "+params
        def notas = SolicitudMantenimientoExterno.withCriteria {
            if (params.persona && params.persona != "-1") {
                eq("de", Persona.get(params.persona))
            }
            if (params.proyecto && params.proyecto != "-1") {
                eq("proyecto", Proyecto.get(params.proyecto))
            }
            if (params.maquinaria && params.maquinaria != "-1") {
                eq("maquinaria", Maquinaria.get(params.maquinaria))
            }

            if (params.desde && params.desde != "") {
                ge("fecha", new Date().parse("dd-MM-yyyy", params.desde))
            }
            if (params.hasta && params.hasta != "") {
                le("fecha", new Date().parse("dd-MM-yyyy", params.hasta))
            }
        }
        [notas: notas]
    }

    def reporteMantenimietoExternoPdf() {
        println "reporte pdf" + params
        def notas = SolicitudMantenimientoExterno.withCriteria {
            if (params.persona && params.persona != "-1") {
                eq("de", Persona.get(params.persona))
            }
            if (params.proyecto && params.proyecto != "-1") {
                eq("proyecto", Proyecto.get(params.proyecto))
            }
            if (params.maquinaria && params.maquinaria != "-1") {
                eq("maquinaria", Maquinaria.get(params.maquinaria))
            }

            if (params.desde && params.desde != "") {
                ge("fecha", new Date().parse("dd-MM-yyyy", params.desde))
            }
            if (params.hasta && params.hasta != "") {
                le("fecha", new Date().parse("dd-MM-yyyy", params.hasta))
            }
        }
        [notas: notas]
    }

}
