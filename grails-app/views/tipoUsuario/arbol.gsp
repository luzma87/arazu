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
        <title>Tipos de usuario</title>

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

                <div class="btn-group">
                    <g:link action="arbol" params="[inactivos: params.inactivos == 'S' ? 'N' : 'S']" class="btn btn-xs btn-default">
                        <i class="fa fa-power-off"></i> ${params.inactivos == 'S' ? 'Ocultar' : 'Mostrar'} inactivos
                    </g:link>
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
                var esTipoUsuario = nodeType == "dpto";
                var esTipoUsuarioInactivo = nodeType == "dptoInactivo";
                var esUsuario = nodeType == "usuario";
                var esUsuarioInactivo = nodeType == "usuarioInactivo";

                var verDep = {
                    label            : "Ver tipo de Usuario",
                    icon             : "fa fa-search",
                    separator_before : true,
                    action           : function () {
                        showTipoUsuario(nodeId);
                    }
                };

                var verUsuario = {
                    label            : "Ver usuario",
                    icon             : "fa fa-search",
                    separator_before : true,
                    action           : function () {
                        showPersona(nodeId);
                    }
                };

                var items = {};

                if (esRoot) {
                } else if (esTipoUsuario) {
                    items.verDep = verDep;
                } else if (esTipoUsuarioInactivo) {
                    items.verDep = verDep;
                } else if (esUsuario) {
                    items.verUsuario = verUsuario;
                } else if (esUsuarioInactivo) {
                    items.verUsuario = verUsuario;
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

            function showTipoUsuario(id) {
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'tipoUsuario', action:'show_ajax')}",
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        closeLoader();
                        bootbox.dialog({
                            title : "Ver Tipo de Usuario",

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

            function showPersona(id) {
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'persona', action:'show_ajax')}",
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        closeLoader();
                        bootbox.dialog({
                            title : "Ver Persona",

                            class : "modal-lg",

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
                        key : "tipoUsuarios"
                    },
                    search      : {
                        fuzzy : false
                    },
                    types       : {
                        "#"             : {
                            valid_children : ["root"],
                            max_children   : 1
                        },
                        root            : {
                            icon           : "fa fa-folder text-success",
                            valid_children : ["dpto", "dptoInactivo"]
                        },
                        dpto            : {
                            icon           : "fa fa-building-o text-info",
                            valid_children : ["dpto", "dptoInactivo", "usuario", "usuarioInactivo"]
                        },
                        dptoInactivo    : {
                            icon           : "fa fa-building-o text-muted",
                            valid_children : []
                        },
                        usuario         : {
                            icon           : "fa fa-user text-warning",
                            valid_children : []
                        },
                        usuarioInactivo : {
                            icon           : "fa fa-user text-muted",
                            valid_children : []
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