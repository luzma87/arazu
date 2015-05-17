<%@ page import="arazu.parametros.EstadoSolicitud; arazu.seguridad.Persona; arazu.items.Item; arazu.items.Maquinaria; arazu.proyectos.Proyecto" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Reporte de mantenimiento interno</title>
    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Reporte de mantenimiento interno">
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
                    <label>Requirente</label>
                </div>

                <div class="col-md-2">
                    <g:select name="persona" from="${Persona.list([sort: 'nombre'])}" noSelection="['-1': 'Seleccione...']"
                              class="form-control input-sm" optionKey="id" data-live-search="true"/>
                </div>

                <div class="col-md-1">
                    <label>Proyecto</label>
                </div>

                <div class="col-md-2">
                    <g:select name="proyecto" from="${Proyecto.list([sort: 'nombre'])}" noSelection="['-1': 'Seleccione...']"
                              class="form-control input-sm" optionKey="id" data-live-search="true"/>
                </div>

                <div class="col-md-1">
                    <label>Maquinaria</label>
                </div>

                <div class="col-md-2">
                    <g:select name="maquinaria" from="${Maquinaria.list([sort: 'codigo'])}" noSelection="['-1': 'Seleccione...']"
                              class="form-control input-sm" optionKey="id" data-live-search="true"/>
                </div>

                <div class="col-md-1">
                    <label>Estado</label>
                </div>

                <div class="col-md-2">
                    <g:select name="estado" from="${EstadoSolicitud.findAllByTipo('MI', [sort: 'codigo'])}"
                              noSelection="['-1': 'Seleccione...']" class="form-control input-sm" optionKey="id"/>
                </div>
            </div>

            <div class="row">
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
                    url     : "${createLink(controller:'reportesPedidos', action:'reporteMantenimientoInterno_ajax')}",
                    data    : {
                        persona    : $("#persona").val(),
                        proyecto   : $("#proyecto").val(),
                        maquinaria : $("#maquinaria").val(),
                        desde      : $(".desde").val(),
                        hasta      : $(".hasta").val(),
                        estado     : $("#estado").val()
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
                var reporte = "${g.createLink(controller: 'reportesPedidos',action: 'reporteMantenimientoInternoPdf')}?";
                reporte += "persona=" + $("#persona").val() +
                           "Wproyecto=" + $("#proyecto").val() +
                           "Wmaquinaria=" + $("#maquinaria").val() +
                           "Wdesde=" + $(".desde").val() +
                           "Whasta=" + $(".hasta").val() +
                           "Westado=" + $("#estado").val();
                window.open(url + reporte);
                //console.log(url+reporte)
            });
        </script>
    </body>
</html>