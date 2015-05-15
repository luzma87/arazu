package arazu.nomina

import arazu.proyectos.Proyecto
import arazu.seguridad.Persona

/**
 *  Clase para conectar con la tabla 'prpr' de la base de datos
 *  La tabla personalProyecto permite registrar los empleados asignados a un proyecto
 */
class PersonalProyecto {
    /**
     * Fecha de inicio
     */
    Date fechaInicio
    /**
     * Fecha de fin
     */
    Date fechaFin
    /**
     * Empleado
     */
    Persona persona
    /**
     * Proyecto
     */
    Proyecto proyecto
    /**
     * Observaciones
     */
    String observaciones

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'prpr'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort fechaInicio: "asc"
        columns {
            id column: 'prpr__id'
            fechaInicio column: 'prprfcin'
            fechaFin column: 'prprfcfn'
            persona column: 'prsn__id'
            proyecto column: 'proy__id'
            observaciones column: 'prprobrs'
            observaciones type: "text"
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        fechaFin nullable: true
        observaciones blank: true, nullable: true
    }
}
