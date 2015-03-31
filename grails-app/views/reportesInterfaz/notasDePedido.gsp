<%@ page import="arazu.parametros.EstadoSolicitud; arazu.seguridad.Persona; arazu.items.Item; arazu.items.Maquinaria; arazu.proyectos.Proyecto" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Reporte de notas de pedido</title>
    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Reporte de notas de pedido">
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
                    <g:select name="estado" from="${EstadoSolicitud.findAllByTipo('NP', [sort: 'codigo'])}"
                              noSelection="['-1': 'Seleccione...']" class="form-control input-sm" optionKey="id"/>
                </div>

            </div>

            <div class="row">
                <div class="col-md-1">
                    <label>Item</label>
                </div>

                <div class="col-md-3">
                    <g:select name="item" from="${Item.list([sort: 'descripcion'])}" noSelection="['-1': 'Seleccione...']" id="item" class="form-control input-sm" optionKey="id" data-live-search="true"/>
                </div>

                <div class="col-md-1">
                    <label>Desde</label>
                </div>

                <div class="col-md-2">
                    <elm:datepicker class="form-control input-sm desde" name="desde"/>
                </div>

                <div class="col-md-1">
                    <label>Hasta</label>
                </div>

                <div class="col-md-2">
                    <elm:datepicker class="form-control input-sm hasta" name="hasta"/>
                </div>

                <div class="col-md-1">
                    <a href="#" class="btn btn-info btn-sm" id="buscar">
                        <i class="fa fa-search"></i> Buscar
                    </a>
                </div>

                <div class="col-md-1">
                    <a href="#" class="btn btn-info btn-sm" id="imprimir">
                        <i class="fa fa-print"></i> Imprimir
                    </a>
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
                    url     : "${createLink(controller:'reportesPedidos', action:'reporteNotasDePedido_ajax')}",
                    data    : {
                        persona    : $("#persona").val(),
                        proyecto   : $("#proyecto").val(),
                        maquinaria : $("#maquinaria").val(),
                        desde      : $(".desde").val(),
                        hasta      : $(".hasta").val(),
                        item       : $("#item").val(),
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
                var reporte = "${g.createLink(controller: 'reportesPedidos',action: 'reporteNotasDePedidoPdf')}?";
                reporte += "persona=" + $("#persona").val() +
                           "Wproyecto=" + $("#proyecto").val() +
                           "Wmaquinaria=" + $("#maquinaria").val() +
                           "Witem=" + $("#item").val() +
                           "Westado=" + $("#estado").val();
                reporte += "Wdesde=" + $(".desde").val() + "Whasta=" + $(".hasta").val();
                window.open(url + reporte);
                //console.log(url+reporte)
            });
        </script>
    </body>
</html>