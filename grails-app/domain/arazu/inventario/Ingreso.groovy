package arazu.inventario

import arazu.items.Item
import arazu.parametros.Unidad
import arazu.solicitudes.Pedido

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
     * Pedido que origina el ingreso
     */
    Pedido pedido
    /**
     * Saldo del ingreso por cantidad
     */
    double saldo = 0
    /**
     * Número de factura
     */
    String factura

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
            pedido column: 'pddo__id'
            saldo column: 'ingrsldo'
            factura column: 'ingrfact'
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
        factura(nullable: true, blank: true,size: 1..50)
    }

    def getEgresos(){
        def egresos = Egreso.findAllByIngreso(this)
        return egresos
    }
    def getCantidadEgresos(){
        def egresos = Egreso.findAllByIngreso(this)
        def total = 0
        egresos.each {
            total+=it.cantidad
        }
        return total
    }

    def calcularSaldo(){
        this.saldo = this.cantidad-getCantidadEgresos()
        this.save(flush: true)
        return this.saldo
    }

}
