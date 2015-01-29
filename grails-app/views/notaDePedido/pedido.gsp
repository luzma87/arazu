<%@ page import="arazu.parametros.TipoSolicitud; arazu.items.Maquinaria; arazu.parametros.Departamento" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Nota de pedido</title>
    <style type="text/css">
    .tt-dropdown-menu {
        width                 : 262px;
        margin-top            : 0px;
        padding               : 5px 0;
        background-color      : rgba(154, 216, 144, 0.91);
        border                : 1px solid #ccc;
        border                : 1px solid rgba(0, 0, 0, 0.2);
        -webkit-border-radius : 4px;
        -moz-border-radius    : 4px;
        border-radius         : 4px;
        -webkit-box-shadow    : 0 5px 10px rgba(0, 0, 0, .2);
        -moz-box-shadow       : 0 5px 10px rgba(0, 0, 0, .2);
        box-shadow            : 0 5px 10px rgba(0, 0, 0, .2);
    }
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
<g:form class="frmNota" action="saveSolicitud">
    <elm:container tipo="horizontal" titulo="Nueva nota de pedido">
        <input type="hidden" name="data" id="data">
        <div class="row">
            <div class="col-md-1">
                <label class=" control-label">
                    Motivo
                </label>
            </div>
            <div class="col-md-2">
                <g:select name="tipoSolicitud.id" from="${arazu.parametros.TipoSolicitud.list()}" optionKey="id" optionValue="descripcion" class="form-control input-sm required"></g:select>
            </div>
            <div class="col-md-1">
                <label class=" control-label">
                    Número
                </label>
            </div>
            <div class="col-md-2">
                ${numero}
            </div>
            <div class="col-md-1">
                <label class=" control-label">
                    Fecha
                </label>
            </div>
            <div class="col-md-3">
                ${new Date().format("dd-MM-yyyy hh:mm:ss")}
            </div>
        </div>
        <div class="row">
            <div class="col-md-1">
                <label class=" control-label">
                    De
                </label>
            </div>
            <div class="col-md-2">
                ${session.usuario}
            </div>
            <div class="col-md-1">
                <label class=" control-label">
                    Para
                </label>
            </div>
            <div class="col-md-2">
                <g:select name="para.id" from="${arazu.seguridad.Persona.list([sort: 'apellido'])}" optionKey="id"  class="form-control input-sm required" noSelection="['':'Seleccione...']"></g:select>
            </div>
        </div>


        <div class="row">
            <div class="col-md-1">
                <label class=" control-label">
                    Proyecto
                </label>
            </div>
            <div class="col-md-2">
                <g:select name="proyecto.id" from="${arazu.proyectos.Proyecto.list()}" optionKey="id" optionValue="descripcion" class="form-control input-sm required" noSelection="['':'Seleccione...']"></g:select>
            </div>
            <div class="col-md-1">
                <label class=" control-label">
                    Equipo
                </label>
            </div>
            <div class="col-md-2">
                <g:select name="maquinaria.id" from="${arazu.items.Maquinaria.list([sort: 'descripcion'])}" optionKey="id" optionValue="descripcion" class="form-control input-sm required" noSelection="['':'Seleccione...']"></g:select>
            </div>
        </div>

        <div class="row" style="margin-bottom: 10px">

        </div>
        <div class="row" style="margin-bottom: 10px;">
            <div class="col-md-1">
                <label class=" control-label">
                    Ítem
                </label>
            </div>

            <div class="col-md-3">
                <input type="text" class="form-control input-sm allCaps" id="item_txt" placeholder="Item" style="width: 100%!important;">
            </div>

            <div class="col-md-1">
                <label class=" control-label">
                    Unidad
                </label>
            </div>

            <div class="col-md-2">
                <g:select name="unidad.id" id="unidad" from="${arazu.parametros.Unidad.list()}" optionKey="id" class="form-control input-sm"></g:select>
            </div>

            <div class="col-md-1">
                <label class=" control-label">
                    Cantidad
                </label>
            </div>

            <div class="col-md-1">
                <div class="input-group">
                    <input type="text" class="form-control input-sm digits" id="cantidad" style="text-align: right" value="1">
                    <span class="input-group-addon svt-bg-warning">#</span>
                </div>
            </div>



            <div class="col-md-1">
                <a href="#" id="agregar" title="Agregar" class="btn btn-success btn-sm">
                    <i class="fa fa-plus"></i>
                </a>
            </div>
        </div>
    </elm:container>
</g:form>
<elm:container tipo="horizontal"  titulo="" style="min-height: 300px;overflow-y: auto;margin-top: 10px">
    <table class="table table-striped table-hover table-bordered" style="margin-top: 10px">
        <thead>
        <tr>
            <th style="width: 80px">Cantidad</th>
            <th style="width: 80px">Unidad</th>
            <th>Descripción</th>
            <th style="width: 50px"></th>
        </tr>
        </thead>
        <tbody id="tabla-items">

        </tbody>

    </table>
    <div class="row" style="margin-top: 20px">
        <div class="col-md-1">
            <a href="#" class="btn btn-primary" id="guardar"><i class="fa fa-save"></i> Guardar</a>
        </div>
    </div>
</elm:container>
<script type="text/javascript">
    var item
    var cantidad
    var valor
    var unidad
    var unidadId
    var id = null;
    var total = 0
    var max = 1
    var data=""
    function reset(){
        $("#item_txt").val("")
        $("#cantidad").val("1")
        $("#valor").val("")
        unidad = null
        unidadId = null
        cantidad = null
        valor = null
    }

    function insertRow(){
        var tr = $("<tr class='item-row'>")
        tr.append("<td class='cantidad'>"+cantidad+"</td>")
        tr.append("<td class='unidad' iden='"+unidadId+"'>"+unidad+"</td>")
        tr.append("<td class='descripcion'>"+item+"</td>")

        var boton = $("<a href='#' title='Borrar' class='btn-borrar btn btn-danger btn-sm'><i class='fa fa-trash-o'></i></a>")

        boton.click(function(){
            $(this).parent().parent().remove()

        });
        var td = $("<td></td>")
        td.append(boton)
        tr.append(td)
        $("#tabla-items").append(tr)
        reset()

    }
    var substringMatcher = function (strs) {
        return function findMatches(q, cb) {
            var matches, substrRegex;

            // an array that will be populated with substring matches
            matches = [];

            // regex used to determine if a string contains the substring `q`
            substrRegex = new RegExp(q, 'i');

            // iterate through the pool of strings and for any string that
            // contains the substring `q`, add it to the `matches` array
            $.each(strs, function (i, str) {
                if (substrRegex.test(str)) {
                    // the typeahead jQuery plugin expects suggestions to a
                    // JavaScript object, refer to typeahead docs for more info
                    matches.push({value : str});
                }
            });

            cb(matches);
        };
    };
    var items = ${items}
            $(function () {
                var validator = $(".frmNota").validate({
                    errorClass     : "help-block",
                    errorPlacement : function (error, element) {
                        if (element.parent().hasClass("input-group")) {
                            error.insertAfter(element.parent());
                        } else {
                            error.insertAfter(element);
                        }
                        element.parents(".grupo").addClass('has-error');
                    },
                    success        : function (label) {
                        label.parents(".grupo").removeClass('has-error');
                        label.remove();
                    }

                });
                $("#agregar").click(function () {
                    if($(".item-row").size()>max){
                        bootbox.alert({
                                    message : "Solo puede registrar un item por orden de ingreso",
                                    title   : "Error",
                                    class   : "modal-error"
                                }
                        );
                    }else{
                        item = $.trim($("#item_txt").val().toUpperCase())
                        cantidad = $("#cantidad").val()
                        unidad = $("#unidad").find("option:selected").text()
                        unidadId = $("#unidad").val()
                        var msg = ""
                        var nuevo = false
                        if (item == "") {
                            msg += "Por favor ingrese un Item."
                        } else {
                            //console.log($.inArray(item, items))
                            if ($.inArray(item, items)<0)
                                nuevo = true
                        }
                        if (cantidad * 1 < 1) {
                            msg += "<br>La cantidad debe ser mayor a cero."
                        }

                        if (msg == "") {
                            cantidad=cantidad*1
                            insertRow()
                        } else {
                            bootbox.alert({
                                        message : msg,
                                        title   : "Error",
                                        class   : "modal-error"
                                    }
                            );
                        }
                    }

                });
                $('#item_txt').typeahead({
                            hint      : true,
                            highlight : true,
                            minLength : 1
                        },
                        {
                            name       : 'states',
                            displayKey : 'value',
                            source     : substringMatcher(items)
                        });

                $(".twitter-typeahead").css({
                    width : "100%"
                })

                $("#guardar").click(function(){
                    if($(".frmNota").valid()){
                        if($(".item-row").size()<1){
                            bootbox.alert({
                                        message : "Primero ingrese un item.",
                                        title   : "Error",
                                        class   : "modal-error"
                                    }
                            );

                        }else{
                            data=""
                            openLoader()
                            $(".item-row").each(function(){
                                var cant = $(this).find(".cantidad").html()
                                var desc = $(this).find(".descripcion").html()
                                var uni = $(this).find(".unidad").attr("iden")
                                data+=desc+"!!"+cant+"!!"+uni+"!!"
                            });

                            $("#data").val(data)
                            $(".frmNota").submit()

                        }
                    }
                });
            });
</script>
</body>
</html>