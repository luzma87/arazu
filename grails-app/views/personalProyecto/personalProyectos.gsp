<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 02/06/15
  Time: 10:43 AM
--%>

<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 13-May-15
  Time: 22:03
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Personal${proy ? ' del proyecto ' + proy.nombre : ' de proyectos'}</title>
    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Personal${proy ? ' del proyecto ' + proy.nombre : ' de proyectos'}">
            <div class="row">
                <div class="col-sm-1">
                    <label for="proyecto">Proyecto</label>
                </div>

                <div class="col-sm-3">
                    <g:select name="proyecto" from="${proyectos}" class="form-control"
                              optionKey="id" noSelection="['': '- Todos -']" data-live-search="true"/>
                </div>

                <div class="col-sm-3">
                    <a href="#" class="btn btn-info" id="btnChangeProy">
                        <i class="fa fa-refresh"></i>
                        Cambiar
                    </a>
                </div>
            </div>

            <table class="table table-condensed table-striped table-bordered table-hover" style="margin-top: 15px;">
                <thead>
                    <tr>
                        <th>Proyecto</th>
                        <th>Persona</th>
                        <th style="width: 200px;">
                            Fecha de inicio
                        </th>
                        <th style="width: 200px;">
                            Fecha de fin
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${personal}" var="p">
                        <g:set var="desde" value="${p.fechaInicio.format("dd-MM-yyyy HH:mm")}"/>
                        <g:set var="hasta" value="${p.fechaFin?.format("dd-MM-yyyy HH:mm")}"/>
                        <tr>
                            <td>${p.proyecto}</td>
                            <td>${p.persona}</td>
                            <td class="tdDate" data-val="${desde}">
                                ${desde}
                            </td>
                            <td class="tdDate" data-val="${hasta}">
                                ${hasta}
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </elm:container>

        <script type="text/javascript">
            $(function () {
                <g:if test="${proy}">
                $("#proyecto").val('${proy.id}');
                </g:if>
                <g:else>
                $("#proyecto").val('');
                </g:else>

                $("#btnChangeProy").click(function () {
                    location.href = "${createLink(action:'personalProyectosAdmin')}/" + $("#proyecto").val();
                });
            });
        </script>
    </body>
</html>