<%@ page import="arazu.items.Item; arazu.items.Maquinaria; arazu.seguridad.Persona; arazu.parametros.EstadoSolicitud" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Notas de pedido</title>
    </head>

    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Notas de pedido">
            <g:render template="/templates/tablaNotaPedido"
                      model="[params      : params, strSearch: strSearch, notas: notas, notasCount: notasCount,
                              buscarEstado: true,
                              linkBusqueda: 'lista']"/>
        </elm:container>

    </body>
</html>