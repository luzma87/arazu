<%@ page import="arazu.parametros.Cargo" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Cargo</title>
    </head>

    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link class="btn btn-default" controller="inicio" action="parametros">
                    <i class="fa fa-cogs"></i> Parámetros
                </g:link>
                <a href="#" class="btn btn-default btnCrear">
                    <i class="fa fa-file-o"></i> Crear
                </a>
            </div>

            <div class="btn-group pull-right col-md-3 col-sm-4">
                <div class="input-group">
                    <input type="text" class="form-control input-search" placeholder="Buscar" value="${params.search}">
                    <span class="input-group-btn">
                        <g:link controller="cargo" action="list" class="btn btn-default btn-search">
                            <i class="fa fa-search"></i>&nbsp;
                        </g:link>
                    </span>
                </div><!-- /input-group -->
            </div>
        </div>

        <table class="table table-condensed table-bordered table-striped table-hover">
            <thead>
                <tr>

                    <g:sortableColumn property="codigo" title="Código"/>

                    <g:sortableColumn property="descripcion" title="Descripción"/>

                </tr>
            </thead>
            <tbody>
                <g:if test="${cargoInstanceCount > 0}">
                    <g:each in="${cargoInstanceList}" status="i" var="cargoInstance">
                        <tr data-id="${cargoInstance.id}">

                            <td>
                                <elm:textoBusqueda busca="${params.search}">
                                    <g:fieldValue bean="${cargoInstance}" field="codigo"/>
                                </elm:textoBusqueda>
                            </td>

                            <td>
                                <elm:textoBusqueda busca="${params.search}">
                                    ${cargoInstance.descripcion}
                                </elm:textoBusqueda>
                            </td>

                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr class="danger">
                        <td class="text-center" colspan="2">
                            <g:if test="${params.search && params.search != ''}">
                                No se encontraron resultados para su búsqueda
                            </g:if>
                            <g:else>
                                No se encontraron registros que mostrar
                            </g:else>
                        </td>
                    </tr>
                </g:else>
            </tbody>
        </table>

        <elm:pagination total="${cargoInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            var id = null;
            function submitFormCargo() {
                var $form = $("#frmCargo");
                var $btn = $("#dlgCreateEditCargo").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    openLoader("Guardando Cargo");
                    $.ajax({
                        type    : "POST",
                        url     : $form.attr("action"),
                        data    : $form.serialize(),
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            setTimeout(function () {
                                if (parts[0] == "SUCCESS") {
                                    location.reload(true);
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
            function deleteCargo(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                              "¿Está seguro que desea eliminar el Cargo seleccionado? Esta acción no se puede deshacer.</p>",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        eliminar : {
                            label     : "<i class='fa fa-trash-o'></i> Eliminar",
                            className : "btn-danger",
                            callback  : function () {
                                openLoader("Eliminando Cargo");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'cargo', action:'delete_ajax')}',
                                    data    : {
                                        id : itemId
                                    },
                                    success : function (msg) {
                                        var parts = msg.split("*");
                                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                        if (parts[0] == "SUCCESS") {
                                            setTimeout(function () {
                                                location.reload(true);
                                            }, 1000);
                                        } else {
                                            closeLoader();
                                        }
                                    },
                                    error   : function () {
                                        log("Ha ocurrido un error interno", "Error");
                                        closeLoader();
                                    }
                                });
                            }
                        }
                    }
                });
            }
            function createEditCargo(id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? {id : id} : {};
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'cargo', action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id    : "dlgCreateEditCargo",
                            title : title + " Cargo",

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
                                        return submitFormCargo();
                                    } //callback
                                } //guardar
                            } //buttons
                        }); //dialog
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            } //createEdit

            $(function () {

                $(".btnCrear").click(function () {
                    createEditCargo();
                    return false;
                });

                $("tbody>tr").contextMenu({
                    items  : {
                        header : {
                            label  : "Acciones",
                            header : true
                        },
                        %{--ver      : {--}%
                        %{--label  : "Ver",--}%
                        %{--icon   : "fa fa-search",--}%
                        %{--action : function ($element) {--}%
                        %{--var id = $element.data("id");--}%
                        %{--$.ajax({--}%
                        %{--type    : "POST",--}%
                        %{--url     : "${createLink(controller:'cargo', action:'show_ajax')}",--}%
                        %{--data    : {--}%
                        %{--id : id--}%
                        %{--},--}%
                        %{--success : function (msg) {--}%
                        %{--bootbox.dialog({--}%
                        %{--title : "Ver Cargo",--}%

                        %{--message : msg,--}%
                        %{--buttons : {--}%
                        %{--ok : {--}%
                        %{--label     : "Aceptar",--}%
                        %{--className : "btn-primary",--}%
                        %{--callback  : function () {--}%
                        %{--}--}%
                        %{--}--}%
                        %{--}--}%
                        %{--});--}%
                        %{--}--}%
                        %{--});--}%
                        %{--}--}%
                        %{--},--}%
                        editar   : {
                            label  : "Editar",
                            icon   : "fa fa-pencil",
                            action : function ($element) {
                                var id = $element.data("id");
                                createEditCargo(id);
                            }
                        },
                        eliminar : {
                            label            : "Eliminar",
                            icon             : "fa fa-trash-o",
                            separator_before : true,
                            action           : function ($element) {
                                var id = $element.data("id");
                                deleteCargo(id);
                            }
                        }
                    },
                    onShow : function ($element) {
                        $element.addClass("success");
                    },
                    onHide : function ($element) {
                        $(".success").removeClass("success");
                    }
                });
            });
        </script>

    </body>
</html>
