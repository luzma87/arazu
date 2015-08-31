<!DOCTYPE html>
<%@ page import="arazu.parametros.TipoAsistencia; arazu.proyectos.Proyecto; arazu.nomina.Asistencia" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Registro de asistencia${proy ? ' del proyecto ' + proy.nombre : ''}</title>

        %{--<imp:css src="${resource(dir: 'css/custom', file: 'asistencia.css')}"/>--}%

    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Registro de asistencia${proy ? ' del proyecto ' + proy.nombre : ''}">
            <div class="row">
                <div class="col-sm-1">
                    <label for="proyecto">Proyecto</label>
                </div>

                <div class="col-sm-3">
                    <g:select name="proyecto" from="${proyectos}" class="form-control"
                              optionKey="id" noSelection="['': '- Todos -']" data-live-search="true"/>
                </div>

                <div class="col-sm-1">
                    <a href="#" class="btn btn-info" id="btnChangeProy">
                        <i class="fa fa-refresh"></i>
                        Cambiar
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <table class="table table-condensed table-bordered table-hover table-striped">
                        <thead>
                            <tr>
                                <th colspan="${max - min + 2}">
                                    %{--${now.format("MMMM-yyyy").toUpperCase()}--}%
                                    ${g.formatDate(date: now, format: 'MMMM yyyy', locale: 'es').toString().toUpperCase()}
                                </th>
                            </tr>
                            <tr>
                                <th style="width: 9%;">Empleado</th>
                                <g:each in="${min..max}" var="i" status="j">
                                    <th style="width: 9%;">
                                        ${i}
                                    </th>
                                </g:each>

                            </tr>
                        </thead>
                        <tbody>
                            <g:set var="lastProyId" value="${''}"/>
                            <g:each in="${empleados}" var="empleado">
                                <g:if test="${lastProyId != empleado.proyecto?.id}">
                                    <g:set var="lastProyId" value="${empleado.proyecto?.id}"/>
                                    <tr>
                                        <th class="success" colspan="${max - min + 2}">
                                            ${empleado.proyecto ?: 'Sin proyecto'}
                                        </th>
                                    </tr>
                                </g:if>
                                <tr>
                                    <td class="empleado">
                                        ${empleado.nombre} ${empleado.apellido}
                                        <g:if test="${empleado.proyecto}">
                                            <g:set var="fechas" value="${empleado.fechasProyectoActual}"/>
                                            <br/><small>(desde ${fechas?.inicio?.format("dd-MM-yyyy")}${fechas?.final ? ' a ' + fechas.final.format("dd-MM-yyyy") : ''})</small>
                                        </g:if>
                                    </td>
                                    <g:each in="${min..max}" var="i" status="j">
                                        <g:set var="fecha"
                                               value="${(i < dia) ? now.minus(dia - i) : now.plus(i - dia)}"/>
                                        <g:set var="asistencia"
                                               value="${Asistencia.findByEmpleadoAndFecha(empleado, fecha.clearTime())}"/>
                                        <td class="text-center ${i == dia ? 'actual' : 'disabled'}  ${asistencia ? asistencia.tipo.codigo : 'vacio'}"
                                            iden="${asistencia?.id}" empleado="${empleado.id}" tipo="${asistencia?.tipo?.codigo}"
                                            fecha="${fecha.format('dd-MM-yyyy')}"
                                            style="background: ${asistencia ? asistencia.tipo.color : ''}; color:white;">
                                            <g:if test="${asistencia}">
                                                <i class='${asistencia.tipo.icono}'></i>
                                                ${asistencia.tipo.nombre}
                                            </g:if>
                                        </td>
                                    </g:each>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="row">
                <div class="col-md-1">
                    <a href="#" id="guardar" class="btn btn-success">
                        <i class="fa fa-save"></i> Guardar
                    </a>
                </div>
            </div>
        </elm:container>

        <script type="text/javascript">
            var id = null;
            var empleado = null;
            var fecha = null;
            var $proyecto = $("#proyecto");

            function submitFormAsistencia() {
                var $form = $("#frmAsistencia");
                var $btn = $("#dlgCreateEditAsistencia").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    openLoader("Guardando Asistencia");
                    $.ajax({
                        type    : "POST",
                        url     : $form.attr("action"),
                        data    : $form.serialize(),
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            setTimeout(function () {
                                if (parts[0] == "SUCCESS") {
                                    location.reload(true);
                                } else {
                                    spinner.replaceWith($btn);
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
                } else {
                    return false;
                } //else
            }
            function createEditAsistencia(id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? {id : id, empleado : empleado, fecha : fecha} : {empleado : empleado, fecha : fecha};
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'asistencia', action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        closeLoader();
                        var b = bootbox
                                .dialog({
                                    id    : "dlgCreateEditAsistencia",
                                    title : title + " Asistencia",

                                    class : "modal-lg",

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
                                                return submitFormAsistencia();
                                            } //callback
                                        }
                                        //guardar
                                    }
                                    //buttons
                                }); //dialog
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            } //createEdit
            (function ($) {
                $.fn.disableSelection = function () {
                    return this
                            .attr('unselectable', 'on')
                            .css('user-select', 'none')
                            .on('selectstart', false);
                };
            })(jQuery);

            $(function () {
                var tipos = ${tipos};

                $("td").disableSelection();

                $(".actual").click(function () {
                    var celda = $(this);
                    var found = false;
                    var changed = false;
                    for (var i = 0; i < tipos.length; i++) {
                        var tipo = tipos[i];
                        if (!changed && celda.hasClass(tipo.cod)) {
                            changed = true;
                            var next = i + 1;
                            if (next == tipos.length) {
                                next = 0;
                            }
                            found = true;
                            celda.addClass(tipos[next].cod)
                                    .attr("tipo", tipos[next].cod)
                                    .html("<i class='" + tipos[next].icono + "'></i> " + tipos[next].label).css({
                                        background : tipos[next].color,
                                        color      : "#fff"
                                    });
                            for (var j = 0; j < tipos[next].otros.length; j++) {
                                var o = tipos[next].otros[j];
                                celda.removeClass(o);
                            }
                            celda.removeClass("vacio");
                        }
                    }
                    if (!found) {
                        celda.addClass(tipos[0].cod)
                                .attr("tipo", tipos[0].cod)
                                .html("<i class='" + tipos[0].icono + "'></i> " + tipos[0].label).css({
                                    background : tipos[0].color
                                });
                    }
                });

                <g:if test="${proy}">
                $proyecto.val('${proy.id}');
                </g:if>
                <g:else>
                $proyecto.val('');
                </g:else>
                $proyecto.selectpicker('render');

                $("#btnChangeProy").click(function () {
                    location.href = "${createLink(action:'registroAsistencia')}/" + $("#proyecto").val();
                });
                $("#guardar").click(function () {
                    bootbox.confirm("¿Está seguro de querer registrar las asistencias?", function (result) {
                        if (result) {

                            openLoader();
                            var data = "";
                            $(".actual").each(function () {
                                data += $(this).attr("empleado") + ";" + $(this).attr("fecha") + ";" + $(this).attr("tipo") + "|"
                            });

                            if (data != "") {
                                $.ajax({
                                    type    : "POST",
                                    url     : "${g.createLink(controller:'asistencia',action:'guardarDatos_ajax')}",
                                    data    : "data=" + data,
                                    success : function (msg) {
                                        closeLoader();
                                        log("Datos guardados", "Success");
                                    },
                                    error   : function () {
                                        log("Ha ocurrido un error interno", "Error");
                                        closeLoader();
                                    }
                                });
                            } else {
                                closeLoader();
                            }
                        }
                    });
                });
            });
        </script>
    </body>
</html>