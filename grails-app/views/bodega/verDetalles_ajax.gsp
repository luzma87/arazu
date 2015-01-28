<div class="alert alert-info">
    Ingresos en <strong>${unidad.descripcion}</strong>
    de <strong>${item.descripcion}</strong>
    en la bodega <strong>${bodega.descripcion}</strong>
</div>

<table class="table table-striped table-hover table-bordered">
    <thead>
        <tr>
            <th>Fecha</th>
            <th>Pedido</th>
            <th>Cantidad</th>
            <th>Saldo</th>
            <th>V. Unitario</th>
            <th>V. Total</th>
        </tr>
    </thead>
    <tbody>
        <g:set var="totalValor" value="${0}"/>
        <g:set var="totalSaldo" value="${0}"/>
        <g:set var="totalCantidad" value="${0}"/>
        <g:if test="${ingresos.size() > 0}">
            <g:each in="${ingresos}" var="ig" status="i">
                <g:set var="totalValor" value="${totalValor + ig.valor * ig.saldo}"/>
                <g:set var="totalCantidad" value="${totalCantidad + ig.cantidad}"/>
                <g:set var="totalSaldo" value="${totalSaldo + ig.saldo}"/>
                <tr>
                    <td>
                        ${ig.fecha.format("dd-MM-yyyy hh:mm:ss")}
                    </td>
                    <td>
                        ${ig?.pedido}
                    </td>
                    <td class="text-right">
                        <g:formatNumber number="${ig.cantidad}" maxFractionDigits="2" minFractionDigits="2"/>
                    </td>
                    <td class="text-right">
                        <g:formatNumber number="${ig.saldo}" maxFractionDigits="2" minFractionDigits="2"/>
                    </td>
                    <td class="text-right">
                        <g:formatNumber number="${ig.valor}" type="currency"/>
                    </td>
                    <td class="text-right">
                        <g:formatNumber number="${ig.valor * ig.cantidad}" type="currency"/>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <tr class="danger">
                <td class="text-center" colspan="7">
                    No se encontraron registros que mostrar
                </td>
            </tr>
        </g:else>
    </tbody>
    <tfoot>
        <tr>
            <th colspan="2" class="text-right">TOTAL</th>
            <th class="text-right">
                <g:formatNumber number="${totalCantidad.toDouble()}" maxFractionDigits="2" minFractionDigits="2"/>
            </th>
            <th class="text-right">
                <g:formatNumber number="${totalSaldo.toDouble()}" maxFractionDigits="2" minFractionDigits="2"/>
            </th>
            <th></th>
            <th class="text-right">
                <g:formatNumber number="${totalValor.toDouble()}" type="currency"/>
            </th>
        </tr>
    </tfoot>
</table>