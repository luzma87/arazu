<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 12/03/2015
  Time: 22:47
--%>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

<elm:container tipo="horizontal" titulo="Revisión de Solicitud de Mantenimiento Externo">

    <div class="btn-toolbar toolbar" style="margin-top: 10px">
        <div class="btn-group">
            <g:link controller="solicitudMantenimientoExterno" action="lista${tipo}" class="btn btn-default">
                <i class="fa fa-list"></i> Solicitudes de mantenimiento externo
            </g:link>
            <a href="#" class="btn btn-info" id="btnAprobar">
                <i class="fa fa-check"></i> Aprobar
            </a>
            <a href="#" class="btn btn-danger" id="btnNegar">
                <i class="fa fa-times"></i> Negar
            </a>
            <a href="#" class="btn btn-warning" id="btnCots">
                <i class="fa fa-cart-plus"></i> Pedir cotizaciones
            </a>
        </div>
    </div>

    <g:render template="/templates/revisarSolicitudMantExt"
              model="[solicitud: solicitud]"/>

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
                            <label>Taller</label>
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
                            <label>Precio</label>
                        </div>

                        <div class="col-md-2">
                            ${g.formatNumber(number: c.valor, type: 'currency')}
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
                url     : "${createLink(controller:'solicitudMantenimientoExterno', action:'aprobarFinal_ajax')}",
                data    : {
                    id   : "${solicitud.id}",
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
                            location.href = "${createLink(conroller:'solicitudMantenimientoExterno', action:'lista'+tipo)}";
                        }, 1000);
                    } else {
                        closeLoader();
                    }
                }
            });
        }
    }
    function submitCotizaciones() {
        if ($("#frmCotizaciones").valid()) {
            openLoader();
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:'solicitudMantenimientoExterno', action:'solicitarCotizaciones_ajax')}",
                data    : {
                    id   : "${solicitud.id}",
                    auth : $("#auth").val(),
                    obs  : $("#obs").val()
                },
                success : function (msg) {
                    var parts = msg.split("*");
                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "SUCCESS") {
                        setTimeout(function () {
                            location.href = "${createLink(conroller:'solicitudMantenimientoExterno', action:'lista'+tipo)}";
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
                url     : "${createLink(controller:'solicitudMantenimientoExterno', action:'negarFinal_ajax')}",
                data    : {
                    id    : "${solicitud.id}",
                    auth  : $("#auth").val(),
                    razon : $("#razon").val()
                },
                success : function (msg) {
                    var parts = msg.split("*");
                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "SUCCESS") {
                        setTimeout(function () {
                            location.href = "${createLink(conroller:'solicitudMantenimientoExterno', action:'lista'+tipo)}";
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
                url     : "${createLink(controller:'solicitudMantenimientoExterno', action:'dlgAprobarFinal_ajax')}",
                data    : {
                    id : "${solicitud.id}"
                },
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgAprobarSolicitudMantExt",
                        title   : "Aprobar Solicitud de Mantenimiento Externo",
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
        $("#btnCots").click(function () {
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:'solicitudMantenimientoExterno', action:'dlgSolicitarCotizaciones_ajax')}",
                data    : {
                    id : "${solicitud.id}"
                },
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgSolicitarCots",
                        title   : "Solicitar cotizaciones para Solicitud de Mantenimiento Externo",
                        message : msg,
                        buttons : {
                            guardar  : {
                                label     : "<i class='fa fa-cart-plus'></i> Solicitar",
                                className : "btn-warning",
                                callback  : function () {
                                    submitCotizaciones();
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
                url     : "${createLink(controller:'solicitudMantenimientoExterno', action:'dlgNegarFinal_ajax')}",
                data    : {
                    id : "${solicitud.id}"
                },
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgNegarSolicitudMantExt",
                        title   : "Negar Solicitud de Mantenimiento Externo",
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
    });
</script>