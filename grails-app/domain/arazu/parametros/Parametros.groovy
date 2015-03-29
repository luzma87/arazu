package arazu.parametros

/**
 * Clase para conectar con la tabla 'prmt' de la base de datos
 */
class Parametros {
    /**
     * Valor máximo que un jefe puede aprobar (nota de pedido)
     */
    Double maxNP
    /**
     * Valor máximo que un jefe puede aprobar (mantenimiento externo)
     */
    Double maxMX
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'prmt'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false
        columns {
            id column: 'prmt__id'
            maxNP column: 'prmtmxnp'
            maxMX column: 'prmtmxmx'
        }
    }

    static getMaxNotaPedido() {
        def p = list()
        if (p.size() == 0) {
            return 100
        } else {
            return p.first().maxNP
        }
    }

    static getMaxSolicitudMantExt() {
        def p = list()
        if (p.size() == 0) {
            return 200
        } else {
            return p.first().maxMX
        }
    }
}
