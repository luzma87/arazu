<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Notas de pedido pendientes de aprobación</title>
        <style type="text/css">
        table {
            margin-top : 10px;
            font-size  : 12px;
        }
        </style>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Notas de pedido pendientes de revisión">
            <g:render template="/templates/tablaNotaPedido"
                      model="[params      : params, strSearch: strSearch, notas: notas, notasCount: notasCount,
                              revisar     : 'revisarJefatura',
                              linkBusqueda: 'listaJefatura']"/>
        </elm:container>

    </body>
</html>