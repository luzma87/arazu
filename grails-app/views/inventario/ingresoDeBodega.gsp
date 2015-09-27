<%@ page import="arazu.items.Item; arazu.parametros.Unidad" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Ingreso a bodega</title>
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

        .numero {
            text-align : right;
        }

        .unidad {
            text-align : center;
            width      : 80px;
        }

        .cantidad {
            text-align : center;
            width      : 80px;
        }
        </style>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link controller="bodega" action="list" class="btn btn-default btnCrear">
                    <i class="fa fa-list"></i> Bodegas
                </g:link>
            </div>

            <g:if test="${bodega}">
                <div class="btn-group">
                    <g:link controller="inventario" action="inventario" id="${bodega.id}" class="btn btn-default btnCrear">
                        <i class="fa fa-shopping-cart"></i> Inventario de bodega
                    </g:link>
                </div>
            </g:if>
        </div>

        <elm:container tipo="horizontal" titulo="Ingreso a ${bodega ? 'la bodega ' + bodega : 'bodega'}">
            <div class="row">
                <div class="col-md-1">
                    <label class=" control-label">
                        Bodega
                    </label>
                </div>

                <div class="col-md-3">
                    <g:select name="bodega.id" from="${bodegas}" class="form-control input-sm" id="bodega" optionKey="id"/>
                </div>

                <div class="col-md-1">
                    <label class=" control-label">
                        Fecha
                    </label>
                </div>

                <div class="col-md-3">
                    ${new Date().format("dd-MM-yyyy hh:mm:ss")}
                </div>

                <div class="col-md-1">
                    <label class=" control-label">
                        Responsable
                    </label>
                </div>

                <div class="col-md-3">
                    ${session.usuario}
                </div>
            </div>


            <div class="row" style="margin-bottom: 10px;">
                <div class="col-md-1">
                    <label class=" control-label">
                        Ítem
                    </label>
                </div>

                <div class="col-md-3">
                    %{--<input type="text" class="form-control input-sm allCaps" id="item_txt" placeholder="Item" --}%
                    %{--style="width: 100%!important;">--}%
                    <g:select name="item_txt" from="${Item.list([sort: 'descripcion'])}" optionKey="id"
                              optionValue="${{ it.descripcion.decodeHTML() }}" data-width="219px"
                              class="form-control input-sm required select" noSelection="['': '-- Seleccione --']"
                              data-live-search="true"/>

                    <a href="#" id="btnAddItem" class="btn btn-success" title="Crear nuevo ítem" style="margin-top: 3px;">
                        <i class="fa fa-plus"></i>
                    </a>
                </div>

                <div class="col-md-1">
                    <label class=" control-label">
                        Unidad
                    </label>
                </div>

                <div class="col-md-1">
                    <g:select name="unidad.id" id="unidad" from="${Unidad.list()}" optionKey="id" class="form-control input-sm"/>
                </div>

                <div class="col-md-1">
                    <label class=" control-label">
                        Cantidad
                    </label>
                </div>

                <div class="col-md-1">
                    <div class="input-group">
                        <input type="text" class="form-control input-sm digits" id="cantidad" style="text-align: right" value="1"
                               autocomplete="off">
                        <span class="input-group-addon svt-bg-warning">#</span>
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
                        <span class="input-group-addon svt-bg-warning"><i class="fa fa-usd"></i></span>
                    </div>
                </div>

                <div class="col-md-1">
                    <a href="#" id="agregar" title="Agregar" class="btn btn-success btn-sm">
                        <i class="fa fa-plus"></i>
                    </a>
                </div>
            </div>
        </elm:container>
        <elm:container tipo="horizontal" titulo="" style="max-height: 300px;overflow-y: auto;margin-top: 10px">
            <table class="table table-striped table-hover table-bordered" style="margin-top: 10px">
                <thead>
                    <tr>
                        <th style="width: 80px">Cantidad</th>
                        <th style="width: 80px">Unidad</th>
                        <th>Descripción</th>
                        <th style="width: 100px">V. Unitario</th>
                        <th style="width: 100px">V. Total</th>
                        <th style="width: 50px"></th>
                    </tr>
                </thead>
                <tbody id="tabla-items">

                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="4">Total</th>
                        <td id="total" style="text-align: right;font-weight: bold"></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
        </elm:container>
        <div class="row">
            <div class="col-md-1">
                <a href="#" class="btn btn-primary" id="guardar"><i class="fa fa-save"></i> Guardar</a>
            </div>
        </div>
        <script type="text/javascript">
            var item;
            var itemId;
            var cantidad;
            var valor;
            var unidad;
            var unidadId;
            var id = null;
            var total = 0;
            var max = 5;
            var data = "";
            function reset() {
                $("#item_txt").val("");
                $("#cantidad").val("1");
                $("#valor").val("");
                unidad = null;
                unidadId = null;
                cantidad = null;
                valor = null;
            }
            function calculaTotal() {
                total = 0;
                $(".item-row").each(function () {

                    var val = $(this).find(".total").html();
                    val = str_replace(",", "", val);

                    total += val * 1;
                });
                $("#total").html(number_format(total, 2, ".", ","))
            }
            function insertRow() {
                var tr = $("<tr class='item-row'>");
                tr.append("<td class='cantidad'>" + cantidad + "</td>");
                tr.append("<td class='unidad' iden='" + unidadId + "'>" + unidad + "</td>");
                tr.append("<td class='descripcion'>" + item + "</td>");
                tr.append("<td class='unitario numero'>" + number_format(valor, 2, ".", ",") + "</td>");
                tr.append("<td class='total numero'>" + number_format(valor * cantidad, 2, ".", ",") + "</td>");
                var boton = $("<a href='#' title='Borrar' class='btn-borrar btn btn-danger btn-sm'><i class='fa fa-trash-o'></i></a>");

                tr.data("id", itemId);

                boton.click(function () {
                    $(this).parent().parent().remove();
                    calculaTotal();
                });
                var td = $("<td></td>");
                td.append(boton);
                tr.append(td);
                $("#tabla-items").append(tr);
                reset();
                calculaTotal();
            }
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
                            setTimeout(function () {
                                if (parts[0] == "SUCCESS") {
                                    closeLoader();
                                    $("#dlgCreateEditItem").modal("hide");
                                    reloadItemList(parts[2]);
                                } else {
                                    spinner.replaceWith($btn);
                                    closeLoader();
                                    return false;
                                }
                            }, 1000);
                        },
                        error   : function () {
                            log("Ha ocurrido un error interno", "Error");
                            closeLoader();
                        }
                    });
                } else {
                    return false;
                } //else
            }
            function reloadItemList(newItemId) {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'item', action:'reloadItemList_ajax')}",
                    data    : {
                        id : newItemId
                    },
                    success : function (msg) {
                        $("#item_txt").next().remove();
                        $("#item_txt").replaceWith(msg);
                    } //success
                }); //ajax
            }
            function createEditItem(id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? {id : id} : {};
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'item', action:'form_ajax')}",
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
                        closeLoader();
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            } //createEdit
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
            %{--var items = ${items};--}%

            $(function () {
                $("#btnAddItem").click(function () {
                    createEditItem(null, "");
                    return false;
                });

                $("#agregar").click(function () {
                    if ($(".item-row").size() > max) {
                        bootbox.alert({
                                    message : "Solo puede registrar un item por orden de ingreso",
                                    title   : "Error",
                                    class   : "modal-error"
                                }
                        );
                    } else {
                        itemId = $("#item_txt").val();
                        item = $("#item_txt").find("option:selected").text();
                        cantidad = $("#cantidad").val();
                        valor = $("#valor").val();
                        valor = str_replace(",", "", valor);
                        unidad = $("#unidad").find("option:selected").text();
                        unidadId = $("#unidad").val();
                        var msg = "";
                        var nuevo = false;
//                                if (item == "") {
//                                    msg += "Por favor ingrese un Item."
//                                } else {
//                                    //console.log($.inArray(item, items))
////                                    if ($.inArray(item, items) < 0)
////                                        nuevo = true
//                                }
                        if (cantidad * 1 < 1) {
                            msg += "<br>La cantidad debe ser mayor a cero.";
                        }
                        if (isNaN(valor))
                            msg += "<br>Por favor ingrese el valor unitario.";
//                                else if (valor * 1 < 1) {
//                                    msg += "<br>El valor unitario debe ser mayor a cero.";
//                                }
                        if (msg == "") {
                            valor = valor * 1;
                            cantidad = cantidad * 1;
                            if (nuevo) {
                                openLoader();
                                msg = "El item " + item + " no está registrado en el sistema, si desea crear un item nuevo llene los siguientes datos.";
                                createEditItem(null, msg, item);
                            } else {
                                insertRow();
                            }
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

                $("#guardar").click(function () {
                    if ($(".item-row").size() < 1) {
                        bootbox.alert({
                                    message : "Primero ingrese uno o más items.",
                                    title   : "Error",
                                    class   : "modal-error"
                                }
                        );
                    } else {
                        data = "";
                        openLoader();
                        $(".item-row").each(function () {
                            var id = $(this).data("id");
                            var cant = $(this).find(".cantidad").html();
                            var desc = $(this).find(".descripcion").html();
                            var unitario = $(this).find(".unitario").html();
                            unitario = val = str_replace(",", "", unitario);
                            var uni = $(this).find(".unidad").attr("iden");
                            data += id + "!!" + cant + "!!" + uni + "!!" + unitario + "||"
                        });

                        $.ajax({
                            type    : "POST",
                            url     : "${g.createLink(controller: 'inventario',action: 'saveIngreso_ajax')}",
                            data    : "bodega=" + $("#bodega").val() + "&data=" + data,
                            success : function (msg) {
                                var parts = msg.split("*");
                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "SUCCESS") {
                                    location.href = "${g.createLink(action: 'inventario')}?id=" + $("#bodega").val()
                                } else {
                                    closeLoader();
                                }
                            },
                            error   : function () {
                                log("Ha ocurrido un error interno", "error");
                                closeLoader();
                            }
                        });
                    }
                });
            });

        </script>
    </body>
</html>