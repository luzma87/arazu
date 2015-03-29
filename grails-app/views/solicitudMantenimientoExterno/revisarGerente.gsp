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
        <title>Solicitud de mantenimiento externo #${solicitud.numero}</title>
    </head>

    <body>
        <g:render template="/templates/revisarAprobacionFinalMX"
                  model="[tipo: 'Gerente', flash: flash, solicitud: solicitud, cots: cots]"/>
    </body>
</html>