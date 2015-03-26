<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 21/02/2015
  Time: 22:38
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Nota de pedido #${nota.numero}</title>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <elm:container tipo="horizontal" titulo="Revisión de nota de pedido">

            <div class="btn-toolbar toolbar" style="margin-top: 10px">
                <div class="btn-group">
                    <g:link controller="notaPedido" action="listaJefeCompras" class="btn btn-default">
                        <i class="fa fa-list"></i> Notas de pedido
                    </g:link>
                    <a href="#" class="btn btn-info" id="btnAprobar">
                        <i class="fa fa-check"></i> Aprobar y asignar asistente de compras
                    </a>
                    <a href="#" class="btn btn-danger" id="btnNegar">
                        <i class="fa fa-times"></i> Negar
                    </a>
                    <g:if test="${existencias.size() > 0}">
                        <a href="#" class="btn btn-default" id="btnBodega">
                            <i class="fa fa-archive"></i> Existente en bodegas
                        </a>
                    </g:if>
                </div>
            </div>
            <g:render template="/templates/revisarNotaPedido"
                      model="[nota: nota, existencias: existencias, locked: locked]"/>
        </elm:container>

        <script type="text/javascript">

            function submitAprobar() {
                if ($("#frmAprobar").valid()) {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'notaPedido', action:'aprobarJefeCompras_ajax')}",
                        data    : {
                            id   : "${nota.id}",
                            auth : $("#auth").val(),
                            para : $("#para").val(),
                            obs  : $("#obs").val(),
                            cant : $("#cant").val()
                        },
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            if (parts[0] == "SUCCESS") {
                                setTimeout(function () {
                                    location.href = "${createLink(conroller:'notaDePedido', action:'listaJefeCompras')}";
                                }, 1000);
                            } else {
                                closeLoader();
                            }
                        }
                    });
                }
            }
            function submitNegar() {
                if ($("#frmNegar").valid()) {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'notaPedido', action:'negarJefeCompras_ajax')}",
                        data    : {
                            id    : "${nota.id}",
                            auth  : $("#auth").val(),
                            razon : $("#razon").val()
                        },
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            if (parts[0] == "SUCCESS") {
                                setTimeout(function () {
                                    location.href = "${createLink(conroller:'notaDePedido', action:'listaJefeCompras')}";
                                }, 1000);
                            } else {
                                closeLoader();
                            }
                        }
                    });
                }
            }
            function submitBodega() {
                if ($("#frmBodega").valid()) {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'notaPedido', action:'bodegaJefeCompras_ajax')}",
                        data    : $("#frmBodega").serialize() + "&id=${nota.id}",
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            if (parts[0] == "SUCCESS") {
                                setTimeout(function () {
                                    location.href = "${createLink(conroller:'notaDePedido', action:'listaJefeCompras')}";
                                }, 1000);
                            } else {
                                closeLoader();
                            }
                        }
                    });
                }
            }

            $(function () {
                $("#btnAprobar").click(function () {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'notaPedido', action:'dlgAprobarJefeCompras_ajax')}",
                        data    : {
                            id : "${nota.id}"
                        },
                        success : function (msg) {
                            var b = bootbox.dialog({
                                id      : "dlgAprobarNotaPedido",
                                title   : "Aprobar Nota de Pedido",
                                message : msg,
                                buttons : {
                                    guardar  : {
                                        label     : "<i class='fa fa-check'></i> Aprobar",
                                        className : "btn-success",
                                        callback  : function () {
                                            submitAprobar();
                                            return false;
                                        } //callback
                                    },
                                    cancelar : {
                                        label     : "Cancelar",
                                        className : "btn-default",
                                        callback  : function () {
                                        }
                                    }
                                } //buttons
                            }); //dialog
                            setTimeout(function () {
                                b.find(".form-control").first().focus()
                            }, 500);
                        } //success
                    }); //ajax
                    return false;
                });
                $("#btnNegar").click(function () {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'notaPedido', action:'dlgNegar_ajax')}",
                        data    : {
                            id : "${nota.id}"
                        },
                        success : function (msg) {
                            var b = bootbox.dialog({
                                id      : "dlgNegarNotaPedido",
                                title   : "Negar Nota de Pedido",
                                message : msg,
                                buttons : {
                                    negar    : {
                                        label     : "<i class='fa fa-times'></i> Negar",
                                        className : "btn-danger",
                                        callback  : function () {
                                            submitNegar();
                                            return false;
                                        } //callback
                                    },
                                    cancelar : {
                                        label     : "Cancelar",
                                        className : "btn-default",
                                        callback  : function () {
                                        }
                                    }
                                } //buttons
                            }); //dialog
                            setTimeout(function () {
                                b.find(".form-control").first().focus()
                            }, 500);
                        } //success
                    }); //ajax
                    return false;
                });

                $("#btnBodega").click(function () {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'notaPedido', action:'dlgBodega_ajax')}",
                        data    : {
                            id : "${nota.id}"
                        },
                        success : function (msg) {
                            var b = bootbox.dialog({
                                id      : "dlgBodegaNotaPedido",
                                title   : "Notificar existencia de items de Nota de Pedido",
                                message : msg,
                                buttons : {
                                    negar    : {
                                        label     : "<i class='fa fa-archive'></i> Notificar",
                                        className : "btn-warning",
                                        callback  : function () {
                                            submitBodega();
                                            return false;
                                        } //callback
                                    },
                                    cancelar : {
                                        label     : "Cancelar",
                                        className : "btn-default",
                                        callback  : function () {
                                        }
                                    }
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