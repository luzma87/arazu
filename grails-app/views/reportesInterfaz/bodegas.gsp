<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 3/30/2015
  Time: 8:57 PM
--%>

<%@ page import="arazu.inventario.Bodega" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Reporte de bodegas</title>

        <style type="text/css">
        .clickable {
            cursor : pointer;
        }

        .data {
            font-weight : bold;
        }

        #lista {
            margin-top : 15px;
        }
        </style>
    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Reporte de bodegas">

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

            <div class="alert alert-info" style="margin-top: 10px;" id="divData">
                Seleccione una o más bodegas y uno o más datos para generar el reporte
            </div>

            <h3>
                Bodega
                <a href="#" class="btn btn-xs btn-success selectNone" data-tipo="bodega" data-status="off">Seleccionar todos</a>
            </h3>

            <g:each in="${Bodega.list([sort: 'descripcion'])}" var="bd" status="i">
                <g:if test="${i % 4 == 0}">
                    <g:if test="${i > 0}">
                        </div>
                    </g:if>
                    <div class="row">
                </g:if>
                <div class="col-md-3 clickable bodega" data-id="${bd.id}" data-status="off">
                    <i class="fa fa-square-o"></i> ${bd}
                </div>
            </g:each>
            </div>

            <h3>
                Datos
                <a href="#" class="btn btn-xs btn-success selectNone" data-tipo="dato" data-status="off">Seleccionar todos</a>
            </h3>

            <div class="row">
                <div class="col-md-3 clickable dato" data-id="in" data-status="off">
                    <i class="fa fa-square-o"></i> Ingresos
                </div>

                <div class="col-md-3 clickable dato" data-id="out" data-status="off">
                    <i class="fa fa-square-o"></i> Egresos
                </div>

                <div class="col-md-3 clickable dato" data-id="ind" data-status="off">
                    <i class="fa fa-square-o"></i> Ingresos de desechos
                </div>

                <div class="col-md-3 clickable dato" data-id="outd" data-status="off">
                    <i class="fa fa-square-o"></i> Egresos de desechos
                </div>
            </div>

            <div id="lista">

            </div>
        </elm:container>

        <script type="text/javascript">
            var bodegasIds = "", datosIds = "";
            function select($elm) {
                $elm.addClass("text-info");
                $elm.data("status", "on");
                $elm.find("i").removeClass("fa-square-o").addClass("fa-check-square-o");
                $elm.css("font-weight", "bold");
            }
            function deselect($elm) {
                $elm.removeClass("text-info");
                $elm.data("status", "off");
                $elm.find("i").removeClass("fa-check-square-o").addClass("fa-square-o");
                $elm.css("font-weight", "normal");
            }

            function revisarDatos() {
                var bodegas = "";
                var datos = "";
                bodegasIds = "";
                datosIds = "";

                var str = "Generar reporte de";
                var cantBodegas = 0;
                var cantDatos = 0;

                $(".bodega").each(function () {
                    var $this = $(this);
                    if ($this.data("status") == "on") {
                        bodegasIds += $this.data("id") + ",";
                        bodegas += "<span class='data'>" + $this.text() + "</span>, ";
                        cantBodegas++;
                    }
                });
                $(".dato").each(function () {
                    var $this = $(this);
                    if ($this.data("status") == "on") {
                        datosIds += $this.data("id") + ",";
                        datos += "<span class='data'>" + $this.text() + "</span>, ";
                        cantDatos++;
                    }
                });

                if (cantDatos > 0) {
                    str += " " + datos;
                }
                if (cantBodegas > 0) {
                    str += " de la" + (cantBodegas.length == 1 ? "" : "s") + " bodega" + (cantBodegas.length == 1 ? "" : "s") + " " + bodegas;
                }
                if (cantBodegas == 0 && cantDatos == 0) {
                    str = "Seleccione una o más bodegas y uno o más datos para generar el reporte";
                }
                $("#divData").html(str);
            }

            $(function () {

                $("#buscar").click(function () {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'reportesInventario', action:'bodegas_ajax')}",
                        data    : {
                            bodegas : bodegasIds,
                            datos   : datosIds
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
                    return false;
                });

                $("#imprimir").click(function () {
                    //openLoader()
                    var url = "${g.createLink(controller: 'pdf',action: 'pdfLink')}?url=";
                    var reporte = "${g.createLink(controller: 'reportesInventario',action: 'bodegasPdf')}?";
                    reporte += "bodegas=" + bodegasIds +
                               "Wdatos=" + datosIds;
                    window.open(url + reporte);
                    //console.log(url+reporte)
                });

                $(".clickable").click(function () {
                    var state = $(this).data("status");
                    if (state == "off") {
                        select($(this));
                    } else {
                        deselect($(this));
                    }
                    revisarDatos();
                });

                $(".selectNone").click(function () {
                    var $this = $(this);
                    var tipo = $this.data("tipo");
                    var state = $this.data("status");
                    if (state == "off") {
                        $this.data("status", "on");
                        $this.removeClass("btn-success").addClass("btn-danger").text("Quitar selección");
                        $(".clickable." + tipo).each(function () {
                            select($(this));
                        });
                    } else {
                        $this.data("status", "off");
                        $this.removeClass("btn-danger").addClass("btn-success").text("Seleccionar todos");
                        $(".clickable." + tipo).each(function () {
                            deselect($(this));
                        });
                    }
                    revisarDatos();
                    return false;
                });
            });
        </script>

    </body>
</html>