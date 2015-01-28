<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 23/01/2015
  Time: 17:44
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Items</title>

        <script src="${resource(dir: 'js/plugins/jstree-3.0.9/dist', file: 'jstree.min.js')}"></script>
        <link href="${resource(dir: 'js/plugins/jstree-3.0.9/dist/themes/default', file: 'style.min.css')}" rel="stylesheet">
        <link href="${resource(dir: 'css/custom', file: 'jstree-context.css')}" rel="stylesheet">

        <style type="text/css">
        #tree {
            overflow-y : auto;
            height     : 440px;
        }

        .jstree-search {
            color : #5F87B2 !important;
        }
        </style>
    </head>

    <body>

        <div class="row" style="margin-bottom: 10px;">
            <div class="col-md-2">
                <div class="input-group input-group-sm">
                    <g:textField name="searchArbol" class="form-control input-sm" placeholder="Buscador"/>
                    <span class="input-group-btn">
                        <a href="#" id="btnSearchArbol" class="btn btn-sm btn-info">
                            <i class="fa fa-search"></i>
                        </a>
                    </span>
                </div><!-- /input-group -->
            </div>

            <div class="col-md-3 hidden" id="divSearchRes">
                <span id="spanSearchRes">
                    5 resultados
                </span>

                <div class="btn-group">
                    <a href="#" class="btn btn-xs btn-default" id="btnNextSearch" title="Siguiente">
                        <i class="fa fa-chevron-down"></i>
                    </a>
                    <a href="#" class="btn btn-xs btn-default" id="btnPrevSearch" title="Anterior">
                        <i class="fa fa-chevron-up"></i>
                    </a>
                    <a href="#" class="btn btn-xs btn-default" id="btnClearSearch" title="Limpiar búsqueda">
                        <i class="fa fa-close"></i>
                    </a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="btn-group">
                    <a href="#" class="btn btn-xs btn-default" id="btnCollapseAll" title="Cerrar todos los nodos">
                        <i class="fa fa-minus-square-o"></i>
                    </a>
                    <a href="#" class="btn btn-xs btn-default" id="btnExpandAll" title="Abrir todos los nodos">
                        <i class="fa fa-plus-square"></i>
                    </a>
                </div>
            </div>
        </div>

        <div id="tree" class="well">
            ${raw(arbol)}
        </div>

        <script type="text/javascript">
            var searchRes = [];
            var posSearchShow = 0;
            var $treeContainer = $("#tree");

            function createContextMenu(node) {
                var nodeStrId = node.id;
                var $node = $("#" + nodeStrId);
                var nodeId = nodeStrId.split("_")[1];
                var nodeType = $node.data("jstree").type;

                var nodeText = $node.children("a").first().text();

                var cantHijos = parseInt($node.data("hijos"));

                var esRoot = nodeType == "root";
                var esTipoItem = nodeType == "tipoItem";
                var esItem = nodeType == "item";
                var esBodega = nodeType == "bodega";

                var crearTipoItem = {
                    label  : "Nuevo Tipo de Item",
                    icon   : "fa flaticon-toolbox3 text-success",
                    action : function () {
                        createEditTipoItem();
                    }
                };
                var verTipoItem = {
                    label  : "Ver Tipo de Item",
                    icon   : "fa fa-search",
                    action : function () {
                        showTipoItem(nodeId);
                    }
                };
                var editarTipoItem = {
                    label  : "Modificar Tipo de Item",
                    icon   : "fa fa-pencil text-info",
                    action : function () {
                        createEditTipoItem(nodeId);
                    }
                };
                var crearItem = {
                    label            : "Nuevo Item",
                    icon             : "fa flaticon-power30 text-success",
                    separator_before : true,
                    action           : function () {
                        createEditItem(nodeId);
                    }
                };
                var editarItem = {
                    label            : "Modificar Item",
                    icon             : "fa fa-pencil text-info",
                    separator_before : true,
                    action           : function () {
                        createEditItem(null, nodeId);
                    }
                };
                var verItem = {
                    label            : "Ver Item",
                    icon             : "fa fa-search",
                    separator_before : true,
                    action           : function () {
                        showItem(nodeId);
                    }
                };
                var verDetalles = {
                    label            : "Ver Detalles",
                    icon             : "fa fa-list-ol",
                    separator_before : true,
                    action           : function () {
                        //bodega-item-unidad
                        var parts = nodeId.split("-");
                        if (parts.length == 3) {
                            verDetallesBodega(parts[0], parts[1], parts[2]);
                        }
                    }
                };

                var items = {};

                if (esRoot) {
                    items.crearTipoItem = crearTipoItem;
                } else if (esTipoItem) {
                    items.verTipoItem = verTipoItem;
                    items.editarTipoItem = editarTipoItem;
                    items.crearItem = crearItem;
                } else if (esItem) {
                    items.verItem = verItem;
                    items.editarItem = editarItem;
                } else if (esBodega) {
                    items.verDetalles = verDetalles;
                }

                return items;
            }

            function scrollToNode($scrollTo) {
                $treeContainer.jstree("deselect_all").jstree("select_node", $scrollTo).animate({
                    scrollTop : $scrollTo.offset().top - $treeContainer.offset().top + $treeContainer.scrollTop() - 50
                });
            }
            function scrollToRoot() {
                var $scrollTo = $("#root");
                scrollToNode($scrollTo);
            }
            function scrollToSearchRes() {
                var $scrollTo = $(searchRes[posSearchShow]).parents("li").first();
                $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + searchRes.length);
                scrollToNode($scrollTo);
            }

            function submitFormTipoItem() {
                var $form = $("#frmTipoItem");
                var $btn = $("#dlgcreateEditTipoItem").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    openLoader("Guardando tipo de Item");
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
            function deletetipoItem(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                            "¿Está seguro que desea eliminar el tipo de Item seleccionado? Esta acción no se puede deshacer.</p>",
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
                                openLoader("Eliminando tipo de Item");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'tipoItem', action:'delete_ajax')}',
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
            function createEditTipoItem(id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? {id : id} : {};
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'tipoItem', action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id    : "dlgcreateEditTipoItem",
                            title : title + " Tipos de Items",

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
                                        return submitFormTipoItem();
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
            function showTipoItem(id) {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'tipoItem', action:'show_ajax')}",
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title : "Ver tipo de Item",

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
            function deleteItem(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                            "¿Está seguro que desea eliminar el Item seleccionado? Esta acción no se puede deshacer.</p>",
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
                                openLoader("Eliminando Item");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'item', action:'delete_ajax')}',
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
            function createEditItem(padreId, id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? {id : id} : {};
                if (padreId) {
                    data.padre = padreId;
                }
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'item', action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id    : "dlgCreateEditItem",
                            title : title + " Item",

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
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            } //createEdit
            function showItem(id) {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'item', action:'show_ajax')}",
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title : "Ver Item",

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

            function verDetallesBodega(bodega, item, unidad) {
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'bodega', action:'verDetalles_ajax')}",
                    data    : {
                        bodega : bodega,
                        item   : item,
                        unidad : unidad
                    },
                    success : function (msg) {
                        closeLoader();
                        bootbox.dialog({
                            title : "Ver Item",
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

            $(function () {

                $treeContainer.on("loaded.jstree", function () {
                    $("#loading").hide();
                    $("#tree").removeClass("hidden");
                }).on("select_node.jstree", function (node, selected, event) {
//                    $('#tree').jstree('toggle_node', selected.selected[0]);
                }).jstree({
                    plugins     : ["types", "state", "contextmenu", "search"],
                    core        : {
                        multiple       : false,
                        check_callback : true,
                        themes         : {
                            variant : "small",
                            dots    : true,
                            stripes : true
                        }
                    },
                    contextmenu : {
                        show_at_node : false,
                        items        : createContextMenu
                    },
                    state       : {
                        key : "departamentos"
                    },
                    search      : {
                        fuzzy             : false,
                        show_only_matches : false,
                        ajax              : {
                            url     : "${createLink(action:'arbolSearch_ajax')}",
                            success : function (msg) {
                                var json = $.parseJSON(msg);
                                $.each(json, function (i, obj) {
                                    $('#tree').jstree("open_node", obj);
                                });
                                setTimeout(function () {
                                    searchRes = $(".jstree-search");
                                    var cantRes = searchRes.length;
                                    posSearchShow = 0;
                                    $("#divSearchRes").removeClass("hidden");
                                    $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + cantRes);
                                    scrollToSearchRes();
                                }, 300);

                            }
                        }
                    },
                    types       : {
                        root     : {
                            icon : "fa fa-folder text-success"
                        },
                        tipoItem : {
                            icon : "fa flaticon-toolbox3 fa-1_5x text-info"
                        },
                        item     : {
                            icon : "fa flaticon-power30 fa-1_5x text-default"
                        },
                        bodega   : {
                            icon : "fa fa-archive text-warning"
                        }
                    }
                });

                $("#btnExpandAll").click(function () {
                    $treeContainer.jstree("open_all");
                    scrollToRoot();
                    return false;
                });

                $("#btnCollapseAll").click(function () {
                    $treeContainer.jstree("close_all");
                    scrollToRoot();
                    return false;
                });

                $('#btnSearchArbol').click(function () {
                    $treeContainer.jstree(true).search($.trim($("#searchArbol").val()));
                    return false;
                });
                $("#searchArbol").keypress(function (ev) {
                    if (ev.keyCode == 13) {
                        $treeContainer.jstree(true).search($.trim($("#searchArbol").val()));
                        return false;
                    }
                });

                $("#btnPrevSearch").click(function () {
                    if (posSearchShow > 0) {
                        posSearchShow--;
                    } else {
                        posSearchShow = searchRes.length - 1;
                    }
                    scrollToSearchRes();
                    return false;
                });

                $("#btnNextSearch").click(function () {
                    if (posSearchShow < searchRes.length - 1) {
                        posSearchShow++;
                    } else {
                        posSearchShow = 0;
                    }
                    scrollToSearchRes();
                    return false;
                });

                $("#btnClearSearch").click(function () {
                    $treeContainer.jstree("clear_search");
                    $("#searchArbol").val("");
                    posSearchShow = 0;
                    searchRes = [];
                    scrollToRoot();
                    $("#divSearchRes").addClass("hidden");
                    $("#spanSearchRes").text("");
                });

            });
        </script>
    </body>
</html>