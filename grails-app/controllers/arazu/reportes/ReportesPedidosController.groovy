package arazu.reportes

import arazu.items.Item
import arazu.items.Maquinaria
import arazu.parametros.EstadoSolicitud
import arazu.proyectos.Proyecto
import arazu.seguridad.Persona
import arazu.solicitudes.BodegaPedido
import arazu.solicitudes.Cotizacion
import arazu.solicitudes.DetalleManoObra
import arazu.solicitudes.DetalleRepuestos
import arazu.solicitudes.NotaPedido
import arazu.solicitudes.SolicitudMantenimientoExterno
import arazu.solicitudes.SolicitudMantenimientoInterno

/**
 * Controlador que muestra las pantallas de manejo de Reportes de pedidos
 */
class ReportesPedidosController {

    /**
     * Acción que muestra el pdf de una nota de pedido
     */
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

    /**
     * Acción que muestra el pdf de una solicitud de mantenimiento externo
     */
    def solicitudMantenimientoExterno() {
        def solicitud = SolicitudMantenimientoExterno.get(params.id)
        if (!solicitud) {
            response.sendError(404)
        }
        def cots = Cotizacion.findAllBySolicitudMantenimientoExterno(solicitud)
        return [solicitud: solicitud, cots: cots]
    }

    /**
     * Acción que muestra el pdf de una solicitud de mantenimiento interno
     */
    def solicitudMantenimientoInterno() {
        def solicitud = SolicitudMantenimientoInterno.get(params.id)
        if (!solicitud) {
            response.sendError(404)
        }
        def detallesRepuestos = DetalleRepuestos.findAllBySolicitud(solicitud)
        def detallesManoObra = DetalleManoObra.findAllBySolicitud(solicitud)
        return [solicitud: solicitud, detallesRepuestos: detallesRepuestos, detallesManoObra: detallesManoObra]
    }

    /**
     * Acción llamada con ajax que muestra una tabla con los resultados del filtro aplicado para el reporte de notas de pedido
     */
    def reporteNotasDePedido_ajax() {
        //println "reporte "+params
        return [notas: buscaNotaPedido_funcion(params)]
    }

    /**
     * Accidn que muestra el reporte de notas de pedido en formato PDF
     */
    def reporteNotasDePedidoPdf() {
//        println "reporte pdf" + params
        return [notas: buscaNotaPedido_funcion(params)]
    }

    /**
     * Acción llamada con ajax que muestra una tabla con los resultados del filtro aplicado para el reporte de solicitudes de mantenimiento externo
     */
    def reporteMantenimientoExterno_ajax() {
        //println "reporte "+params
        return [notas: buscaMantenimientoExterno_funcion(params)]
    }

    /**
     * Accidn que muestra el reporte de solicitudes de mantenimiento externo en formato PDF
     */
    def reporteMantenimientoExternoPdf() {
//        println "reporte pdf" + params
        return [notas: buscaMantenimientoExterno_funcion(params)]
    }

    /**
     * Acción llamada con ajax que muestra una tabla con los resultados del filtro aplicado para el reporte de solicitudes de mantenimiento interno
     */
    def reporteMantenimientoInterno_ajax() {
        //println "reporte "+params
        return [notas: buscaMantenimientoInterno_funcion(params)]
    }

    /**
     * Acción que muestra el reporte de solicitudes de mantenimiento interno en formato PDF
     */
    def reporteMantenimientoInternoPdf() {
//        println "reporte pdf" + params
        return [notas: buscaMantenimientoInterno_funcion(params)]
    }

    /**
     * Función que recibe como parámetros los filtros ingresados por el usuario y retorna el arreglo de notas de pedido filtrado
     */
    def buscaNotaPedido_funcion(params) {
        def notas = NotaPedido.withCriteria {
            if (params.estado && params.estado != "-1") {
                eq("estadoSolicitud", EstadoSolicitud.get(params.estado))
            }
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
        return notas
    }

    /**
     * Función que recibe como parámetros los filtros ingresados por el usuario y retorna el arreglo de solicitudes de mantenimiento externo filtrado
     */
    def buscaMantenimientoExterno_funcion(params) {
        def notas = SolicitudMantenimientoExterno.withCriteria {
            if (params.estado && params.estado != "-1") {
                eq("estadoSolicitud", EstadoSolicitud.get(params.estado))
            }
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
        return notas
    }

    /**
     * Función que recibe como parámetros los filtros ingresados por el usuario y retorna el arreglo de solicitudes de mantenimiento interno filtrado
     */
    def buscaMantenimientoInterno_funcion(params) {
        def notas = SolicitudMantenimientoInterno.withCriteria {
            if (params.estado && params.estado != "-1") {
                eq("estadoSolicitud", EstadoSolicitud.get(params.estado))
            }
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
        return notas
    }

}
