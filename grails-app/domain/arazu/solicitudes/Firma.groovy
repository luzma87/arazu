package arazu.solicitudes

import arazu.seguridad.Persona

/**
 * Clase para conectar con la tabla 'frma' de la base de datos
 * Guarda los datos de una firma electrónica
 */
class Firma {
    /**
     * Persona que firma
     */
    Persona persona
    /**
     * Fecha de la firma
     */
    Date fecha
    /**
     * Razón por la cual se hizo la firma
     */
    String concepto
    /**
     * Controlador para mostrar el pdf
     */
    String pdfControlador
    /**
     * Acción para mostrar el pdf
     */
    String pdfAccion
    /**
     * Parámetro id para mostrar el pdf
     */
    Long pdfId
    /**
     * Key de validación de la firma
     */
    String key
    /**
     * Path del archivo de la imagen generada
     */
    String path

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'frma'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        sort fecha: "desc"
        columns {
            id column: 'frma__id'
            persona column: 'prsn__id'
            fecha column: 'frmafcha'
            key column: 'frma_key'
            path column: 'frmapath'
            concepto column: 'frmacncp'
            pdfControlador column: 'frmapdfc'
            pdfAccion column: 'frmapdfa'
            pdfId column: 'frmapdfi'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        key nullable: true
        path nullable: true
    }
}
