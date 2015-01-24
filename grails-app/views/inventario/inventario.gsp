<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Inventario de la bodega ${bodega.descripcion}</title>
</head>
<body>
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <a href="${g.createLink(controller: 'inventario',action: 'ingresoDeBodega',params: [bodega:bodega.id])}" class="btn btn-default btnCrear">
            <i class="fa fa-file-o"></i> Nuevo ingreso a bodega
        </a>
    </div>

</div>
<elm:container tipo="horizontal" titulo="Inventario de la bodega ${bodega.descripcion}">
    <div class="row">
        <div class="col-md-1">
            <label class=" control-label">
                Responsable
            </label>
        </div>
        <div class="col-md-3">
            ${bodega.persona}
        </div>
    </div>
    <table class="table table-striped table-hover table-bordered" style="margin-top: 10px">
        <thead>
        <tr>
            <th>Fecha</th>
            <th>Pedido</th>
            <th>Item</th>
            <th>Unidad</th>
            <th>Cantidad</th>
            <th>V. Unitario</th>
            <th>V. Total</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <g:set var="total" value="${0}"></g:set>
        <g:each in="${ingresos}" var="ig" status="i">
            <tr>
                <g:set var="total" value="${total+=ig.valor*ig.cantidad}"></g:set>
                <td>${ig.fecha.format("dd-MM-yyyy hh:mm:ss")}</td>
                <td>${ig?.pedido}</td>
                <td>${ig.item.descripcion}</td>
                <td>${ig.unidad}</td>
                <td style="text-align: center">${ig.cantidad.toInteger()}</td>
                <td style="text-align: right"><g:formatNumber number="${ig.valor}" type="currency"></g:formatNumber></td>
                <td style="text-align: right"><g:formatNumber number="${ig.valor*ig.cantidad}" type="currency"></g:formatNumber></td>
                <td style="text-align: center"><a href="#" title="Imprimir" class="btn btn-primary btn-sm" iden="${ig.id}"><i class="fa fa-print"></i></a> </td>
            </tr>
        </g:each>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="6" style="text-align: right;font-weight: bold">TOTAL</td>
            <td style="text-align: right;font-weight: bold"><g:formatNumber number="${total.toDouble()}" type="currency"></g:formatNumber></td>
        </tr>
        </tfoot>
    </table>

</elm:container>
</body>
</html>