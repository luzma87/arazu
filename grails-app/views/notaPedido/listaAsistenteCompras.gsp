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
        <title>Notas de pedido pendientes de cotizaciones</title>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Notas de pedido pendientes de cotizaciones">
            <g:render template="/templates/tablaNotaPedido"
                      model="[params      : params, strSearch: strSearch, notas: notas, notasCount: notasCount,
                              revisar     : 'revisarAsistenteCompras', cotizaciones: true,
                              linkBusqueda: 'listaAsistenteCompras']"/>
        </elm:container>

    </body>
</html>