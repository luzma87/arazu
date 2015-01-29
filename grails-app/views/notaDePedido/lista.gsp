<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Nota de pedido</title>
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
<table class="table table-striped table-hover table-bordered" style="margin-top: 10px">
    <thead>
    <tr>
        <th style="width: 80px">Número</th>
        <th style="width: 80px">Fecha</th>
        <th style="width: 80px">Tipo</th>
        <th style="">Item</th>
        <th style="width: 80px">Cantidad</th>
        <th style="width: 80px">Estado</th>
    </tr>
    </thead>
    <tbody id="tabla-items">
        <g:each in="${notas}" var="nota">
            <tr>
                <td>${nota.numero}</td>
                <td>${nota.fecha.format("dd-MM-yyyy hh:mm:ss")}</td>
                <td>${nota.tipoSolicitud.descripcion}</td>
                <td>${nota.item}</td>
                <td>${nota.cantidad}</td>
                <td>${nota.estadoSolicitud.descripcion}</td>
            </tr>
        </g:each>
    </tbody>

</table>
</body>
</html>