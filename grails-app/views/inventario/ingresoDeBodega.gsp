<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Ingreso a bodega</title>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <a href="#" class="btn btn-default btnCrear">
            <i class="fa fa-file-o"></i> Crear
        </a>
    </div>

</div>
<elm:container tipo="horizontal" titulo="Ingreso a bodega">
    <div class="row">
        <elm:fieldRapido label="Fecha">
            ${new java.util.Date().format("dd-MM-yyyy hh:mm:ss")}
        </elm:fieldRapido>
        <elm:fieldRapido label="Número">
            ${new java.util.Date().format("dd-MM-yyyy hh:mm:ss")}
        </elm:fieldRapido>
    </div>
    <div class="row">
        <elm:fieldRapido label="Bodega">
            <g:select name="bodega.id" from="${bodegas}" class="form-control input-sm"></g:select>
        </elm:fieldRapido>
    </div>
</elm:container>
<elm:container tipo="vertical" titulo="Detalle" style="min-height: 200px">
</elm:container>
</body>
</html>