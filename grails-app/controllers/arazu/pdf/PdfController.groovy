package arazu.pdf

class PdfController {

    PdfService pdfService

    def pdfLink = {
        try {
            byte[] b
            def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort

            params.url = params.url.replaceAll("W", "&")
            println "sin plugin --> params url " + params.url
            def url = baseUri + params.url
            b = pdfService.buildPdf(url, baseUri)
            response.setContentType("application/pdf")
            response.setHeader("Content-disposition", "inline; filename=" + (params.filename ?: "document.pdf"))
            response.setContentLength(b.length)
            response.getOutputStream().write(b)
        }
        catch (Throwable e) {
            println "there was a problem with PDF generation 2 ${e}"
            if (params.pdfController) {
                redirect(controller: params.pdfController, action: params.pdfAction, params: params)
            } else {
                redirect(action: "index", controller: "reportes", params: [msn: "Hubo un error en la genración del reporte. Si este error vuelve a ocurrir comuniquelo al administrador del sistema."])
            }
        }
    }
}

