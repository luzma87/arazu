<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 25/02/2015
  Time: 0:08
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Solicitud de mantenimiento interno ${solicitud.codigo}</title>
    </head>

    <body>
        <g:render template="/templates/revisarAprobacionFinalMI"
                  model="[tipo: 'Gerente', flash: flash, solicitud: solicitud]"/>
    </body>
</html>