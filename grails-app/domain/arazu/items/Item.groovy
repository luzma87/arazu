package arazu.items

import arazu.inventario.Bodega
import arazu.inventario.Ingreso
import arazu.parametros.TipoItem
import arazu.parametros.Unidad

/**
 *  Clase para conectar con la tabla 'item' de la base de datos
 */
class Item {

    /**
     * Tipo de item
     */
    TipoItem tipo
    /**
     * Descripción del item
     */
    String descripcion
    /**
     * Unidad que se utiliza para el item
     */
    Unidad unidad
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'item'
        cache usage: 'read-write'
        version false
        id generator: 'identity'
        sort descripcion: "asc"
        columns {
            id column: 'item__id'
            descripcion column: 'itemdscr'
            tipo column: 'tpit__id'
            unidad column: 'undd__id'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        descripcion(nullable: true, blank: true, size: 1..500)
        tipo(nullable: false, blank: false)
        unidad(nullable: true, blank: true)
    }
    /**
     * Genera un string para mostrar
     * @return la descripción
     */
    String toString() {
        return "${this.descripcion}"
    }

    def getIngresos() {
        return Ingreso.withCriteria {
            eq("item", this)
            gt("saldo", 0.toDouble())
            eq("desecho", 0)
        }
    }

    def getIngresosByBodega(Bodega bodega) {
        return Ingreso.withCriteria {
            eq("item", this)
            gt("saldo", 0.toDouble())
            eq("desecho", 0)
            eq("bodega", bodega)
        }
    }

    def getIngresosDesecho() {
        return Ingreso.withCriteria {
            eq("item", this)
            gt("saldo", 0.toDouble())
            eq("desecho", 1)
        }
    }

    def getIngresosDesechoByBodega(Bodega bodega) {
        return Ingreso.withCriteria {
            eq("item", this)
            gt("saldo", 0.toDouble())
            eq("desecho", 1)
            eq("bodega", bodega)
        }
    }

}
