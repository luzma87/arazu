<!DOCTYPE html>
<%@ page import="arazu.nomina.Asistencia" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Registro de horas extra${proy ? ' del proyecto ' + proy.nombre : ''}</title>

        %{--<imp:css src="${resource(dir: 'css/custom', file: 'asistencia.css')}"/>--}%
    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Registro de horas extra${proy ? ' del proyecto ' + proy.nombre : ''}">
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
                                <th colspan="${(max - min + 2) * 2}">
                                    %{--${now.format("MMMM-yyyy").toUpperCase()}--}%
                                    ${g.formatDate(date: now, format: 'MMMM yyyy', locale: 'es').toString().toUpperCase()}
                                </th>
                            </tr>
                            <tr>
                                <th style="width: 9%;">Empleado</th>
                                <g:each in="${min..max}" var="i" status="j">
                                    <th style="width: 9%;" colspan="2">
                                        ${i}
                                    </th>
                                </g:each>

                            </tr>
                            <tr>
                                <th></th>
                                <g:each in="${min..max}" var="i" status="j">
                                    <th>50</th>
                                    <th>100</th>
                                </g:each>
                            </tr>
                        </thead>
                        <tbody>
                            <g:set var="lastProyId" value="${''}"/>
                            <g:each in="${empleados}" var="empleado">
                                <g:if test="${lastProyId != empleado.proyecto?.id}">
                                    <g:set var="lastProyId" value="${empleado.proyecto?.id}"/>
                                    <tr>
                                        <th class="success" colspan="${(max - min + 2) * 2}">
                                            ${empleado.proyecto ?: 'Sin proyecto'}
                                        </th>
                                    </tr>
                                </g:if>
                                <tr>
                                    <td class="empleado">
                                        ${empleado.nombre} ${empleado.apellido}
                                        <g:if test="${empleado.proyecto}">
                                            <g:set var="fechas" value="${empleado.fechasProyectoActual}"/>
                                            <br/><small>(desde ${fechas.inicio.format("dd-MM-yyyy")}${fechas.final ? ' a ' + fechas.final.format("dd-MM-yyyy") : ''})</small>
                                        </g:if>
                                    </td>
                                    <g:each in="${min..max}" var="i" status="j">
                                        <g:set var="fecha"
                                               value="${(i < dia) ? now.minus(dia - i) : now.plus(i - dia)}"/>
                                        <g:set var="asistencia"
                                               value="${Asistencia.findByEmpleadoAndFecha(empleado, fecha.clearTime())}"/>
                                        <g:if test="${asistencia}">
                                            <g:if test="${i <= dia}">
                                                <g:if test="${asistencia.tipo.codigo == 'ASTE'}">
                                                    <td class="${i == dia ? 'actual iterador' : 'disabled'} ${asistencia ? asistencia.tipo.codigo : ''}"
                                                        empleado="${empleado.id}"
                                                        fecha="${fecha.format('dd-MM-yyyy')}"
                                                        style="background: ${asistencia ? asistencia.tipo.color : ''}">
                                                        <input type="number" max="16" min="0" style="width: 50px;"
                                                               class="digits form-control input-sm 50"
                                                               value="${asistencia.horas50}">
                                                    </td>
                                                    <td class="${i == dia ? 'actual complemento' : 'disabled'} ${asistencia ? asistencia.tipo.codigo : ''}"
                                                        empleado="${empleado.id}"
                                                        fecha="${fecha.format('dd-MM-yyyy')}"
                                                        style="background: ${asistencia ? asistencia.tipo.color : ''}">
                                                        <input type="number" max="16" min="0" style="width: 50px;"
                                                               class="digits form-control input-sm 100"
                                                               value="${asistencia.horas100}">
                                                    </td>
                                                </g:if>
                                                <g:else>
                                                    <td colspan="2"
                                                        class="${i == dia ? 'actual' : 'disabled'} ${asistencia ? asistencia.tipo.codigo : ''}"
                                                        style="background: ${asistencia ? asistencia.tipo.color : ''}; color: white;">
                                                        <i class='${asistencia.tipo.icono}'></i>
                                                        ${asistencia.tipo.nombre}
                                                    </td>
                                                </g:else>
                                            </g:if>
                                            <g:else>
                                                <td style="text-align: right">${asistencia.horas50}</td>
                                                <td style="text-align: right">${asistencia.horas100}</td>
                                            </g:else>

                                        </g:if>
                                        <g:else>
                                            <td colspan="2"></td>
                                        </g:else>
                                    </g:each>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="row">
                <div class="col-md-1">
                    <a href="#" id="guardar" class="btn btn-success"><i
                            class="fa fa-save"></i> Guardar
                    </a>
                </div>
            </div>
        </elm:container>

        <script type="text/javascript">
            var id = null;
            var empleado = null;
            var fecha = null;

            $(function () {
                <g:if test="${proy}">
                $("#proyecto").val('${proy.id}');
                </g:if>
                <g:else>
                $("#proyecto").val('');
                </g:else>
                $('#proyecto').selectpicker('render');

                $("#btnChangeProy").click(function () {
                    location.href = "${createLink(action:'registroHorasExtra')}/" + $("#proyecto").val();
                });
                $("#guardar").click(function () {
                    bootbox.confirm("¿Está seguro de querer guardar las horas extras?", function (result) {
                        if (result) {
                            openLoader();
                            var data = "";
                            $(".iterador").each(function () {
                                if ($(this).hasClass("ASTE")) {
                                    var h50 = $(this).find(".50").val();
                                    var h100 = $(this).parent().find(".complemento").find(".100").val();
                                    if (isNaN(h50))
                                        h50 = 0;
                                    if (isNaN(h100))
                                        h100 = 0;
                                    //console.log(h50,h100, $(this).find(".50"), $(this).find(".100"))
                                    if ((h50 * 1 + h100 * 1) > 0)
                                        data += $(this).attr("empleado") + ";" + $(this).attr("fecha") + ";" + h50 + ";" + h100 + "|"
                                }
                            });
                            //console.log("data",data)
                            if (data != "") {
                                $.ajax({
                                    type    : "POST",
                                    url     : "${g.createLink(controller:'asistencia',action:'guardarDatosHoras_ajax')}",
                                    data    : "data="
                                              + data,
                                    success : function (msg) {
                                        closeLoader();
                                        log(
                                                "Datos guardados",
                                                "Success");
                                    },
                                    error   : function () {
                                        log(
                                                "Ha ocurrido un error interno",
                                                "Error");
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