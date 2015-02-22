<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Notas de pedido pendientes de asignación</title>
        <style type="text/css">
        table {
            margin-top : 10px;
            font-size  : 12px;
        }
        </style>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Notas de pedido pendientes de asignación">
            <table class="table table-striped  table-bordered table-hover table-condensed">
                <thead>
                    <tr>
                        <th style="width: 50px">Número</th>
                        <th style="width: 130px">Fecha</th>
                        <th style="width: 80px">Tipo</th>
                        <th style="">Item</th>
                        <th style="width: 150px">Estado</th>
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
                            <td>${nota.cantidad.toInteger()}${nota.unidad.codigo} ${nota.item}</td>
                            <td title="${nota.estadoSolicitud?.descripcion}">${nota.estadoSolicitud}</td>
                            <td style="text-align: center">
                                <g:link controller="notaDePedido" action="revisarJefeCompras" title="Revisar" id="${nota.id}" class="btn btn-primary btn-sm">
                                    <i class="fa fa-pencil-square-o"></i>
                                </g:link>
                            </td>
                            <td style="text-align: center">
                                <a href="${elm.pdfLink(href: createLink(controller: 'reportesInventario', action: 'notaDePedido', id: nota.id), filename: 'nota_pedido_' + nota.numero + '_' + nota.fecha.format('dd-MM-yyyy') + ".pdf")}"
                                   title="Imprimir" class="btn btn-info btn-sm imprimir" iden="${nota.id}">
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