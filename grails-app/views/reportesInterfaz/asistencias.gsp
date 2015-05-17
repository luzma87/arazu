<%@ page import="arazu.parametros.TipoAsistencia; arazu.items.Item; arazu.parametros.EstadoSolicitud; arazu.items.Maquinaria; arazu.proyectos.Proyecto; arazu.seguridad.Persona" %>
<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 13-May-15
  Time: 22:32
--%>

<html>
    <head>
        <meta name="layout" content="main">
        <title>Reporte de asistencias</title>
    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Reporte de asistencias">

            <div class="btn-toolbar" role="toolbar" style="margin-top: 10px;">
                <div class="btn-group">
                    <a href="#" class="btn btn-info" id="buscar">
                        <i class="fa fa-search"></i> Mostrar en pantalla
                    </a>
                </div>

                <div class="btn-group">
                    <a href="#" class="btn btn-info" id="imprimir">
                        <i class="fa fa-file-pdf-o"></i> Mostrar PDF
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-md-1">
                    <label>Proyecto</label>
                </div>

                <div class="col-md-2">
                    <g:select name="proyecto" from="${Proyecto.list([sort: 'nombre'])}" noSelection="['-1': 'Cualquiera...']"
                              class="form-control input-sm" optionKey="id" data-live-search="true"/>
                </div>

                <div class="col-md-1">
                    <label>Desde</label>
                </div>

                <div class="col-md-2">
                    <elm:datepicker class="form-control input-sm desde" name="desde" clear="true"/>
                </div>

                <div class="col-md-1">
                    <label>Hasta</label>
                </div>

                <div class="col-md-2">
                    <elm:datepicker class="form-control input-sm hasta" name="hasta" clear="true"/>
                </div>

                <div class="col-md-1">
                    <label>Tipo</label>
                </div>

                <div class="col-md-2">
                    <g:select name="tipo" from="${TipoAsistencia.list([sort: 'nombre'])}"
                              optionKey="id" class="form-control" noSelection="['': 'Cualquiera...']"/>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12" id="lista">

                </div>
            </div>
        </elm:container>
        <script type="text/javascript">
            $("#buscar").click(function () {
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'reportesPersonal', action:'reporteAsistencias_ajax')}",
                    data    : {
                        proyecto : $("#proyecto").val(),
                        desde    : $(".desde").val(),
                        hasta    : $(".hasta").val(),
                        tipo     : $("#tipo").val()
                    },
                    success : function (msg) {
                        $("#lista").html(msg);
                        closeLoader()
                    },
                    error   : function () {
                        log("Ha ocurrido un error interno", "error");
                        closeLoader();
                    }
                });
            });
            $("#imprimir").click(function () {
                //openLoader()
                var url = "${g.createLink(controller: 'pdf',action: 'pdfLink')}?url=";
                var reporte = "${g.createLink(controller: 'reportesPersonal',action: 'reporteAsistenciasPdf')}?";
                reporte += "proyecto=" + $("#proyecto").val();
                reporte += "Wtipo=" + $("#tipo").val();
                reporte += "Wdesde=" + $(".desde").val() + "Whasta=" + $(".hasta").val();
                window.open(url + reporte);
                //console.log(url+reporte)
            });
        </script>
    </body>
</html>