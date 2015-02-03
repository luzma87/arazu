<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Notas de pedido del usuario ${session.usuario}</title>
    <style type="text/css">

    .numero{
        text-align: right;
    }
    .unidad{
        text-align: center;
        width: 80px;
    }
    .cantidad{
        text-align: center;
        width: 80px;
    }

    </style>
</head>

<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<elm:container tipo="horizontal" titulo="Notas de pedido pendientes de aprobación">
    <table class="table table-striped  table-bordered" style="margin-top: 10px">
        <thead>
        <tr>
            <th style="width: 80px">Número</th>
            <th style="width: 80px">Fecha</th>
            <th style="width: 80px">Tipo</th>
            <th style="">Item</th>
            <th style="width: 80px">Cantidad</th>
            <th style="width: 80px">Estado</th>
            <th style="width: 50px"></th>
            <th style="width: 50px"></th>
        </tr>
        </thead>
        <tbody id="tabla-items">
        <g:each in="${notas}" var="nota">
            <tr>
                <td>${nota.numero}</td>
                <td>${nota.fecha.format("dd-MM-yyyy hh:mm:ss")}</td>
                <td>${nota.tipoSolicitud.descripcion}</td>
                <td>${nota.item}</td>
                <td class="cantidad">${nota.cantidad.toInteger()}</td>
                <td style="font-weight: bold">${nota.estadoSolicitud.descripcion}</td>
                <td style="text-align: center">
                    <g:link controller="notaDePedido" action="revisar" title="Revisar" id="${nota.id}" class="btn btn-primary btn-sm">
                        <i class="fa fa-pencil-square-o"></i>
                    </g:link>
                </td>
                <td style="text-align: center">
                    <a href="${elm.pdfLink(href: createLink(controller: 'reportesInventario', action: 'notaDePedido', id: nota.id))}" title="Imprimir" class="btn btn-info btn-sm imprimir" iden="${nota.id}">
                        <i class="fa fa-print"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</elm:container>

</body>
</html>