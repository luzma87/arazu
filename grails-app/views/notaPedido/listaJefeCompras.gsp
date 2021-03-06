<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Notas de pedido pendientes de asignación</title>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Notas de pedido pendientes de asignación">
            <g:render template="/templates/tablaNotaPedido"
                      model="[params      : params, strSearch: strSearch, notas: notas, notasCount: notasCount,
                              revisar     : 'revisarJefeCompras',
                              linkBusqueda: 'listaJefeCompras']"/>
        </elm:container>

    </body>
</html>