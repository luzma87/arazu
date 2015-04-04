<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 4/4/2015
  Time: 1:09 PM
--%>


<g:each in="${datos}" var="dt">
    <g:set var="d" value="${dt.value}"/>

    <h1>${d.bodega}</h1>

    <g:if test="${d.ingresos.size > 0}">
        <h3>Ingresos</h3>
        <table class="table table-bordered table-condensed table-hover">
            <thead>
                <tr>
                    <th>Fecha</th>
                    <th>Item</th>
                    <th>Unidad</th>
                    <th>Cantidad</th>
                    <th>Saldo</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${d.ingresos}" var="ing">
                    <tr>
                        <td>${ing.fecha.format("dd-MM-yyyy")}</td>
                        <td>${ing.item}</td>
                        <td>${ing.unidad}</td>
                        <td class="text-right">
                            <g:formatNumber number="${ing.cantidad}" maxFractionDigits="2" minFractionDigits="2"/>
                        </td>
                        <td class="text-right">
                            <g:formatNumber number="${ing.saldo}" maxFractionDigits="2" minFractionDigits="2"/>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </g:if>

    <g:if test="${d.egresos.size > 0}">
        <h3>Egresos</h3>
        <table class="table table-bordered table-condensed table-hover">
            <thead>
                <tr>
                    <th>Fecha</th>
                    <th>Item</th>
                    <th>Unidad</th>
                    <th>Cantidad</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${d.egresos}" var="eg">
                    <tr>
                        <td>${eg.fecha.format("dd-MM-yyyy")}</td>
                        <td>${eg.ingreso.item}</td>
                        <td>${eg.ingreso.unidad}</td>
                        <td class="text-right">
                            <g:formatNumber number="${eg.cantidad}" maxFractionDigits="2" minFractionDigits="2"/>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </g:if>

    <g:if test="${d.ingresosDesecho.size > 0}">
        <h3>Ingresos de desechos</h3>
        <table class="table table-bordered table-condensed table-hover">
            <thead>
                <tr>
                    <th>Fecha</th>
                    <th>Item</th>
                    <th>Unidad</th>
                    <th>Cantidad</th>
                    <th>Saldo</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${d.ingresosDesecho}" var="ing">
                    <tr>
                        <td>${ing.fecha.format("dd-MM-yyyy")}</td>
                        <td>${ing.item}</td>
                        <td>${ing.unidad}</td>
                        <td class="text-right">
                            <g:formatNumber number="${ing.cantidad}" maxFractionDigits="2" minFractionDigits="2"/>
                        </td>
                        <td class="text-right">
                            <g:formatNumber number="${ing.saldo}" maxFractionDigits="2" minFractionDigits="2"/>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </g:if>

    <g:if test="${d.egresosDesecho.size > 0}">
        <h3>Egresos de desechos</h3>
        <table class="table table-bordered table-condensed table-hover">
            <thead>
                <tr>
                    <th>Fecha</th>
                    <th>Item</th>
                    <th>Unidad</th>
                    <th>Cantidad</th>
                    <th>Tipo de desecho</th>
                    <th>Lugar de desecho</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${d.egresosDesecho}" var="eg">
                    <tr>
                        <td>${eg.fecha.format("dd-MM-yyyy")}</td>
                        <td>${eg.ingreso.item}</td>
                        <td>${eg.ingreso.unidad}</td>
                        <td class="text-right">
                            <g:formatNumber number="${eg.cantidad}" maxFractionDigits="2" minFractionDigits="2"/>
                        </td>
                        <td>
                            ${eg.tipoDesecho}
                            <g:if test="${eg.tipoDesecho?.requierePrecio == 1}">
                                (<g:formatNumber number="${eg.precioDesecho}" type="currency"/>)
                            </g:if>
                        </td>
                        <td>${eg.lugarDesecho}</td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </g:if>

</g:each>
