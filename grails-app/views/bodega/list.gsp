<%@ page import="arazu.inventario.Bodega" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Bodegas</title>
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

            <div class="btn-group pull-right col-md-3 col-sm-4">
                <div class="input-group">
                    <input type="text" class="form-control input-search" placeholder="Buscar" value="${params.search}">
                    <span class="input-group-btn">
                        <g:link controller="bodega" action="list" class="btn btn-default btn-search">
                            <i class="fa fa-search"></i>&nbsp;
                        </g:link>
                    </span>
                </div><!-- /input-group -->
            </div>
        </div>

        <table class="table table-condensed table-bordered table-striped table-hover">
            <thead>
                <tr>

                    <g:sortableColumn property="descripcion" title="Descripción"/>

                    <g:sortableColumn property="observaciones" title="Observaciones" style="width:450px;"/>

                    <g:sortableColumn property="proyecto" title="Proyecto"/>

                    <g:sortableColumn property="persona" title="Responsables"/>

                    <g:sortableColumn property="activo" title="Activa"/>

                </tr>
            </thead>
            <tbody>
                <g:if test="${bodegaInstanceCount > 0}">
                    <g:each in="${bodegaInstanceList}" status="i" var="bodegaInstance">
                        <tr data-id="${bodegaInstance.id}">

                            <td>
                                <elm:textoBusqueda busca="${params.search}">
                                    ${bodegaInstance.descripcion}
                                </elm:textoBusqueda>
                            </td>

                            <td>
                                <elm:textoBusqueda busca="${params.search}">
                                    ${bodegaInstance.observaciones?.size() > 200 ? bodegaInstance.observaciones[0..197] + "..." : bodegaInstance.observaciones}
                                </elm:textoBusqueda>
                            </td>

                            <td>
                                <elm:textoBusqueda busca="${params.search}">
                                    <g:fieldValue bean="${bodegaInstance}" field="proyecto"/>
                                </elm:textoBusqueda>
                            </td>

                            <td>
                                <elm:textoBusqueda busca="${params.search}">
                                    <strong><g:fieldValue bean="${bodegaInstance}" field="responsable"/></strong>
                                    <g:if test="${bodegaInstance.suplente}">
                                        , <g:fieldValue bean="${bodegaInstance}" field="suplente"/>
                                    </g:if>
                                </elm:textoBusqueda>
                            </td>

                            <td><g:formatBoolean boolean="${bodegaInstance.activo == 1}" true="Sí" false="No"/></td>

                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr class="danger">
                        <td class="text-center" colspan="5">
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

        <elm:pagination total="${bodegaInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            var id = null;
            function submitFormBodega() {
                var $form = $("#frmBodega");
                var $btn = $("#dlgCreateEditBodega").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    openLoader("Guardando Bodega");
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
            function deleteBodega(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                              "¿Está seguro que desea eliminar el Bodega seleccionado? Esta acción no se puede deshacer.</p>",
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
                                openLoader("Eliminando Bodega");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'bodega', action:'delete_ajax')}',
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
            function createEditBodega(id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? {id : id} : {};
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'bodega', action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        closeLoader();
                        var b = bootbox.dialog({
                            id    : "dlgCreateEditBodega",
                            title : title + " Bodega",

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
                                        return submitFormBodega();
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

            function createContextMenu(node) {
                var $tr = $(node);

                var items = {
                    header     : {
                        label  : "Acciones",
                        header : true
                    },
                    ver        : {
                        label  : "Ver",
                        icon   : "fa fa-search",
                        action : function ($element) {
                            var id = $element.data("id");
                            $.ajax({
                                type    : "POST",
                                url     : "${createLink(controller:'bodega', action:'show_ajax')}",
                                data    : {
                                    id : id
                                },
                                success : function (msg) {
                                    bootbox.dialog({
                                        title : "Ver Bodega",

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
                    editar     : {
                        label  : "Editar",
                        icon   : "fa fa-pencil",
                        action : function ($element) {
                            var id = $element.data("id");
                            createEditBodega(id);
                        }
                    },
                    inventario : {
                        label            : "Inventario",
                        icon             : " fa fa-shopping-cart",
                        separator_bedore : true,
                        action           : function ($element) {
                            var id = $element.data("id");
                            location.href = "${createLink(controller: 'inventario', action:'inventario')}/" + id;
                        }
                    },
                    desechos : {
                        label            : "Inventario de desechos",
                        icon             : " fa fa-trash-o",
                        separator_bedore : true,
                        action           : function ($element) {
                            var id = $element.data("id");
                            location.href = "${createLink(controller: 'inventario', action:'inventarioDesecho')}/" + id;
                        }
                    },
                    ingreso    : {
                        label  : "Nuevo ingreso a bodega",
                        icon   : "fa fa-cart-arrow-down",
                        action : function ($element) {
                            var id = $element.data("id");
                            location.href = "${createLink(controller: 'inventario', action: 'ingresoDeBodega')}?bodega=" + id;
                        }
                    },
                    egreso    : {
                        label  : "Nuevo egreso de bodega",
                        icon   : "fa fa-upload",
                        action : function ($element) {
                            var id = $element.data("id");
                            location.href = "${createLink(controller: 'inventario', action: 'egresoDeBodega')}?bodega=" + id;
                        }
                    }

//                    eliminar : {
//                        label            : "Eliminar",
//                        icon             : "fa fa-trash-o",
//                        separator_before : true,
//                        action           : function ($element) {
//                            var id = $element.data("id");
//                            deleteBodega(id);
//                        }
//                    }
                };

                return items;
            }

            $(function () {

                $(".btnCrear").click(function () {
                    createEditBodega();
                    return false;
                });

                $("tbody>tr").contextMenu({
                    items  : createContextMenu,
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
