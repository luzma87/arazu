package arazu.inventario

import arazu.alertas.Alerta
import arazu.items.Item
import arazu.parametros.Unidad
import arazu.proyectos.Proyecto
import arazu.seguridad.Persona
import org.springframework.dao.DataIntegrityViolationException
import arazu.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Bodega
 */
class BodegaController extends Shield {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
     */
    def getList_funcion(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search != null) {
            def c1 = Bodega.createCriteria()
            def l1 = c1.list(params) {
                or {
                    ilike("descripcion", "%" + params.search + "%")
                    ilike("observaciones", "%" + params.search + "%")
                }
            }
            def c2 = Bodega.createCriteria()
            def l2 = c2.list(params) {
                proyecto {
                    ilike("nombre", "%" + params.search + "%")
                }
            }
            def c3 = Bodega.createCriteria()
            def l3 = c3.list(params) {
                responsable {
                    or {
                        ilike("nombre", "%" + params.search + "%")
                        ilike("apellido", "%" + params.search + "%")
                    }
                }
            }
            def c4 = Bodega.createCriteria()
            def l4 = c4.list(params) {
                suplente {
                    or {
                        ilike("nombre", "%" + params.search + "%")
                        ilike("apellido", "%" + params.search + "%")
                    }
                }
            }
            list = (l1 + l2 + l3 + l4).unique()
            if (params.max) {
                if (list.size() > params.max) {
                    list = list[0..params.max - 1]
                }
            }
        } else {
            list = Bodega.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList_funcion(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     */
    def list() {
        def bodegaInstanceList = getList_funcion(params, false)
        def bodegaInstanceCount = getList_funcion(params, true).size()
        return [bodegaInstanceList: bodegaInstanceList, bodegaInstanceCount: bodegaInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     */
    def show_ajax() {
        if (params.id) {
            def bodegaInstance = Bodega.get(params.id)
            if (!bodegaInstance) {
                render "ERROR*No se encontró Bodega."
                return
            }
            return [bodegaInstance: bodegaInstance]
        } else {
            render "ERROR*No se encontró Bodega."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formaulario para crear o modificar un elemento
     */
    def form_ajax() {
        def bodegaInstance = new Bodega()
        if (params.id) {
            bodegaInstance = Bodega.get(params.id)
            if (!bodegaInstance) {
                render "ERROR*No se encontró Bodega."
                return
            }
        }
        bodegaInstance.properties = params
        return [bodegaInstance: bodegaInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     */
    def save_ajax() {
        def bodegaInstance = new Bodega()
        if (params.id) {
            bodegaInstance = Bodega.get(params.id)
            if (!bodegaInstance) {
                render "ERROR*No se encontró Bodega."
                return
            }
        }
        def obs = params.remove("observaciones").toString().trim()
        bodegaInstance.properties = params
        bodegaInstance.actualizaObservaciones(session.usuario, obs)
        if (!bodegaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Bodega: " + renderErrors(bean: bodegaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Bodega exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     */
    def delete_ajax() {
        if (params.id) {
            def bodegaInstance = Bodega.get(params.id)
            if (!bodegaInstance) {
                render "ERROR*No se encontró Bodega."
                return
            }
            try {
                bodegaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Bodega exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Bodega"
                return
            }
        } else {
            render "ERROR*No se encontró Bodega."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción llamada con ajax que muestra los detalles de ingreso de un item a una bodega
     */
    def verDetalles_ajax() {
        def bodega = Bodega.get(params.bodega.toLong())
        def item = Item.get(params.item.toLong())
        def unidad = Unidad.get(params.unidad.toLong())
        def ingresos = Ingreso.withCriteria {
            eq("bodega", bodega)
            eq("item", item)
            eq("unidad", unidad)
            gt("saldo", 0.toDouble())
            eq("desecho", params.desecho.toInteger())
        }
        return [ingresos: ingresos, bodega: bodega, item: item, unidad: unidad, desecho: params.desecho]
    }

    /**
     * Acción llamada con ajax que permite agregar observaciones a una bodega
     */
    def agregarObservaciones_ajax() {
        def bodega = Bodega.get(params.id)
        return [bodega: bodega]
    }

    /**
     * Acción llamada con ajax que gaurda observaciones adicionales a una bodega
     */
    def guardarObservaciones_ajax() {
        def bodega = Bodega.get(params.id)
        bodega.actualizaObservaciones(session.usuario, params.obs)
        if (!bodega.save(flush: true)) {
            println bodega.errors
            render "ERROR*" + renderErrors(bean: bodega)
        } else {
            render "SUCCESS*Observaciones agregadas exitosamente"
        }
    }

    /**
     * Acción llamada con ajax que permite desactivar la bodega de un proyecto y redireccionar su inventario a otra bodega
     */
    def desactivarUI_ajax() {
        def proyecto = Proyecto.get(params.id)
        def bodegas = Bodega.findAllByProyecto(proyecto)
        return [proyecto: proyecto, bodegas: bodegas]
    }

    /**
     * Acción llamada con ajax que ejecuta la desactivación de la bodega con la reubicación de su inventario
     */
    def desactivar_ajax() {
        def errores = ""
        params.each { k, v ->
            //bodegaNew_3:2
            if (k.toString().startsWith("bodega")) {
                def parts = k.split("_")
                def bodegaAntigua = Bodega.get(parts[1].toLong())
                def bodegaNueva = Bodega.get(v.toLong())
                errores += desactivarBodega(bodegaAntigua, bodegaNueva)
            }
        }
        if (errores == "") {
            render "SUCCESS*Inventario reubicado exitosamente"
        } else {
            render "ERROR*" + errores
        }
    }

    def desactivarBodega(Bodega bodegaAntigua, Bodega bodegaNueva) {
//        def ingresos = Ingreso.findAllByBodegaAndSaldoGreaterThan(bodegaAntigua, 0)
        def ingresos = Ingreso.withCriteria {
            eq("bodega", bodegaAntigua)
            gt("saldo", 0.toDouble())
            eq("desecho", 0)
        }
        def errores = ""

        bodegaAntigua.activo = 0
        if (!bodegaAntigua.save(flush: true)) {
            errores += renderErrors(bean: bodegaAntigua)
        }

        def transfer = new Transferencia()
        transfer.origen = bodegaAntigua
        transfer.destino = bodegaNueva
        transfer.observaciones = "<strong>${session.usuario} <em>${new Date().format('dd-MM-yyyy HH:mm')}</em></strong> " +
                "Desactivación de la bodega ${bodegaAntigua}"
        transfer.usuario = session.usuario
        if (!transfer.save(flush: true)) {
            errores += renderErrors(bean: transfer)
        }
        def alerta = new Alerta()
        def usu = Persona.get(session.usuario.id)
        alerta.envia = usu
        alerta.recibe = bodegaNueva.persona
        alerta.fechaEnvio = new Date()
        alerta.mensaje = usu.nombre + " " + usu.apellido + " ha desactivado la bodega " + bodegaAntigua.descripcion +
                " haciendo transferencia del inventario a la bodega " + bodegaNueva.descripcion +
                ". Por favor realice el ingreso a bodega cuando reciba físicamente los items."
        alerta.controlador = "inventario"
        alerta.accion = "transferencia"
        alerta.id_remoto = transfer.id
        if (!alerta.save(flush: true)) {
            println "Error al generar la alerta: " + alerta.errors
        }

        if (errores == "") {
            ingresos.each { ingresoAntiguo ->
                def ok = true
                ingresoAntiguo.calcularSaldo()
                def egreso = new Egreso()
                egreso.ingreso = ingresoAntiguo
                egreso.cantidad = ingresoAntiguo.saldo
                egreso.transferencia = transfer
                if (!egreso.save(flush: true)) {
                    errores += renderErrors(bean: egreso)
                    ok = false
                }
                if (ok) {
                    ingresoAntiguo.saldo = 0
                    if (!ingresoAntiguo.save(flush: true)) {
                        errores += renderErrors(bean: ingresoAntiguo)
                        ok = false
                    }
//                if (ok) {
//                    def ingresoNuevo = new Ingreso()
//                    ingresoNuevo.unidad = ingresoAntiguo.unidad
//                    ingresoNuevo.item = ingresoAntiguo.item
//                    ingresoNuevo.bodega = bodegaNueva
//                    ingresoNuevo.cantidad = egreso.cantidad
//                    ingresoNuevo.valor = ingresoAntiguo.valor
//                    ingresoNuevo.saldo = egreso.cantidad
//                    if (!ingresoNuevo.save(flush: true)) {
//                        errores += renderErrors(bean: ingresoNuevo)
//                        ok = false
//                    }
//                }
                }
            }
        }

        return errores
    }

}
