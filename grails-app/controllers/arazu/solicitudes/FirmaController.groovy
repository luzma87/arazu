package arazu.solicitudes

class FirmaController {

    /**
     * Acción verificar un documento firmado a través de la llave
     * @param ky es la llave de la firma
     */
    def verDocumento() {
        def firma = Firma.findByKey(params.ky)
        return [firma: firma]

//        println "ver doc " + params
//        def firma = Firma.findByKey(params.ky)
//
//        if (firma) {
//            //println "firma "+firma+" "+firma.esPdf+" "+firma.controladorVer+"/"+firma.accionVer+"/"+firma.idAccion
////            if (firma.esPdf == "S") {
//            redirect(controller: "pdf", action: "pdfLink", params: [url: g.createLink(controller: firma.pdfControlador, action: firma.pdfAccion, id: firma.pdfId)])
////            } else {
////                redirect(controller: firma.controladorVer, action: firma.accionVer, id: firma.idAccionVer)
////            }
//        } else {
//            render "No se encontro ninguna firma"
//        }
    }
}
