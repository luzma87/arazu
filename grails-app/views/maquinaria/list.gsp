<%@ page import="arazu.items.Maquinaria" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Maquinaria</title>
    </head>

    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <a href="#" class="btn btn-default btnCrear">
                    <i class="fa fa-file-o"></i> Crear
                </a>
            </div>

            <div class="btn-group pull-right col-md-3">
                <div class="input-group">
                    <input type="text" class="form-control input-search" placeholder="Buscar" value="${params.search}">
                    <span class="input-group-btn">
                        <g:link controller="maquinaria" action="list" class="btn btn-default btn-search">
                            <i class="fa fa-search"></i>&nbsp;
                        </g:link>
                    </span>
                </div><!-- /input-group -->
            </div>
        </div>

        <table class="table table-condensed table-bordered table-striped table-hover">
            <thead>
                <tr>

                    <g:sortableColumn property="descripcion" title="Descripcion"/>

                    <g:sortableColumn property="observaciones" title="Observaciones"/>

                    <th>Tipo</th>

                    <g:sortableColumn property="placa" title="Placa"/>

                    <g:sortableColumn property="marca" title="Marca"/>

                    <g:sortableColumn property="modelo" title="Modelo"/>

                </tr>
            </thead>
            <tbody>
                <g:if test="${maquinariaInstanceCount > 0}">
                    <g:each in="${maquinariaInstanceList}" status="i" var="maquinariaInstance">
                        <tr data-id="${maquinariaInstance.id}">

                            <td>${maquinariaInstance.descripcion}</td>

                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${maquinariaInstance}" field="observaciones"/></elm:textoBusqueda></td>

                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${maquinariaInstance}" field="tipo"/></elm:textoBusqueda></td>

                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${maquinariaInstance}" field="placa"/></elm:textoBusqueda></td>

                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${maquinariaInstance}" field="marca"/></elm:textoBusqueda></td>

                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${maquinariaInstance}" field="modelo"/></elm:textoBusqueda></td>

                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr class="danger">
                        <td class="text-center" colspan="8">
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

        <elm:pagination total="${maquinariaInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            var id = null;
            function submitFormMaquinaria() {
                var $form = $("#frmMaquinaria");
                var $btn = $("#dlgCreateEditMaquinaria").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    openLoader("Guardando Maquinaria");

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
            function deleteMaquinaria(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                            "¿Está seguro que desea eliminar el Maquinaria seleccionado? Esta acción no se puede deshacer.</p>",
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
                                openLoader("Eliminando Maquinaria");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'maquinaria', action:'delete_ajax')}',
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
            function createEditMaquinaria(id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? {id : id} : {};
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'maquinaria', action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        closeLoader();
                        var b = bootbox.dialog({
                            id      : "dlgCreateEditMaquinaria",
                            title   : title + " Maquinaria",
//                            class   : "modal-lg",
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
                                        return submitFormMaquinaria();
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
                    createEditMaquinaria();
                    return false;
                });

                $("tbody>tr").contextMenu({
                    items  : {
                        header   : {
                            label  : "Acciones",
                            header : true
                        },
                        ver      : {
                            label  : "Ver",
                            icon   : "fa fa-search",
                            action : function ($element) {
                                var id = $element.data("id");
                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink(controller:'maquinaria', action:'show_ajax')}",
                                    data    : {
                                        id : id
                                    },
                                    success : function (msg) {
                                        bootbox.dialog({
                                            title : "Ver Maquinaria",

                                            message : msg,
                                            buttons : {
                                                ok : {
                                                    label     : "Aceptar",
                                                    className : "btn-primary",
                                                    callback  : function () {
                                                    }
                                                }
                                            }
                                        });
                                    }
                                });
                            }
                        },
                        editar   : {
                            label  : "Editar",
                            icon   : "fa fa-pencil",
                            action : function ($element) {
                                var id = $element.data("id");
                                createEditMaquinaria(id);
                            }
                        },
                        eliminar : {
                            label            : "Eliminar",
                            icon             : "fa fa-trash-o",
                            separator_before : true,
                            action           : function ($element) {
                                var id = $element.data("id");
                                deleteMaquinaria(id);
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
