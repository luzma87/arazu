package arazu.nomina

import arazu.parametros.TipoAsistencia
import arazu.proyectos.Proyecto;
import arazu.seguridad.Persona

/**
 *  Clase para conectar con la tabla 'asst' de la base de datos
 *  La tabla asistencia permite registrar las ausencias, las horas extras y las vacaciones de los empleados
 */
class Asistencia {
    /**
     * Fecha del dato
     */
    Date fecha
    /**
     * Fecha de registro
     */
    Date fechaRegistro = new Date()
    /**
     * Tipo de asistencia (por ejemplo, asiste, no asiste, vacación de jornada, vacación anual)
     */
    TipoAsistencia tipo
    /**
     * Fecha y hora de entrada
     */
    Date entrada
    /**
     * Fecha y hora de salida
     */
    Date salida
    /**
     * Cantidad de horas extra de 50%
     */
    Integer horas50 = 0
    /**
     * Cantidad de horas extra de 100%
     */
    Integer horas100 = 0
    /**
     * Empleado para el cual se registran los datos
     */
    Persona empleado
    /**
     * Persona que realiza el registro
     */
    Persona registra
    /**
     * Observaciones
     */
    String observaciones
    /**
     * Marca con una S si el empleado comió el desayuno
     */
    String desayuno
    /**
     * Marca con una S si el empleado comió el almuerzo
     */
    String almuerzo
    /**
     * Marca con una S si el empleado comió el merienda
     */
    String merienda
    /**
     * Proyecto (para las comidas de invitados)
     */
    Proyecto proyecto
    /**
     * Cantidad de desayunos de invitado
     */
    Integer desayunosInvitado = 0
    /**
     * Cantidad de almuerzos de invitado
     */
    Integer almuerzosInvitado = 0
    /**
     * Cantidad de meriendas de invitado
     */
    Integer meriendasInvitado = 0

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'asst'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort fecha: "asc"
        columns {
            id column: 'asst__id'
            fecha column: 'asstfcha'
            fechaRegistro column: 'asstfcrg'
            tipo column: 'tpas__id'
            entrada column: 'asstentr'
            salida column: 'asstslda'
            horas50 column: 'assth_50'
            horas100 column: 'assth100'
            empleado column: 'prsn__id'
            registra column: 'prsnrgst'
            observaciones column: 'asstobrs'
            observaciones type: "text"
            desayuno column: 'asstdsyn'
            almuerzo column: 'asstalmr'
            merienda column: 'asstmrnd'
            proyecto column: 'proy__id'
            desayunosInvitado column: 'asstdsin'
            almuerzosInvitado column: 'asstalin'
            meriendasInvitado column: 'asstmrin'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        entrada nullable: true
        salida nullable: true
        empleado nullable: true
        observaciones blank: true, nullable: true
        desayuno nullable: true
        almuerzo nullable: true
        merienda nullable: true
        proyecto nullable: true
    }
}
