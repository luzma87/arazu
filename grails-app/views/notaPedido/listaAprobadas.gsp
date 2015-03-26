<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 26/02/2015
  Time: 23:37
--%>

<%@ page import="arazu.solicitudes.BodegaPedido; arazu.solicitudes.Cotizacion" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Notas de pedido aprobadas</title>
        <style type="text/css">
        table {
            margin-top : 10px;
            font-size  : 12px;
        }
        </style>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Notas de pedido aprobadas">
            <g:render template="/templates/tablaNotaPedido"
                      model="[params      : params, strSearch: strSearch, notas: notas, notasCount: notasCount,
                              ingreso     : ingreso, banderas: true,
                              linkBusqueda: 'listaAprobadas']"/>
        </elm:container>

        <script type="text/javascript">
            $(function () {
                $(".btnIng").click(function () {
                    var id = $(this).data("id");
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'notaPedido', action:'dlgIngresoBodega_ajax')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            var b = bootbox.dialog({
                                id      : "dlgIngreso",
                                title   : "Ingreso a bodega",
                                class   : "modal-sm",
                                message : msg,
                                buttons : {
                                    cancelar : {
                                        label     : "Cancelar",
                                        className : "btn-primary",
                                        callback  : function () {
                                        }
                                    },
                                    guardar  : {
                                        id        : "btnSave",
                                        label     : "<i class='fa fa-save'></i> Guardar",
                                        className : "btn-success",
                                        callback  : function () {
                                            openLoader();
                                            var bd = $("#bodega").val();
                                            $.ajax({
                                                type    : "POST",
                                                url     : "${createLink(controller:'inventario', action:'ingresoNotaPedido_ajax')}",
                                                data    : {
                                                    id     : id,
                                                    bodega : bd
                                                },
                                                success : function (msg) {
                                                    var parts = msg.split("*");
                                                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                                    setTimeout(function () {
                                                        if (parts[0] == "SUCCESS") {
                                                            location.reload(true);
                                                        } else {
                                                            closeLoader();
                                                            return false;
                                                        }
                                                    }, 1000);
                                                },
                                                error   : function () {
                                                    log("Ha ocurrido un error interno", "Error");
                                                    closeLoader();
                                                }
                                            });
                                        } //callback
                                    } //guardar
                                } //buttons
                            }); //dialog
                            setTimeout(function () {
                                b.find(".form-control").first().focus()
                            }, 500);
                        } //success
                    }); //ajax
                    return false;
                });
            });
        </script>

    </body>
</html>