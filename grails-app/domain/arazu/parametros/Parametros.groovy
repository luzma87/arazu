package arazu.parametros

/**
 * Clase para conectar con la tabla 'prmt' de la base de datos
 * Guarda los parámetros del sistema, como máximos para solicitar a jefe o gerente
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
     * Hora de inicio de registro permitido para el desayuno
     */
    String horaInicioDesayuno
    /**
     * Hora de fin de registro permitido para el desayuno
     */
    String horaFinDesayuno
    /**
     * Hora de inicio de registro permitido para el almuerzo
     */
    String horaInicioAlmuerzo
    /**
     * Hora de fin de registro permitido para el almuerzo
     */
    String horaFinAlmuerzo
    /**
     * Hora de inicio de registro permitido para el merienda
     */
    String horaInicioMerienda
    /**
     * Hora de fin de registro permitido para el merienda
     */
    String horaFinMerienda

    /**
     * Define si es el sistema HINSA (string vacio) o TAHINSA ('2', que va a hcer append a las imagenes para mostrar el logo correspondiente)
     */
    String hinsa = ''

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
            horaInicioDesayuno column: 'prmthids'
            horaFinDesayuno column: 'prmthfds'
            horaInicioAlmuerzo column: 'prmthial'
            horaFinAlmuerzo column: 'prmthfal'
            horaInicioMerienda column: 'prmthimr'
            horaFinMerienda column: 'prmthfmr'

            hinsa column: 'prmthnsa'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        horaInicioDesayuno maxSize: 5
        horaFinDesayuno maxSize: 5
        horaInicioAlmuerzo maxSize: 5
        horaFinAlmuerzo maxSize: 5
        horaInicioMerienda maxSize: 5
        horaFinMerienda maxSize: 5
    }

    public static getMaxNotaPedido() {
        def p = list()
        if (p.size() == 0) {
            return 100
        } else {
            return p.first().maxNP
        }
    }

    public static getMaxSolicitudMantExt() {
        def p = list()
        if (p.size() == 0) {
            return 200
        } else {
            return p.first().maxMX
        }
    }

    public static getInicioDesayuno() {
        def p = list()
        if (p.size() == 0) {
            return "06:00"
        } else {
            return p.first().horaInicioDesayuno
        }
    }

    public static getFinDesayuno() {
        def p = list()
        if (p.size() == 0) {
            return "10:59"
        } else {
            return p.first().horaFinDesayuno
        }
    }

    public static getInicioAlmuerzo() {
        def p = list()
        if (p.size() == 0) {
            return "11:00"
        } else {
            return p.first().horaInicioAlmuerzo
        }
    }

    public static getFinAlmuerzo() {
        def p = list()
        if (p.size() == 0) {
            return "15:59"
        } else {
            return p.first().horaFinAlmuerzo
        }
    }

    public static getInicioMerienda() {
        def p = list()
        if (p.size() == 0) {
            return "16:00"
        } else {
            return p.first().horaInicioMerienda
        }
    }

    public static getFinMerienda() {
        def p = list()
        if (p.size() == 0) {
            return "21:59"
        } else {
            return p.first().horaFinMerienda
        }
    }

    public static getHinsaCod() {
        def p = list()
        if (p.size() == 0) {
            return ''
        } else {
            return p.first().hinsa
        }
    }

    public static getLogoLogin() {
        def p = list()
        if (p.size() == 0) {
            return 'logo-login.png'
        } else {
            return 'logo-login' + p.first().hinsa + '.png'
        }
    }

    public static getLogoPdf() {
        def p = list()
        if (p.size() == 0) {
            return 'logo-pdf-header.png'
        } else {
            return 'logo-pdf-header' + p.first().hinsa + '.png'
        }
    }

    public static getLogoSquare() {
        def p = list()
        if (p.size() == 0) {
            return 'logo-square.png'
        } else {
            return 'logo-square' + p.first().hinsa + '.png'
        }
    }

    public static getLogoQr() {
        def p = list()
        if (p.size() == 0) {
            return 'logoQr.png'
        } else {
            return 'logoQr' + p.first().hinsa + '.png'
        }
    }
}
