<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 24/02/2015
  Time: 23:51
--%>
<%@ page import="arazu.solicitudes.Cotizacion" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Solicitudes de mantenimiento interno pendientes de aprobación final</title>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Solicitudes de mantenimiento interno pendientes de aprobación final">
            <g:render template="/templates/tablaSolicitudMantInt"
                      model="[params      : params, strSearch: strSearch, solicitudes: solicitudes, solicitudesCount: solicitudesCount,
                              revisar     : 'revisarGerente', cotizaciones: true,
                              linkBusqueda: 'listaGerente']"/>
        </elm:container>
    </body>
</html>