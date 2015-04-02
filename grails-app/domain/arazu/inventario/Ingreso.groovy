package arazu.inventario

import arazu.items.Item
import arazu.parametros.Unidad
import arazu.solicitudes.Firma
import arazu.solicitudes.NotaPedido

/**
 *  Clase para conectar con la tabla 'ingr' de la base de datos
 */
class Ingreso {
    /**
     * Unidad de medida
     */
    Unidad unidad
    /**
     * Item que ingresa
     */
    Item item
    /**
     * Bodega a la cual ingresa el item
     */
    Bodega bodega
    /**
     * Fecha de ingreso
     */
    Date fecha = new Date()
    /**
     * Cantidad que ingresa
     */
    Double cantidad = 1
    /**
     * Cantidad que ingresa
     */
    Double valor = 1
    /**
     * NotaPedido que origina el ingreso
     */
    NotaPedido pedido
    /**
     * Saldo del ingreso por cantidad
     */
    double saldo = 0
    /**
     * Número de factura
     */
    String factura
    /**
     * Firma de la persona que hizo el ingreso
     */
    Firma ingresa
    /**
     * Define si el ingreso es desecho o no (1: es desecho, 0: es nuevo)
     */
    Integer desecho = 0
    /**
     * Egreso que generó el ingreso del desecho, si no se hizo un ingreso de desecho este valor es != null pero desecho = 1
     */
    Egreso egreso

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'ingr'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort fecha: "desc"
        columns {
            id column: 'ingr__id'
            unidad column: 'undd__id'
            item column: 'item__id'
            bodega column: 'bdga__id'
            fecha column: 'ingrfcha'
            cantidad column: 'ingrcant'
            valor column: 'ingrvlor'
            pedido column: 'ntpd__id'
            saldo column: 'ingrsldo'
            factura column: 'ingrfact'
            ingresa column: 'frma__id'
            desecho column: 'ingrdsch'
            egreso column: 'egrs__id'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        unidad(nullable: false, blank: false)
        item(nullable: false, blank: false)
        bodega(nullable: false, blank: false)
        fecha(nullable: false, blank: false)
        pedido(nullable: true, blank: true)
        factura(nullable: true, blank: true, size: 1..50)
        ingresa nullable: true
        egreso nullable: true
    }

    def getEgresos() {
        def egresos = Egreso.findAllByIngreso(this)
        return egresos
    }

    def getCantidadEgresos() {
        def egresos = Egreso.findAllByIngreso(this)
        def total = 0
        egresos.each {
            total += it.cantidad
        }
        return total
    }

    def calcularSaldo() {
        this.saldo = this.cantidad - getCantidadEgresos()
        this.save(flush: true)
        return this.saldo
    }

}
