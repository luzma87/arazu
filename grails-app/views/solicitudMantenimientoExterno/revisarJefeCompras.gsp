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
        <title>Solicitud de mantenimiento externo ${solicitud.codigo}</title>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <elm:container tipo="horizontal" titulo="Revisión de solicitud de mantenimiento externo">

            <div class="btn-toolbar toolbar" style="margin-top: 10px">
                <div class="btn-group">
                    <g:link controller="solicitudMantenimientoExterno" action="listaJefeCompras" class="btn btn-default">
                        <i class="fa fa-list"></i> Solicitudes de mantenimiento externo
                    </g:link>
                    <a href="#" class="btn btn-info" id="btnAprobar">
                        <i class="fa fa-check"></i> Aprobar y asignar asistente de compras
                    </a>
                    <a href="#" class="btn btn-danger" id="btnNegar">
                        <i class="fa fa-times"></i> Negar
                    </a>
                </div>
            </div>
            <g:render template="/templates/revisarSolicitudMantExt"
                      model="[solicitud: solicitud]"/>
        </elm:container>

        <script type="text/javascript">

            function submitAprobar() {
                if ($("#frmAprobar").valid()) {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'solicitudMantenimientoExterno', action:'aprobarJefeCompras_ajax')}",
                        data    : {
                            id   : "${solicitud.id}",
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
                                    location.href = "${createLink(conroller:'solicitudMantenimientoExterno', action:'listaJefeCompras')}";
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
                        url     : "${createLink(controller:'solicitudMantenimientoExterno', action:'negarJefeCompras_ajax')}",
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
                                    location.href = "${createLink(conroller:'solicitudMantenimientoExterno', action:'listaJefeCompras')}";
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
                        url     : "${createLink(controller:'solicitudMantenimientoExterno', action:'dlgAprobarJefeCompras_ajax')}",
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
                $("#btnNegar").click(function () {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'solicitudMantenimientoExterno', action:'dlgNegar_ajax')}",
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

    </body>
</html>