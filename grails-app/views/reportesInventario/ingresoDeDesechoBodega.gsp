<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <g:set var="titleCorto" value="Ingreso de desecho a bodega #${ingreso.id}" scope="request"/>
        <meta name="layout" content="reporte_vertical"/>

        <title>Ingreso de desecho a bodega</title>

        <style type="text/css">
        .row {
            width      : 100%;
            height     : 14px;
            margin-top : 10px;
            font-size  : 12px;
        }

        .label {
            width       : 150px;
            font-weight : bold;
        }

        td {
            padding : 3px;
            border  : 1px solid #fff
        }

        th {
            background-color : #3A5DAA;
            color            : #ffffff;
            font-weight      : bold;
            font-size        : 12px;
            border           : 1px solid #fff;
            padding          : 3px;
        }

        .odd {
            background-color : #d7dfda;
        }
        </style>
    </head>

    <body>

        <table style="width: 100%;margin-top: 15px">
            <tbody>
                <tr>
                    <td class="label">Fecha:</td>
                    <td>${ingreso.fecha.format("dd-MM-yyyy hh:mm:ss")}</td>
                </tr>
                <tr>
                    <td class="label">Bodega:</td>
                    <td>${ingreso.bodega.descripcion}</td>
                </tr>
                <tr>
                    <td class="label">Responsable:</td>
                    <td>${ingreso.bodega.responsable}, ${ingreso.bodega.suplente}</td>
                </tr>
                %{--<tr>--}%
                %{--<td class="label">Nota de pedido:</td>--}%
                %{--<td>${(ingreso.pedido) ? ingreso.pedido : 'Ingreso de inventario inicial'}</td>--}%
                %{--</tr>--}%
                %{--<tr>--}%
                %{--<td class="label">Orden de compra:</td>--}%
                %{--<td></td>--}%
                %{--</tr>--}%
                %{--<tr>--}%
                %{--<td class="label">N de factura:</td>--}%
                %{--<td>${ingreso.factura}</td>--}%
                %{--</tr>--}%
            </tbody>
        </table>

        <table style="margin-top: 10px;width: 100%;border-collapse: collapse;">
            <thead>
                <tr>
                    <th>Cantidad</th>
                    <th>Unidad</th>
                    <th>Descripción</th>
                </tr>
            </thead>
            <tbody>
                <tr class="odd">
                    <td style="text-align: center">
                        ${ingreso.cantidad}
                    </td>
                    <td style="text-align: center">
                        ${ingreso.unidad}
                    </td>
                    <td>
                        ${ingreso.item.descripcion}
                    </td>
                </tr>
            </tbody>
        </table>
        <table style="margin-top: 100px;width: 90%;margin-left: 10px">
            <tbody>
                <tr>
                    <td style="width: 33%; text-align: center;">
                        <g:if test="${ingreso.ingresa}">
                            <img src="${resource(dir: 'firmas', file: ingreso.ingresa.path)}" height="100"/>
                        </g:if>
                    </td>
                    <td style="width: 33%"></td>
                    <td style="width: 33%"></td>
                </tr>
                <tr>
                    <td style="text-align: center">
                        ${ingreso.ingresa?.persona}
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td style="text-align: center; font-weight: bold;">Responsable de bodega</td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>

    </body>
</html>