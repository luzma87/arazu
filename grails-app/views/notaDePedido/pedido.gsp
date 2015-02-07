<%@ page import="arazu.parametros.TipoMaquinaria; arazu.parametros.Unidad; arazu.proyectos.Proyecto; arazu.seguridad.Persona; arazu.parametros.TipoSolicitud; arazu.items.Maquinaria; arazu.parametros.TipoUsuario" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Nota de pedido</title>

        <imp:js src="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/js', file: 'bootstrap-select.min.js')}"/>
        <imp:js src="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/js/i18n', file: 'defaults-es_CL.js')}"/>

        <imp:css src="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/css', file: 'bootstrap-select.min.css')}"/>

        <style type="text/css">
        .tt-dropdown-menu {
            width                 : 890px;
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
        <g:form class="frmNota" action="saveSolicitud">
            <elm:container tipo="horizontal" titulo="Nueva nota de pedido">
                <input type="hidden" name="data" id="data">

                <g:hiddenField name="maquinaria.id" id="maquina"/>

                <div class="row">
                    <div class="col-md-1">
                        <label class=" control-label">
                            Equipo
                        </label>
                    </div>

                    <div class="col-md-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="maquina_input" readonly/>
                            <span class="input-group-addon svt-bg-warning">
                                <i class="fa fa-keyboard-o"></i>
                            </span>
                        </div><!-- /input-group -->
                    </div>
                </div>

                <div class="hidden toggle">
                    <div class="row">
                        <div class="col-md-1">
                            <label class=" control-label">
                                Motivo
                            </label>
                        </div>

                        <div class="col-md-2">
                            <g:select name="tipoSolicitud.id" from="${TipoSolicitud.list()}" optionKey="id" optionValue="descripcion"
                                      class="form-control input-sm required select"/>
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
                            <g:select name="para.id" from="${Persona.list([sort: 'apellido'])}" optionKey="id"
                                      class="form-control input-sm required select" noSelection="['': 'Seleccione...']"/>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-1">
                            <label class=" control-label">
                                Proyecto
                            </label>
                        </div>

                        <div class="col-md-2">
                            <g:select name="proyecto.id" from="${Proyecto.list()}" optionKey="id" optionValue="descripcion"
                                      class="form-control input-sm required select" noSelection="['': 'Seleccione...']"/>
                        </div>

                        %{--<div class="col-md-1">--}%
                        %{--<label class=" control-label">--}%
                        %{--Equipo--}%
                        %{--</label>--}%
                        %{--</div>--}%

                        %{--<div class="col-md-2">--}%
                        %{--<g:select name="maquinaria.id" id="maquinaria" from="${Maquinaria.list([sort: 'descripcion'])}" optionKey="id"--}%
                        %{--class="form-control input-sm required" noSelection="['': 'Seleccione...']"--}%
                        %{--data-live-search="true"/>--}%
                        %{--<select name="maquinaria.id" id="maquinaria" class="form-control input-sm required" data-live-search="true">--}%
                        %{--<option value="">-- Seleccione --</option>--}%
                        %{--<g:each in="${TipoMaquinaria.list([sort: 'nombre'])}" var="tm">--}%
                        %{--<g:set var="maquinas" value="${Maquinaria.findAllByTipo(tm)}"/>--}%
                        %{--<g:if test="${maquinas.size() > 0}">--}%
                        %{--<optgroup label="${tm.toString()}">--}%
                        %{--<g:each in="${maquinas+maquinas+maquinas+maquinas+maquinas}" var="m">--}%
                        %{--<option value="${m.id}">${m.toString()}</option>--}%
                        %{--</g:each>--}%
                        %{--</optgroup>--}%
                        %{--</g:if>--}%
                        %{--</g:each>--}%
                        %{--</select>--}%
                        %{--</div>--}%
                    </div>

                    <div class="row" style="margin-bottom: 10px">

                    </div>
                </div>
            </elm:container>

            <div class="hidden toggle">
                <table class="table table-striped table-hover table-bordered" style="margin-top: 10px">
                    <thead>
                        <tr>
                            <th style="width: 80px">Cantidad</th>
                            <th style="width: 150px">Unidad</th>
                            <th>Descripción</th>
                        </tr>
                    </thead>
                    <tbody id="tabla-items">
                        <tr>
                            <td>
                                <div class="input-group">
                                    <input type="text" class="form-control input-sm digits required" id="cantidad" style="text-align: right" value="1" name="cantidad">
                                    <span class="input-group-addon svt-bg-warning">#</span>
                                </div>
                            </td>
                            <td>
                                <g:select name="unidad.id" id="unidad" from="${Unidad.list()}" optionKey="id"
                                          class="form-control input-sm required" noSelection="['': 'Seleccione...']"/>
                            </td>
                            <td>
                                <input type="text" name="item" class="form-control input-sm allCaps required" id="item_txt" placeholder="Item" style="width: 100%!important;">
                            </td>

                        </tr>
                    </tbody>

                </table>

                <div class="row" style="margin-top: 20px">
                    <div class="col-md-1">
                        <a href="#" class="btn btn-primary" id="guardar"><i class="fa fa-save"></i> Guardar</a>
                    </div>
                </div>
            </div>

        </g:form>
        <script type="text/javascript">

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
            var items = ${items};
            $(function () {
                $("#maquina_input").click(function () {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'maquinaria', action:'list_ajax')}",
                        success : function (msg) {
                            closeLoader();
                            var b = bootbox.dialog({
                                id      : "dlgFindMaquinaria",
                                title   : "Buscar Maquinaria",
//                            class   : "modal-lg",
                                message : msg,
                                buttons : {
                                    cancelar : {
                                        label     : "Cerrar",
                                        className : "btn-primary",
                                        callback  : function () {
                                        }
                                    }
                                } //buttons
                            }); //dialog
                            setTimeout(function () {
                                b.find(".form-control").first().focus()
                            }, 500);
                        } //success
                    }); //ajax
                    return false;
                });

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
                });

                $("#guardar").click(function () {
                    $(".frmNota").submit();
                });

                //                $('.select').selectpicker({
                //
                //                });
                //                $('#maquinaria').selectpicker({
                //
                //                });
            })
            ;

        </script>
    </body>
</html>