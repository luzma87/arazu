<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 26/02/2015
  Time: 21:16
--%>

<%@ page import="arazu.inventario.Egreso; arazu.solicitudes.BodegaPedido; arazu.solicitudes.Cotizacion" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Notas de pedido existentes en bodega</title>
        <style type="text/css">
        table {
            margin-top : 10px;
            font-size  : 12px;
        }
        </style>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Notas de pedido en bodega">
            <table class="table table-striped  table-bordered table-hover table-condensed">
                <thead>
                    <tr>
                        <th style="width: 50px">Número</th>
                        <th style="width: 130px">Fecha</th>
                        <th style="width: 80px">Tipo</th>
                        <th style="">Item</th>
                        <th style="width: 150px">Estado</th>
                        <th style="width: 200px">Detalles</th>
                        <th style="width: 50px">Entregado</th>
                        <th style="width: 75px"></th>
                    </tr>
                </thead>
                <tbody id="tabla-items">
                    <g:each in="${notas}" var="nota">
                        <g:set var="entregado" value="${Egreso.findAllByPedido(nota).cantidad.sum() ?: 0}"/>
                        <g:if test="${entregado < nota.cantidad}">
                            <tr>
                                <td>${nota.numero}</td>
                                <td>${nota.fecha.format("dd-MM-yyyy hh:mm:ss")}</td>
                                <td>${nota.tipoSolicitud.descripcion}</td>
                                <td>${nota.cantidad.toInteger()}${nota.unidad.codigo} ${nota.item}</td>
                                <td title="${nota.estadoSolicitud?.descripcion}">${nota.estadoSolicitud}</td>
                                <td>
                                    <g:set var="bps" value="${BodegaPedido.findAllByPedido(nota)}"/>
                                    <g:if test="${bps.size() > 0}">
                                        <ul>
                                            <g:each in="${bps}" var="bp">
                                                <li>${bp.cantidad}${bp.pedido.unidad.codigo} en ${bp.bodega}</li>
                                            </g:each>
                                        </ul>
                                    </g:if>
                                </td>
                                <td>
                                    <g:formatNumber number="${entregado}" maxFractionDigits="2" minFractionDigits="2"/>${nota.unidad.codigo}
                                </td>
                                <td style="text-align: center">
                                    <div class="btn-group" role="group">
                                        <a href="#" title="Egreso" id="${nota.id}" class="btn btn-primary btn-sm btnIng">
                                            <i class="fa fa-shopping-cart"></i>
                                        </a>
                                        <a href="${elm.pdfLink(href: createLink(controller: 'reportesInventario', action: 'notaDePedido', id: nota.id), filename: 'nota_pedido_' + nota.numero + '_' + nota.fecha.format('dd-MM-yyyy') + ".pdf")}"
                                           title="Imprimir" class="btn btn-info btn-sm imprimir" iden="${nota.id}">
                                            <i class="fa fa-print"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </g:if>
                    </g:each>
                </tbody>
            </table>
        </elm:container>

        <script type="text/javascript">
            $(function () {

            });
        </script>

    </body>
</html>