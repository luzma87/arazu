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
        <title>Personal de proyectos</title>
    </head>

    <body>

        <table class="table table-condensed table-striped table-bordered table-hover">
            <thead>
                <tr>
                    <th>Proyecto</th>
                    <th>Persona</th>
                    <th>Fecha de inicio</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${personal}" var="p">
                    <tr>
                        <td>${p.proyecto}</td>
                        <td>${p.persona}</td>
                        <td>${p.fechaInicio.format("dd-MM-yyyy HH:mm")}</td>
                    </tr>
                </g:each>
            </tbody>
        </table>

    </body>
</html>