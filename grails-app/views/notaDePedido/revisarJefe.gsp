<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 24/02/2015
  Time: 23:58
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
                    <g:link controller="notaDePedido" action="listaJefatura" class="btn btn-default">
                        <i class="fa fa-list"></i> Notas de pedido
                    </g:link>
                    <a href="#" class="btn btn-info" id="btnAprobar">
                        <i class="fa fa-check"></i> Aprobar
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
        <elm:container tipo="horizontal" titulo="Cotizaciones">
        %{--<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true" style="margin-top: 20px">--}%
            <g:each in="${cots}" var="c" status="i">
                <div class="panel panel-info" ${i == 0 ? 'style="margin-top: 20px"' : ''}>
                    <div class="panel-heading" role="tab" id="heading_${i}">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse_${i}" aria-expanded="false" aria-controls="collapse_${i}">
                                Cotización #${i + 1}
                            </a>
                        </h4>
                    </div>

                    <div id="collapse_${i}" class="panel-collapse collapse ${i == 0 ? 'in' : ''}" role="tabpanel" aria-labelledby="heading_${i}">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-1">
                                    <label>Proveedor</label>
                                </div>

                                <div class="col-md-5">
                                    ${c.proveedor}
                                </div>

                                <div class="col-md-1">
                                    <label>Entrega</label>
                                </div>

                                <div class="col-md-2">
                                    <div class="input-group">
                                        ${c.diasEntrega} Días
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-1">
                                    <label>P. Unitario</label>
                                </div>

                                <div class="col-md-2">
                                    ${g.formatNumber(number: c.valor, type: 'currency')}
                                </div>

                                <div class="col-md-1">
                                    <label>P. Total</label>
                                </div>

                                <div class="col-md-2">
                                    ${g.formatNumber(number: c.valor * (nota.cantidadAprobada > 0 ? nota.cantidadAprobada : nota.cantidad), type: 'currency')}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </g:each>
        %{--</div>--}%
        </elm:container>

        <script type="text/javascript">

            function submitAprobar() {
                if ($("#frmAprobar").valid()) {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'notaDePedido', action:'aprobarFinal_ajax')}",
                        data    : {
                            id   : "${nota.id}",
                            auth : $("#auth").val(),
                            cot  : $("#cot").val(),
                            obs  : $("#obs").val(),
                            cant : $("#cant").val(),
                            prio : $('input[name=prioridad]:checked').val()
                        },
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            if (parts[0] == "SUCCESS") {
                                setTimeout(function () {
                                    location.href = "${createLink(conroller:'notaDePedido', action:'listaJefe')}";
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
                        url     : "${createLink(controller:'notaDePedido', action:'negarFinal_ajax')}",
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
                                    location.href = "${createLink(conroller:'notaDePedido', action:'listaJefe')}";
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
                        url     : "${createLink(controller:'notaDePedido', action:'bodegaFinal_ajax')}",
                        data    : $("#frmBodega").serialize() + "&id=${nota.id}",
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            if (parts[0] == "SUCCESS") {
                                setTimeout(function () {
                                    location.href = "${createLink(conroller:'notaDePedido', action:'listaJefe')}";
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
                        url     : "${createLink(controller:'notaDePedido', action:'dlgAprobarFinal_ajax')}",
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
                        url     : "${createLink(controller:'notaDePedido', action:'dlgNegarFinal_ajax')}",
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
                        url     : "${createLink(controller:'notaDePedido', action:'dlgBodega_ajax')}",
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