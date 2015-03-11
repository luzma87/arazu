<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 23/02/2015
  Time: 23:56
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
                    <g:link controller="notaDePedido" action="listaAsistenteCompras" class="btn btn-default">
                        <i class="fa fa-list"></i> Notas de pedido
                    </g:link>
                    <g:if test="${cots.size() > 0}">
                        <a href="#" class="btn btn-info" id="btnAprobar">
                            <i class="fa fa-check"></i> Aprobar y enviar ${cots.size()} cotizaci${cots.size() == 1 ? 'ón' : 'ones'}
                        </a>
                    </g:if>
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
                      model="[nota: nota, existencias: existencias]"/>

        </elm:container>

        <elm:container tipo="horizontal" titulo="Cotizaciones">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true" style="margin-top: 20px">
                <g:if test="${cots.size() > 0}">
                    <g:each in="${cots}" var="c" status="i">
                        <g:form class="frmCotizacion" action="saveCotizacion">
                            <input type="hidden" value="${nota.id}" name="pedido.id">
                            <input type="hidden" value="${c.id}" name="id">

                            <div class="panel panel-info">
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
                                                <input type="text" class="form-control input-sm" name="proveedor" value="${c.proveedor}" maxlength="254">
                                            </div>

                                            <div class="col-md-1">
                                                <label>Entrega</label>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="input-group">
                                                    <input type="text" class="form-control input-sm number" name="diasEntrega"
                                                           style="text-align: right" value="${c.diasEntrega}" autocomplete="off">
                                                    <span class="input-group-addon svt-bg-warning">Días</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-1">
                                                <label>P. Unitario</label>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="input-group">
                                                    <input type="text" class="form-control input-sm number money nueva_unitario unitario required"
                                                           total="p_total_${i}" name="valor" autocomplete="off"
                                                           cantidad="${nota.cantidadAprobada > 0 ? nota.cantidadAprobada : nota.cantidad}">

                                                    <span class="input-group-addon svt-bg-warning">$</span>
                                                </div>
                                            </div>

                                            <div class="col-md-1">
                                                <label>P. Total</label>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="input-group">
                                                    <input type="text" class="form-control input-sm number money " disabled
                                                           id="p_total_${i}"
                                                           value="${g.formatNumber(number: c.valor * nota.cantidad, type: 'currency')}">
                                                    <span class="input-group-addon svt-bg-warning">$</span>
                                                </div>
                                            </div>

                                            <div class="col-md-3" style="text-align: right">
                                                <a href="#" class="btn btn-info guardar_nueva" number="${i}" iden="${c.id}">
                                                    <i class="fa fa-save"></i> Guadar
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </g:form>
                    </g:each>
                </g:if>
                <g:if test="${cots.size() < 3}">
                    <g:form class="frmCotizacion" action="saveCotizacion">
                        <input type="hidden" value="${nota.id}" name="pedido.id">

                        <div class="panel panel-success">
                            <div class="panel-heading" role="tab" id="headingOne_n">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne_n" aria-expanded="true" aria-controls="collapseOne_n">
                                        Registrar nueva
                                    </a>
                                </h4>
                            </div>

                            <div id="collapseOne_n" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne_n">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-1">
                                            <label>Proveedor</label>
                                        </div>

                                        <div class="col-md-5">
                                            <input type="text" class="form-control input-sm nueva_proveedor required"
                                                   name="proveedor" maxlength="254">
                                        </div>

                                        <div class="col-md-1">
                                            <label>Entrega</label>
                                        </div>

                                        <div class="col-md-2">
                                            <div class="input-group">
                                                <input type="text" name="diasEntrega" class="form-control input-sm number nueva_dias required"
                                                       style="text-align: right" autocomplete="off">
                                                <span class="input-group-addon svt-bg-warning">Días</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-1">
                                            <label>P. Unitario</label>
                                        </div>

                                        <div class="col-md-2">
                                            <div class="input-group">
                                                <input type="text" class="form-control input-sm number money nueva_unitario unitario required"
                                                       total="total_n" name="valor" autocomplete="off"
                                                       cantidad="${nota.cantidadAprobada > 0 ? nota.cantidadAprobada : nota.cantidad}">
                                                <span class="input-group-addon svt-bg-warning">$</span>
                                            </div>
                                        </div>

                                        <div class="col-md-1">
                                            <label>P. Total</label>
                                        </div>

                                        <div class="col-md-2">
                                            <div class="input-group">
                                                <input type="text" id="total_n" class="form-control input-sm number money nueva_total " disabled>
                                                <span class="input-group-addon svt-bg-warning">$</span>
                                            </div>
                                        </div>

                                        <div class="col-md-3" style="text-align: right">
                                            <a href="#" class="btn btn-info guardar_nueva">
                                                <i class="fa fa-save"></i> Guadar</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </g:form>
                </g:if>
            </div>
        </elm:container>

        <script type="text/javascript">

            function submitAprobar() {
                if ($("#frmAprobar").valid()) {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'notaDePedido', action:'aprobarAsistenteCompras_ajax')}",
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
                                    location.href = "${createLink(conroller:'notaDePedido', action:'listaAsistenteCompras')}";
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
                        url     : "${createLink(controller:'notaDePedido', action:'negarAsistenteCompras_ajax')}",
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
                                    location.href = "${createLink(conroller:'notaDePedido', action:'listaAsistenteCompras')}";
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
                        url     : "${createLink(controller:'notaDePedido', action:'bodegaAsistenteCompras_ajax')}",
                        data    : $("#frmBodega").serialize() + "&id=${nota.id}",
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            if (parts[0] == "SUCCESS") {
                                setTimeout(function () {
                                    location.href = "${createLink(conroller:'notaDePedido', action:'listaAsistenteCompras')}";
                                }, 1000);
                            } else {
                                closeLoader();
                            }
                        }
                    });
                }
            }

            $(function () {
                var validator = $(".frmCotizacion").validate({
                    errorClass     : "help-block",
                    errorPlacement : function (error, element) {
                        if (element.parent().hasClass("input-group")) {
                            error.insertAfter(element.parent());
                        } else {
                            error.insertAfter(element);
                        }
                        element.parents(".grupo").addClass('has-error');
                    },
                    success        : function (label) {
                        label.parents(".grupo").removeClass('has-error');
                        label.remove();
                    }
                });
                $(".unitario").blur(function () {
                    var valor = $(this).val();
                    valor = str_replace(",", "", valor);
                    $("#" + $(this).attr("total")).val(parseFloat(valor) * parseFloat($(this).attr("cantidad")));
                });
                $(".guardar_nueva").click(function () {
                    var form = $(this).parents("form");
                    if (form.valid()) {
                        openLoader();
                        form.submit();
                    }
                });

                $("#btnAprobar").click(function () {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'notaDePedido', action:'dlgAprobarAsistenteCompras_ajax')}",
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
                        url     : "${createLink(controller:'notaDePedido', action:'dlgNegar_ajax')}",
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