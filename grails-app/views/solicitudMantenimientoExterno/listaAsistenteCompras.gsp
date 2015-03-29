<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 23/02/2015
  Time: 23:21
--%>
<%@ page import="arazu.solicitudes.Cotizacion" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Solicitudes de mantenimiento externo pendientes de cotizaciones</title>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Solicitudes de mantenimiento externo pendientes de cotizaciones">
            <g:render template="/templates/tablaSolicitudMantExt"
                      model="[params      : params, strSearch: strSearch, solicitudes: solicitudes, solicitudesCount: solicitudesCount,
                              revisar     : 'revisarAsistenteCompras', cotizaciones: true,
                              linkBusqueda: 'listaAsistenteCompras']"/>
        </elm:container>

    </body>
</html>