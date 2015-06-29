<!DOCTYPE html>
<%@ page import="arazu.parametros.TipoAsistencia; arazu.nomina.Asistencia" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Asistencia${proy ? ' del proyecto ' + proy.nombre : ''}</title>

        %{--<imp:css src="${resource(dir: 'css/custom', file: 'asistencia.css')}"/>--}%
    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Asistencia${proy ? ' del proyecto ' + proy.nombre : ''}">
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
                <div class="col-md-1">
                    <label>
                        Leyenda:
                    </label>
                </div>
                <g:each in="${TipoAsistencia.list([sort: 'orden'])}" var="ta">
                    <div class="col-md-2 ${ta.codigo}" style="background: ${ta.color}">
                        <i class='${ta.icono}'></i>
                        ${ta.nombre}
                    </div>
                </g:each>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <table class="table table-condensed table-bordered table-hover table-striped" style="font-size: 11px">
                        <thead>
                            <tr>
                                <th colspan="${max - min + 2}">
                                    %{--${now.format("MMMM-yyyy").toUpperCase()}--}%
                                    ${g.formatDate(date: now, format: 'MMMM yyyy', locale: 'es').toString().toUpperCase()}
                                </th>
                            </tr>
                            <tr>
                                <th>Empleado</th>
                                <g:each in="${min..max}" var="i" status="j">
                                    <th>
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
                                </td>
                                <g:each in="${min..max}" var="i" status="j">
                                    <g:set var="fecha" value="${(i < dia) ? now.minus(dia - i) : now.plus(i - dia)}"/>
                                    <g:set var="asistencia"
                                           value="${Asistencia.findByEmpleadoAndFecha(empleado, fecha.clearTime())}"/>
                                    <td class=text-center "${i == dia ? 'actual' : 'disabled'}  ${asistencia ? asistencia.tipo.codigo : 'vacio'}"
                                            style="background: ${asistencia ? asistencia.tipo.color : ''}; color: white;">
                                    <g:if test="${asistencia}">
                                        <i class='${asistencia.tipo.icono}'></i>
                                    </g:if>
                                    </td>
                                </g:each>
                                </tr>
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
                    location.href = "${createLink(action:'verAsistencia')}/" + $("#proyecto").val();
                });
            });
        </script>
    </body>
</html>