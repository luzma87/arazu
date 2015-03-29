<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Solicitudes de mantenimiento externo pendientes de asignación</title>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Solicitudes de mantenimiento externo pendientes de asignación">
            <g:render template="/templates/tablaSolicitudMantExt"
                      model="[params      : params, strSearch: strSearch, solicitudes: solicitudes, solicitudesCount: solicitudesCount,
                              revisar     : 'revisarJefeCompras',
                              linkBusqueda: 'listaJefeCompras']"/>
        </elm:container>

    </body>
</html>