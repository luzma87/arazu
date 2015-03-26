<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 26/03/15
  Time: 10:52 AM
--%>

<%@ page import="arazu.parametros.TipoTrabajo; arazu.proyectos.Proyecto" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Solicitud de mantenimiento externo</title>
        <style type="text/css">
        .clickable {
            cursor : pointer;
        }
        </style>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <g:form class="frmNota" action="saveSolicitud">
            <elm:container tipo="horizontal" titulo="Nueva solicitud de mantenimiento externo">
                <div class="alert alert-info" style="margin-top: 10px;">
                    <strong>Nota:</strong> el número mostrado en esta pantalla es un número tentativo que puede cambiar al momento de guardar.
                Se le informará el número final de su solicitud después de guardar.
                </div>

                <g:hiddenField name="maquinaria.id" id="maquina"/>

                <div class="row">
                    <div class="col-md-1">
                        <label class=" control-label">
                            Equipo
                        </label>
                    </div>

                    <div class="col-md-5">
                        <div class="input-group">
                            <input type="text" class="form-control" id="maquina_input" readonly/>
                            <span class="input-group-addon svt-bg-warning">
                                <i class="fa fa-keyboard-o"></i>
                            </span>
                        </div><!-- /input-group -->
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Número
                        </label>
                    </div>

                    <div class="col-md-2">
                        ${numero}
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Fecha
                        </label>
                    </div>

                    <div class="col-md-2">
                        ${new Date().format("dd-MM-yyyy hh:mm:ss")}
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-1">
                        <label class=" control-label">
                            De
                        </label>
                    </div>

                    <div class="col-md-2">
                        ${session.usuario}
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Para
                        </label>
                    </div>

                    <div class="col-md-2">
                        <g:select name="para.id" from="${jefes}" optionKey="id"
                                  class="form-control input-sm required select" required=""/>
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Proyecto
                        </label>
                    </div>

                    <div class="col-md-2">
                        <g:select name="proyecto.id" from="${Proyecto.findAllByFechaFinIsNullOrFechaFinGreaterThan(new Date())}" optionKey="id" optionValue="nombre"
                                  class="form-control input-sm required select" noSelection="['': '-- Seleccione --']"/>
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Localización
                        </label>
                    </div>

                    <div class="col-md-2">
                        <g:textField name="localizacion" class="form-control input-sm "/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-1">
                        <label class=" control-label">
                            Horómetro
                        </label>
                    </div>

                    <div class="col-md-2">
                        <g:textField name="horometro" class="form-control input-sm "/>
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Kilometraje
                        </label>
                    </div>

                    <div class="col-md-2">
                        <g:textField name="kilometraje" class="form-control input-sm "/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 text-info">
                        <h3>Trabajos a realizar <small>Seleccione todos los que apliquen</small></h3>
                        <a href="#" id="selectNone" class="btn btn-danger btn-xs">Quitar toda la selección</a>
                    </div>
                </div>

                <g:each in="${TipoTrabajo.list([sort: 'nombre'])}" var="tipo" status="i">
                    <g:if test="${i % 4 == 0}">
                        <g:if test="${i > 0}">
                            </div>
                        </g:if>
                        <div class='row'>
                    </g:if>
                    <div class="col-md-3">
                        <span class="clickable" data-state="off">
                            <i class="fa fa-square-o"></i> ${tipo}
                        </span>
                    </div>
                </g:each>
                </div>

                <div class="row">
                    <div class="col-md-12 text-info">
                        <h3>Detalle de los trabajos a realizar</h3>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <g:textArea name="detalles" class="form-control" style="height: 200px;"/>
                    </div>
                </div>
            </elm:container>
        </g:form>


        <script type="text/javascript">

            function select($elm) {
                $elm.addClass("text-info");
                $elm.data("state", "on");
                $elm.find("i").removeClass("fa-square-o").addClass("fa-check-square-o");
                $elm.css("font-weight", "bold");
            }
            function deselect($elm) {
                $elm.removeClass("text-info");
                $elm.data("state", "off");
                $elm.find("i").removeClass("fa-check-square-o").addClass("fa-square-o");
                $elm.css("font-weight", "normal");
            }

            $(function () {
                $("#maquina").val("");

                $("#maquina_input").val("").click(function () {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'maquinaria', action:'list_ajax')}",
                        success : function (msg) {
                            closeLoader();
                            var b = bootbox.dialog({
                                id      : "dlgFindMaquinaria",
                                title   : "Buscar Maquinaria",
//                            class   : "modal-lg",
                                message : msg,
                                buttons : {
                                    cancelar : {
                                        label     : "Cerrar",
                                        className : "btn-primary",
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

                $("#selectNone").click(function () {
                    $(".clickable").each(function () {
                        deselect($(this));
                    });
                    return false;
                });

                $(".clickable").click(function () {
                    var state = $(this).data("state");
                    if (state == "off") {
                        select($(this));
                    } else {
                        deselect($(this));
                    }
                });
            });
        </script>

    </body>
</html>