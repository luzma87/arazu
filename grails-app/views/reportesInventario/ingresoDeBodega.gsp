<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Ingreso a bodega</title>

    <style type="text/css">
    @page {
        size   : 21cm 29.7cm;  /*width height */
        margin : 2cm;
    }

    .hoja {
        width : 16.5cm;
        font-size: 12px;
    }

    .titulo, .proyecto, .componente {
        width : 16cm;
    }



    .hoja {
        /*background  : #e6e6fa;*/
        height      : 24.7cm; /*29.7-(1.5*2)*/
        font-family : arial;
        font-size   : 11pt;
    }

    .titulo {
        height        : .5cm;
        font-size     : 16pt;
        font-weight   : bold;
        text-align    : center;
        margin-bottom : .5cm;
    }

    .row{
        width: 100%;
        height: 14px;
        margin-top: 10px;
        font-size: 12px;
    }
    .label{
        width: 150px;
        font-weight: bold;
    }
    td{
        padding: 3px;
        border: 1px solid #fff
    }
    table{
        font-size: 12px;
    }
    th{
        background-color: #3A5DAA;
        color: #ffffff;
        font-weight: bold;
        font-size: 12px;
        border: 1px solid #fff;
        padding: 3px;
    }
    .odd{
        background-color: #d7dfda;
    }
    .even{
        background-color: #fff;
    }







    </style>
</head>

<body>
<div class="hoja">
    <g:header titulo="Ingreso a bodega"/>
    <div class="row" style="">
        <div style="width: 130px;height: 20px;float: right;font-weight: bold">
            Ingreso a bodega
        </div>
    </div>
    <div class="row" style="">
        <div style="width: 130px;height: 20px;float: right;border: 1px solid #000000;padding-right: 5px;text-align: right;line-height: 20px">
            ${ingreso.id}
        </div>
    </div>
    <table style="width: 100%;margin-top: 15px">
        <tbody>
        <tr>
            <td class="label" >Fecha:</td>
            <td>${ingreso.fecha.format("dd-MM-yyyy hh:mm:ss")}</td>
        </tr>
        <tr>
            <td class="label" >Bodega:</td>
            <td>${ingreso.bodega.descripcion}</td>
        </tr>
        <tr>
            <td class="label" >Responsable:</td>
            <td>${ingreso.bodega.persona}</td>
        </tr>
        <tr>
            <td class="label" >Nota de pedido:</td>
            <td>${(ingreso.pedido)?ingreso.pedido:'Ingreso de inventario inicial'}</td>
        </tr>
        <tr>
            <td class="label" >Orden de compra:</td>
            <td></td>
        </tr>
        <tr>
            <td class="label" >N de factura:</td>
            <td>${ingreso.factura}</td>
        </tr>
        </tbody>
    </table>
    <div class="row">
        Solicito se digne almacenar las especies que constan a continuación
    </div>
    <table style="margin-top: 10px;width: 100%;border-collapse: collapse;">
        <thead>
        <tr>
            <th>Cantidad</th>
            <th>Unidad</th>
            <th>Descripción</th>
            <th>V/unitario</th>
            <th>V/TOTAL</th>
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
            <td style="text-align: right">
                <g:formatNumber number="${ingreso.valor}"  type="currency"/>
            </td>
            <td style="text-align: right">
                <g:formatNumber number="${ingreso.cantidad*ingreso.valor}"  type="currency"/>
            </td>
        </tr>
        </tbody>
    </table>
    <table style="margin-top: 100px;width: 90%;margin-left: 10px">
        <tbody>
        <tr>
            <td style="width: 33%"></td>
            <td style="width: 33%"></td>
            <td style="width: 33%"></td>
        </tr>
        <tr>
            <td style="border-top: 2px solid black;text-align: center">
                ${ingreso.bodega.persona}
            </td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td style="text-align: center">Responsable de bodega</td>
            <td></td>
            <td></td>
        </tr>
        </tbody>
    </table>
</div>

</body>
</html>