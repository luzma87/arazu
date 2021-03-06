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

                var verTipoItem = {
                    label  : "Ver Tipo de Item",
                    icon   : "fa fa-search",
                    action : function () {
                        showTipoItem(nodeId);
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
                        //bodega-item-unidad-desecho
                        var parts = nodeId.split("-");
                        if (parts.length == 4) {
                            verDetallesBodega(parts[0], parts[1], parts[2], parts[3]);
                        }
                    }
                };

                var items = {};

                if (esRoot) {
                } else if (esTipoItem) {
                    items.verTipoItem = verTipoItem;
                } else if (esItem) {
                    items.verItem = verItem;
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
                var $scrollTo = $(searchRes[posSearchShow]).first();
                $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + searchRes.length);
                scrollToNode($scrollTo);
            }

            function showTipoItem(id) {
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'tipoItem', action:'show_ajax')}",
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        closeLoader();
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

            function showItem(id) {
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'item', action:'show_ajax')}",
                    data    : {
                        id : id
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

            function verDetallesBodega(bodega, item, unidad, desecho) {
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'bodega', action:'verDetalles_ajax')}",
                    data    : {
                        bodega  : bodega,
                        item    : item,
                        unidad  : unidad,
                        desecho : desecho
                    },
                    success : function (msg) {
                        closeLoader();
                        bootbox.dialog({
                            title   : "Ver Item",
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
                }).on("search.jstree", function (event, res) {
                    searchRes = res.nodes;
                    var cantRes = searchRes.length;
                    posSearchShow = 0;
                    $("#divSearchRes").removeClass("hidden");
                    $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + cantRes);
                    scrollToSearchRes();
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
                        key : "items"
                    },
                    search      : {
                        fuzzy : false
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