<%@ page import="arazu.solicitudes.DetalleRepuestos; arazu.solicitudes.DetalleManoObra" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 12/03/2015
  Time: 22:47
--%>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

<elm:container tipo="horizontal" titulo="Revisión de Solicitud de Mantenimiento Interno">

    <div class="btn-toolbar toolbar" style="margin-top: 10px">
        <div class="btn-group">
            <g:link controller="solicitudMantenimientoInterno" action="lista${tipo}" class="btn btn-default">
                <i class="fa fa-list"></i> Solicitudes de mantenimiento interno
            </g:link>
            <a href="#" class="btn btn-info" id="btnAprobar">
                <i class="fa fa-check"></i> Aprobar
            </a>
            <a href="#" class="btn btn-danger" id="btnNegar">
                <i class="fa fa-times"></i> Negar
            </a>
        </div>
    </div>

    <g:render template="/templates/revisarSolicitudMantInt"
              model="[solicitud: solicitud]"/>

    <h3 class="text-info">Mano de obra planificada</h3>
    <table class="table table-condensed table-striped table-bordered table-hover">
        <thead>
            <tr>
                <th>Persona</th>
                <th>Horas de trabajo</th>
                <th>Fecha</th>
                <th>Observaciones</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${DetalleManoObra.findAllBySolicitudAndTipo(solicitud, 'P')}" var="mo" status="i">
                <tr>
                    <td>${mo.persona}</td>
                    <td>${mo.horasTrabajo}</td>
                    <td>${mo.fecha.format("dd-MM-yyyy")}</td>
                    <td>${mo.observaciones}</td>
                </tr>
            </g:each>
        </tbody>
    </table>

    <h3 class="text-info">Repuestos planificados</h3>
    <table class="table table-condensed table-striped table-bordered table-hover">
        <thead>
            <tr>
                <th>Cantidad</th>
                <th>Unidad</th>
                <th>Item</th>
                <th>Código o N. parte</th>
                <th>Marca</th>
                <th>Observaciones</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${DetalleRepuestos.findAllBySolicitudAndTipo(solicitud, 'P')}" var="rs" status="i">
                <tr>
                    <td>${rs.cantidad}</td>
                    <td>${rs.unidad}</td>
                    <td>${rs.item}</td>
                    <td>${rs.codigo}</td>
                    <td>${rs.marca}</td>
                    <td>${rs.observaciones}</td>
                </tr>
            </g:each>
        </tbody>
    </table>
</elm:container>

<script type="text/javascript">

    function submitAprobar() {
        if ($("#frmAprobar").valid()) {
            openLoader();
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:'solicitudMantenimientoInterno', action:'aprobarFinal_ajax')}",
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
                            location.href = "${createLink(conroller:'solicitudMantenimientoInterno', action:'lista'+tipo)}";
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
                url     : "${createLink(controller:'solicitudMantenimientoInterno', action:'negarFinal_ajax')}",
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
                            location.href = "${createLink(conroller:'solicitudMantenimientoInterno', action:'lista'+tipo)}";
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
                url     : "${createLink(controller:'solicitudMantenimientoInterno', action:'dlgAprobarFinal_ajax')}",
                data    : {
                    id : "${solicitud.id}"
                },
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgAprobarSolicitudMantInt",
                        title   : "Aprobar Solicitud de Mantenimiento Interno",
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
                url     : "${createLink(controller:'solicitudMantenimientoInterno', action:'dlgNegarFinal_ajax')}",
                data    : {
                    id : "${solicitud.id}"
                },
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgNegarSolicitudMantInt",
                        title   : "Negar Solicitud de Mantenimiento Interno",
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