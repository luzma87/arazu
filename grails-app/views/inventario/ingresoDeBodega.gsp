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
        <elm:fieldRapido label="Fecha" claseLabel="col-md-1">
            ${new Date().format("dd-MM-yyyy hh:mm:ss")}
        </elm:fieldRapido>
    </div>
    <div class="row">
        <elm:fieldRapido label="Bodega" claseLabel="col-md-1">
            <g:select name="bodega.id" from="${bodegas}" class="form-control input-sm"></g:select>
        </elm:fieldRapido>
    </div>
    <div class="row" style="margin-bottom: 10px">
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
        <div class="col-md-1">
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
                <span class="input-group-addon svt-bg-info">#</span>
            </div>
        </div>
        <div class="col-md-1">
            <label class=" control-label">
                V. Unitario
            </label>
        </div>
        <div class="col-md-2">
            <div class="input-group">
                <input type="text" class="form-control input-sm money number" id="valor" style="text-align: right" placeholder="0.00">
                <span class="input-group-addon svt-bg-info"><i class="fa fa-usd"></i></span>
            </div>
        </div>
        <div class="col-md-1">
            <a href="#" id="agregar" title="Agregar" class="btn btn-success btn-sm">
                <i class="fa fa-plus"></i>
            </a>
        </div>
    </div>
</elm:container>
<elm:container tipo="vertical" titulo="Detalle" style="min-height: 200px">
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th>Cantidad</th>
            <th>Unidad</th>
            <th>Descripción</th>
            <th>V. Unitario</th>
            <th>V. Total</th>
        </tr>
        </thead>
        <tbody id="tabla-items">

        </tbody>
        <tfoot>
        <tr>
            <th colspan="4">Total</th>
            <td id="total" style="text-align: right"></td>
        </tr>
        </tfoot>
    </table>
</elm:container>
<script type="text/javascript">
    var id = null;
    function submitFormItem() {
        var $form = $("#frmItem");
        var $btn = $("#dlgCreateEditItem").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Guardando Item");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("*");
                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                    setTimeout(function() {
                        if (parts[0] == "SUCCESS") {
                            location.reload(true);
                        } else {
                            spinner.replaceWith($btn);
                            closeLoader();
                            return false;
                        }
                    }, 1000);
                },
                error: function() {
                    log("Ha ocurrido un error interno", "Error");
                    closeLoader();
                }
            });
        } else {
            return false;
        } //else
    }
    function createEditItem(id,msn,item) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'item', action:'form_ajax')}?msg="+msn,
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditItem",
                    title   : title + " Item",

                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormItem();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                closeLoader()
                $("#descripcion").val(item)
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit
    var substringMatcher = function(strs) {
        return function findMatches(q, cb) {
            var matches, substrRegex;

            // an array that will be populated with substring matches
            matches = [];

            // regex used to determine if a string contains the substring `q`
            substrRegex = new RegExp(q, 'i');

            // iterate through the pool of strings and for any string that
            // contains the substring `q`, add it to the `matches` array
            $.each(strs, function(i, str) {
                if (substrRegex.test(str)) {
                    // the typeahead jQuery plugin expects suggestions to a
                    // JavaScript object, refer to typeahead docs for more info
                    matches.push({ value: str });
                }
            });

            cb(matches);
        };
    };
    var items = ${items}
            $(function(){
                $("#agregar").click(function(){
                    var item = $.trim($("#item_txt").val().toUpperCase())
                    var cantidad = $("#cantidad").val()
                    var valor = $("#valor").val()
                    var unidad = $("#unidad").find("option:selected").text()
                    var unidadId = $("#unidad").val()
                    var msg = ""
                    var nuevo = false
                    if(item==""){
                        msg+="Por favor ingrese un Item."
                    }else{
                        if($.inArray(item, items))
                            nuevo = true
                    }
                    if(cantidad*1<1){
                        msg+="<br>La cantidad debe ser mayor a cero."
                    }
                    if(isNaN(valor))
                        msg+="<br>Por favor ingrese el valor unitario."
                    else
                    if(valor<1){
                        msg+="<br>El valor unitario debe ser mayor a cero."
                    }


                    if(msg==""){
                        if(nuevo){
                            openLoader()
                            msg="El item "+item+" no está registrado en el sistema, si desea crear un item nuevo llene los siguientes datos."
                            createEditItem(null,msg,item);

                        }

                    }else{
                        bootbox.alert({
                                    message: msg,
                                    title :"Error",
                                    class : "modal-error"
                                }
                        );
                    }

                });
                $('#item_txt').typeahead({
                            hint: true,
                            highlight: true,
                            minLength: 1
                        },
                        {
                            name: 'states',
                            displayKey: 'value',
                            source: substringMatcher(items)
                        });

                $(".twitter-typeahead").css({
                    width:"100%"
                })
            });

</script>
</body>
</html>