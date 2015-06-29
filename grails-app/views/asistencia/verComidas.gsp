<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 027 27-Jun-15
  Time: 21:01
--%>

<!DOCTYPE html>
<%@ page import="arazu.nomina.Asistencia" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Comidas${proy ? ' del proyecto ' + proy.nombre : ''}</title>

        <imp:css src="${resource(dir: 'css/custom', file: 'asistencia.css')}"/>
    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Comidas${proy ? ' del proyecto ' + proy.nombre : ''}">
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
                <div class="col-md-12" style="overflow-x: auto">
                    <table class="table table-condensed table-bordered table-hover table-striped" style="font-size: 11px">
                        <thead>
                            <tr>
                                <th colspan="${max - min + 4}">
                                    %{--${now.format("MMMM-yyyy").toUpperCase()}--}%
                                    ${g.formatDate(date: now, format: 'MMMM yyyy', locale: 'es').toString().toUpperCase()}
                                </th>
                            </tr>
                            <tr>
                                <th>Empleado</th>
                                <th>Comida</th>
                                <g:each in="${min..max}" var="i" status="j">
                                    <th>
                                        ${i}
                                    </th>
                                </g:each>
                                <th>T.</th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:set var="lastProyId" value="${''}"/>
                            <g:each in="${empleados}" var="empleado">
                                <g:if test="${empleado.proyecto}">
                                    <g:if test="${lastProyId != empleado.proyecto?.id}">
                                        <g:set var="lastProyId" value="${empleado.proyecto?.id}"/>
                                        <tr>
                                            <th class="success" colspan="${max - min + 4}">
                                                ${empleado.proyecto ?: 'Sin proyecto'}
                                            </th>
                                        </tr>
                                        <tr>
                                            <td class="empleado">Invitados ${empleado.proyecto}</td>
                                            <td>
                                                Des.<br/>
                                                Alm.<br/>
                                                Mer.
                                            </td>
                                            <g:set var="totDes" value="${0}"/>
                                            <g:set var="totAlm" value="${0}"/>
                                            <g:set var="totMer" value="${0}"/>
                                            <g:each in="${min..max}" var="i" status="j">
                                                <g:set var="fecha" value="${(i < dia) ? now.minus(dia - i) : now.plus(i - dia)}"/>
                                                <g:set var="asistencia" value="${Asistencia.findAllByFechaAndProyecto(fecha.clearTime(), empleado.proyecto)}"/>
                                                <g:if test="${asistencia.size() == 1}">
                                                    <g:set var="asistencia" value="${asistencia.first()}"/>
                                                </g:if>
                                                <g:else>
                                                    <g:set var="asistencia" value="${null}"/>
                                                </g:else>
                                                <g:set var="totDes" value="${totDes + (asistencia ? asistencia.desayunosInvitado : 0)}"/>
                                                <g:set var="totAlm" value="${totAlm + (asistencia ? asistencia.almuerzosInvitado : 0)}"/>
                                                <g:set var="totMer" value="${totMer + (asistencia ? asistencia.meriendasInvitado : 0)}"/>
                                                <td>
                                                    ${asistencia?.desayunosInvitado}<br/>
                                                    ${asistencia?.almuerzosInvitado}<br/>
                                                    ${asistencia?.meriendasInvitado}<br/>
                                                </td>
                                            </g:each>
                                            <td class="danger" style="font-weight: bold;">
                                                ${totDes}<br/>
                                                ${totAlm}<br/>
                                                ${totMer}
                                            </td>
                                        </tr>
                                    </g:if>
                                    <tr>
                                        <td class="empleado">
                                            ${empleado.nombre} ${empleado.apellido}
                                        </td>
                                        <td>
                                            Des.<br/>
                                            Alm.<br/>
                                            Mer.
                                        </td>
                                        <g:set var="totDes" value="${0}"/>
                                        <g:set var="totAlm" value="${0}"/>
                                        <g:set var="totMer" value="${0}"/>
                                        <g:each in="${min..max}" var="i" status="j">
                                            <g:set var="fecha" value="${(i < dia) ? now.minus(dia - i) : now.plus(i - dia)}"/>
                                            <g:set var="asistencia" value="${Asistencia.findAllByFechaAndEmpleado(fecha.clearTime(), empleado)}"/>
                                            <g:if test="${asistencia.size() == 1}">
                                                <g:set var="asistencia" value="${asistencia.first()}"/>
                                            </g:if>
                                            <g:else>
                                                <g:set var="asistencia" value="${null}"/>
                                            </g:else>
                                            <g:set var="des" value="${asistencia ? asistencia.desayuno ?: "N" : "N"}"/>
                                            <g:set var="alm" value="${asistencia ? asistencia.almuerzo ?: "N" : "N"}"/>
                                            <g:set var="mer" value="${asistencia ? asistencia.merienda ?: "N" : "N"}"/>
                                            <td>
                                                <g:if test="${des == 'S'}">
                                                    <g:set var="totDes" value="${totDes + 1}"/>
                                                    <i class="fa fa-check-circle text-success"></i><br/>
                                                </g:if>
                                                <g:else>
                                                %{--<i class="fa fa-times-circle text-danger"></i><br/>--}%
                                                    <br/>
                                                </g:else>
                                                <g:if test="${alm == 'S'}">
                                                    <g:set var="totAlm" value="${totDes + 1}"/>
                                                    <i class="fa fa-check-circle text-success"></i><br/>
                                                </g:if>
                                                <g:else>
                                                %{--<i class="fa fa-times-circle text-danger"></i><br/>--}%
                                                    <br/>
                                                </g:else>
                                                <g:if test="${mer == 'S'}">
                                                    <g:set var="totMer" value="${totDes + 1}"/>
                                                    <i class="fa fa-check-circle text-success"></i>
                                                </g:if>
                                                <g:else>
                                                %{--<i class="fa fa-times-circle text-danger"></i>--}%
                                                </g:else>
                                            </td>
                                        </g:each>
                                        <td class="danger" style="font-weight: bold;">
                                            ${totDes}<br/>
                                            ${totAlm}<br/>
                                            ${totMer}
                                        </td>
                                    </tr>
                                </g:if>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </elm:container>
        <script type="text/javascript">
            $(function () {
                <g:if test="${proy}">
                $("#proyecto").val('${proy.id}');
                </g:if>
                <g:else>
                $("#proyecto").val('');
                </g:else>
                $('#proyecto').selectpicker('render');

                $("#btnChangeProy").click(function () {
                    location.href = "${createLink(action:'verHorasExtra')}/" + $("#proyecto").val();
                });
            });
        </script>
    </body>
</html>