<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 3/28/2015
  Time: 12:22 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Solicitudes de mantenimiento interno</title>
    </head>

    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Solicitudes de mantenimiento externo">
            <g:render template="/templates/tablaSolicitudMantInt"
                      model="[params      : params, strSearch: strSearch, solicitudes: solicitudes, solicitudesCount: solicitudesCount,
                              buscarEstado: true,
                              linkBusqueda: 'lista']"/>
        </elm:container>

    </body>
</html>