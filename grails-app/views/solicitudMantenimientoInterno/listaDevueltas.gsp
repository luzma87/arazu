<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 28-May-15
  Time: 21:15
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Solicitudes de mantenimiento interno devueltas</title>
    </head>

    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Solicitudes de mantenimiento interno devueltas">
            <g:render template="/templates/tablaSolicitudMantInt"
                      model="[params      : params, strSearch: strSearch, solicitudes: solicitudes, solicitudesCount: solicitudesCount,
                              buscarEstado: false, editar: 'pedido',
                              linkBusqueda: 'listaDevueltas']"/>
        </elm:container>

    </body>
</html>