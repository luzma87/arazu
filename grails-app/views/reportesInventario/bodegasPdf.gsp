<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 4/4/2015
  Time: 3:19 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <g:set var="titleCorto" value="Reporte de bodegas" scope="request"/>
        <meta name="layout" content="reporte_vertical"/>

        <title>${title}</title>

        <style type="text/css">
        table {
            width           : 100%;
            border-collapse : collapse;
            margin-top      : 15px;
        }

        td {
            padding : 3px;
            border  : 1px solid #fff
        }

        th {
            background-color : #3A5DAA;
            color            : #ffffff;
            font-weight      : bold;
            border           : 1px solid #fff;
            padding          : 3px;
        }

        .text-right {
            text-align : right;
        }
        </style>
    </head>

    <body>
        <g:each in="${datos}" var="dt">
            <g:set var="d" value="${dt.value}"/>

            <div class="no-break">
                <h1>Bodega ${d.bodega}</h1>

                <g:if test="${d.ingresos.size > 0}">
                    <div class="no-break">
                        <h3 class="title">Ingresos</h3>
                        <table class="table bordered">
                            <thead>
                                <tr>
                                    <th width="80px">Fecha</th>
                                    <th>Item</th>
                                    <th>Unidad</th>
                                    <th width="75px">Cantidad</th>
                                    <th width="75px">Saldo</th>
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
                    </div>
                </g:if>

                <g:if test="${d.egresos.size > 0}">
                    <div class="no-break">
                        <h3 class="title">Egresos</h3>
                        <table class="table bordered">
                            <thead>
                                <tr>
                                    <th width="80px">Fecha</th>
                                    <th>Item</th>
                                    <th>Unidad</th>
                                    <th width="75px">Cantidad</th>
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
                    </div>
                </g:if>

                <g:if test="${d.ingresosDesecho.size > 0}">
                    <div class="no-break">
                        <h3 class="title">Ingresos de desechos</h3>
                        <table class="table bordered">
                            <thead>
                                <tr>
                                    <th width="80px">Fecha</th>
                                    <th>Item</th>
                                    <th>Unidad</th>
                                    <th width="75px">Cantidad</th>
                                    <th width="75px">Saldo</th>
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
                    </div>
                </g:if>

                <g:if test="${d.egresosDesecho.size > 0}">
                    <div class="no-break">
                        <h3 class="title">Egresos de desechos</h3>
                        <table class="table bordered">
                            <thead>
                                <tr>
                                    <th width="80px">Fecha</th>
                                    <th>Item</th>
                                    <th>Unidad</th>
                                    <th width="75px">Cantidad</th>
                                    <th>Tipo de desecho</th>
                                    <th width="75px">Valor</th>
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
                                        </td>
                                        <td class="text-right">
                                            <g:if test="${eg.tipoDesecho?.requierePrecio == 1}">
                                                <g:formatNumber number="${eg.precioDesecho}" type="currency"/>
                                            </g:if>
                                        </td>
                                        <td>${eg.lugarDesecho}</td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </g:if>
            </div>
        </g:each>
    </body>
</html>