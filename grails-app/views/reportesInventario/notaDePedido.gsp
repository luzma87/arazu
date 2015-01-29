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

    div.header{
        display: block;
        text-align: center;
        position: running(header);
    }

    div.footer{
        display: block;
        text-align: center;
        position: running(footer);
    }
    div.content{
        page-break-after: always;
    }
    @page{
        @top-center{
            content: element(header);
        }
    }
    @page{
        @bottom-center{
            content: element(footer);
        }
    }


    </style>
</head>

<body>
<div class="header">
    <g:header titulo="Nota de pedido"/>
</div>

<div class="hoja">
    <div class="row" style="">
        <div style="width: 130px;height: 20px;float: right;font-weight: bold">
            Número
        </div>
    </div>
    <div class="row" style="">
        <div style="width: 130px;height: 20px;float: right;border: 1px solid #000000;padding-right: 5px;text-align: right;line-height: 20px">
            ${nota.numero}
        </div>
    </div>
    <table style="width: 100%;margin-top: 15px">
        <tbody>
        <tr>
            <td class="label" >Tipo:</td>
            <td>${nota.tipoSolicitud.descripcion}</td>
        </tr>
        <tr>
            <td class="label" >Fecha:</td>
            <td>${nota.fecha.format("dd-MM-yyyy hh:mm:ss")}</td>
        </tr>
        <tr>
            <td class="label" >De:</td>
            <td>${nota.de}</td>
        </tr>
        <tr>
            <td class="label" >Proyecto:</td>
            <td>${nota.proyecto.nombre}</td>
        </tr>
        <tr>
            <td class="label" >Departamento:</td>
            <td></td>
        </tr>
        <tr>
            <td class="label" >Equipo:</td>
            <td>${nota.maquinaria}</td>
        </tr>
        </tbody>
    </table>
    <div class="row" style="margin-top: 30px">
        Solicito se digne disponer se despache las especies que constan a continuación
    </div>
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
                ${nota.cantidad.toInteger()}
            </td>
            <td style="text-align: center">
                ${nota.unidad}
            </td>
            <td>
                ${nota.item.descripcion}
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
                ${nota.de}
            </td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td style="text-align: center">Solicitado</td>
            <td></td>
            <td></td>
        </tr>
        </tbody>
    </table>
</div>
<div class="footer">
    Impreso el ${new java.util.Date().format('dd-MM-yyyy HH:mm:ss')}
</div>

</body>
</html>