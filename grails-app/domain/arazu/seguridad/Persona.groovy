package arazu.seguridad

import arazu.nomina.PersonalProyecto
import arazu.parametros.TipoUsuario
import arazu.proyectos.Proyecto

/**
 * Clase para conectar con la tabla 'prsn' de la base de datos
 * Guarda los datos de los usuarios del sistema
 */
class Persona {
    /**
     * Cédula de la persona
     */
    String cedula
    /**
     * Nombre de la persona
     */
    String nombre
    /**
     * Apellido de la persona
     */
    String apellido
    /**
     * Sexo de la persona
     */
    String sexo
    /**
     * Fecha de nacimiento de la persona
     */
    Date fechaNacimiento
    /**
     * Dirección de la persona
     */
    String direccion
    /**
     * Número de teléfono de la persona
     */
    String telefono
    /**
     * Dirección de e-mail de la persona
     */
    String mail
    /**
     * Observaciones
     */
    String observaciones
    /**
     * Nombre de usuario para el ingreso al sistema
     */
    String login
    /**
     * Contraseña del usuario para el ingreso al sistema
     */
    String password
    /**
     * Código de autorización del usuario
     */
    String autorizacion
    /**
     * Indica si el usuario está o no activo (1->Sí, 0->No)
     */
    int activo
    /**
     * Departamento del usuario
     */
    TipoUsuario tipoUsuario
    /**
     * Path de la foto de la persona
     */
    String foto

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'prsn'
        sort 'apellido'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false
        columns {
            id column: 'prsn__id'
            cedula column: 'prsncdla'
            nombre column: 'prsnnmbr'
            apellido column: 'prsnapll'
            sexo column: 'prsnsexo'
            fechaNacimiento column: 'prsnfcna'
            direccion column: 'prsndire'
            telefono column: 'prsntelf'
            mail column: 'prsnmail'
            observaciones column: 'prsnobsr'
            login column: 'prsnlogn'
            password column: 'prsnpass'
            autorizacion column: 'prsnatrz'
            activo column: 'prsnactv'
            tipoUsuario column: 'tpus__id'
            foto column: 'prsnfoto'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        cedula size: 1..10
        nombre size: 1..40
        apellido size: 1..40
        sexo inList: ["F", "M"]
        fechaNacimiento max: new Date(), nullable: true
        direccion size: 1..127, blank: true, nullable: true
        telefono size: 1..10, blank: true, nullable: true
        mail email: true, size: 1..40, blank: true, nullable: true
        observaciones size: 1..127, blank: true, nullable: true
        login size: 1..15, blank: true, nullable: true, unique: true
        password size: 1..64, blank: true, nullable: true
        autorizacion size: 1..255, blank: true, nullable: true
        activo size: 1..1, blank: true, nullable: true
        tipoUsuario blank: true, nullable: true
        foto blank: true, nullable: true
    }

    /**
     * Genera un string para mostrar
     * @return el nombre y el apellido concatenado
     */
    String toString() {
        return "${this.nombre} ${this.apellido}"
    }

    /**
     * Devuelve el proyecto al que está asignada actualmente la persona
     */
    Proyecto getProyecto() {
        def now = new Date()
        def personal = PersonalProyecto.withCriteria {
            eq("persona", this)
            le("fechaInicio", now)
            or {
                isNull("fechaFin")
                ge("fechaFin", now)
            }
        }
        if (personal.size() == 1) {
            return personal.first().proyecto
        } else {
            println "Hay ${personal.size()} registros de personal proyecto: ${personal}"
            return null
        }
    }

    /**
     * Devuelve el proyecto al que está asignada en una fecha la persona
     */
    Proyecto getProyectoPorFecha(Date fecha) {
        def personal = PersonalProyecto.withCriteria {
            eq("persona", this)
            le("fechaInicio", fecha)
            or {
                isNull("fechaFin")
                ge("fechaFin", fecha)
            }
        }
        if (personal.size() == 1) {
            return personal.first().proyecto
        } else {
           // println "Hay ${personal.size()} registros de personal proyecto: ${personal}"
            return null
        }
    }
}