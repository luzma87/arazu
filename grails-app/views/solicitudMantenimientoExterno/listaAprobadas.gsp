<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 26/02/2015
  Time: 23:37
--%>

<%@ page import="arazu.solicitudes.BodegaPedido; arazu.solicitudes.Cotizacion" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Solicitudes de mantenimiento externo aprobadas</title>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Solicitudes de mantenimiento externo aprobadas">
            <g:render template="/templates/tablaSolicitudMantExt"
                      model="[params      : params, strSearch: strSearch, solicitudes: solicitudes, solicitudesCount: solicitudesCount,
                              linkBusqueda: 'listaAprobadas']"/>
        </elm:container>
    </body>
</html>