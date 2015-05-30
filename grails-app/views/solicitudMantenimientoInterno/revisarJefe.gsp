<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 24/02/2015
  Time: 23:58
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Solicitud de mantenimiento interno ${solicitud.codigo}</title>
    </head>

    <body>
        <g:render template="/templates/revisarAprobacionFinalMI"
                  model="[tipo: 'Jefe', flash: flash, solicitud: solicitud]"/>
    </body>
</html>