<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 01/03/2015
  Time: 15:33
--%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Verificación de firma</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <imp:favicon/>
        <imp:importCss/>
        <imp:importJs/>
        <imp:customJs/>

        <style type="text/css">
        body {
            padding : 15px;
        }
        </style>
    </head>

    <body>
        <div class="row">
            <div class="col-xs-12 text-center">
                <img src="${resource(dir: 'images', file: fileName)}" alt="HINSA">
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                    <g:if test="${firma}">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">Datos de la firma</h3>
                            </div>

                            <div class="panel-body">
                                <form class="form-horizontal">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Persona</label>

                                        <div class="col-sm-10">
                                            <p class="form-control-static">${firma.persona}</p>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Concepto</label>

                                        <div class="col-sm-10">
                                            <p class="form-control-static">${firma.concepto}</p>
                                        </div>
                                    </div>

                                </form>
                            </div>

                            <div class="panel-footer">
                                <g:link controller="pdf" action="pdfLink" class="btn btn-info"
                                        params="[filename: 'documento.pdf', url: g.createLink(controller: firma.pdfControlador, action: firma.pdfAccion, id: firma.pdfId)]">
                                    <i class="fa fa-download"></i> Descargar pdf
                                </g:link>
                            </div>
                        </div>
                    </g:if>
                    <g:else>
                        <div class="alert alert-danger text-shadow" style="font-size: large;">
                            <h3><i class="icon-splatter fa-2x"></i> Error</h3>

                            <p class="lead">La firma escaneada no es válida</p>
                        </div>
                    </g:else>
                </div>
            </div>
        </div>
    </body>
</html>
