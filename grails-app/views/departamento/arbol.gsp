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
        <title>Estructura departamental</title>

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
                var esDepartamento = nodeType == "dpto";
                var esDepartamentoInactivo = nodeType == "dptoInactivo";
                var esUsuario = nodeType == "usuario";
                var esUsuarioInactivo = nodeType == "usuarioInactivo";

                var crearDep = {
                    label  : "Nuevo departamento",
                    icon   : "fa fa-building-o text-success",
                    action : function () {
                        createEditDepartamento(nodeId);
                    }
                };
                var editarDep = {
                    label  : "Modificar departamento",
                    icon   : "fa fa-pencil text-info",
                    action : function () {
                        createEditDepartamento(null, nodeId);
                    }
                };
                var eliminarDep = {
                    label            : "Eliminar departamento",
                    icon             : "fa fa-trash-o text-danger",
                    separator_before : true,
                    action           : function () {
                        deleteDepartamento(nodeId);
                    }
                };
                var activarDep = {
                    label            : "Activar departamento",
                    icon             : "fa fa-power-off text-success",
                    separator_before : true,
                    action           : function () {
                        cambiarActivoDepartamento(nodeId, 1);
                    }
                };
                var desactivarDep = {
                    label            : "Desactivar departamento",
                    icon             : "fa fa-power-off text-muted",
                    separator_before : true,
                    action           : function () {
                        cambiarActivoDepartamento(nodeId, 0);
                    }
                };
                var verDep = {
                    label            : "Ver departamento",
                    icon             : "fa fa-search",
                    separator_before : true,
                    action           : function () {
                        showDepartamento(nodeId);
                    }
                };

                var crearUsuario = {
                    label            : "Nuevo usuario",
                    icon             : "fa fa-user text-success",
                    separator_before : true,
                    action           : function () {
                        createEditPersona(nodeId);
                    }
                };
                var editarUsuario = {
                    label  : "Modificar usuario",
                    icon   : "fa fa-pencil text-info",
                    action : function () {
                        createEditPersona(null, nodeId);
                    }
                };
                var eliminarUsuario = {
                    label            : "Eliminar usuario",
                    icon             : "fa fa-trash-o text-danger",
                    separator_before : true,
                    action           : function () {
                        deletePersona(nodeId);
                    }
                };
                var activarUsuario = {
                    label            : "Activar usuario",
                    icon             : "fa fa-power-off text-success",
                    separator_before : true,
                    action           : function () {
                        cambiarActivoPersona(nodeId, 1);
                    }
                };
                var desactivarUsuario = {
                    label            : "Desactivar usuario",
                    icon             : "fa fa-power-off text-muted",
                    separator_before : true,
                    action           : function () {
                        cambiarActivoPersona(nodeId, 0);
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
                    items.crearDep = crearDep;
                } else if (esDepartamento) {
                    items.verDep = verDep;
                    items.crearDep = crearDep;
                    items.editarDep = editarDep;
                    if (cantHijos == 0) {
                        items.desactivarDep = desactivarDep;
//                        items.eliminarDep = eliminarDep;
                    }
                    items.crearUsuario = crearUsuario;
                } else if (esDepartamentoInactivo) {
                    items.verDep = verDep;
                    items.editarDep = editarDep;
                    if (cantHijos == 0) {
                        items.activarDep = activarDep;
//                        items.eliminarDep = eliminarDep;
                    }
                } else if (esUsuario) {
                    items.verUsuario = verUsuario;
                    items.editarUsuario = editarUsuario;
                    items.desactivarUsuario = desactivarUsuario;
                } else if (esUsuarioInactivo) {
                    items.verUsuario = verUsuario;
                    items.editarUsuario = editarUsuario;
                    items.activarUsuario = activarUsuario;
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

            function submitFormDepartamento() {
                var $form = $("#frmDepartamento");
                var $btn = $("#dlgCreateEditDepartamento").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    openLoader("Guardando Departamento");
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
            function deleteDepartamento(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                            "¿Está seguro que desea eliminar el Departamento seleccionado? Esta acción no se puede deshacer.</p>",
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
                                openLoader("Eliminando Departamento");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'departamento', action:'delete_ajax')}',
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
            function cambiarActivoDepartamento(itemId, activo) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-power-off fa-3x pull-left " + (activo == 1 ? "text-success" : "text-muted") + " text-shadow'></i><p>" +
                            "¿Está seguro que desea " + (activo == 1 ? "activar" : "desactivar") + " el Departamento seleccionado?</p>",
                    buttons : {
                        cancelar   : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        desactivar : {
                            label     : activo == 1 ? "<i class='fa fa-power-off'></i> Activar" : "<i class='fa fa-power-off'></i> Desactivar",
                            className : activo == 1 ? "btn-success" : "btn-danger",
                            callback  : function () {
                                openLoader((activo == 1 ? "Activando" : "Desactivando" ) + " Departamento");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'departamento', action:'cambiarActivo_ajax')}',
                                    data    : {
                                        id     : itemId,
                                        activo : activo
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
            function createEditDepartamento(padreId, id) {
                openLoader();
                var title = id ? "Editar" : "Crear";
                var data = id ? {id : id} : {};
                if (padreId) {
                    data.padre = padreId;
                }
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'departamento', action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        closeLoader();
                        var b = bootbox.dialog({
                            id    : "dlgCreateEditDepartamento",
                            title : title + " Departamento",

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
                                        return submitFormDepartamento();
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
            function showDepartamento(id) {
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'departamento', action:'show_ajax')}",
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        closeLoader();
                        bootbox.dialog({
                            title : "Ver Departamento",

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

            function submitFormPersona() {
                var $form = $("#frmPersona");
                var $btn = $("#dlgCreateEditPersona").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    openLoader("Guardando Persona");
                    var data = $form.serialize();
                    var perf = "";
                    $(".perfiles").each(function () {
                        if (perf != "") {
                            perf += "_";
                        }
                        perf += $(this).data("id");
                    });
                    data += "&perfiles=" + perf;
                    $.ajax({
                        type    : "POST",
                        url     : $form.attr("action"),
                        data    : data,
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
            function deletePersona(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                            "¿Está seguro que desea eliminar el Persona seleccionado? Esta acción no se puede deshacer.</p>",
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
                                openLoader("Eliminando Persona");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'persona', action:'delete_ajax')}',
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
            function cambiarActivoPersona(itemId, activo) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-power-off fa-3x pull-left " + (activo == 1 ? "text-success" : "text-muted") + " text-shadow'></i><p>" +
                            "¿Está seguro que desea " + (activo == 1 ? "activar" : "desactivar") + " la Persona seleccionada?</p>",
                    buttons : {
                        cancelar   : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        desactivar : {
                            label     : activo == 1 ? "<i class='fa fa-power-off'></i> Activar" : "<i class='fa fa-power-off'></i> Desactivar",
                            className : activo == 1 ? "btn-success" : "btn-danger",
                            callback  : function () {
                                openLoader((activo == 1 ? "Activando" : "Desactivando" ) + " Departamento");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'persona', action:'cambiarActivo_ajax')}',
                                    data    : {
                                        id     : itemId,
                                        activo : activo
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
            function createEditPersona(depId, id) {
                openLoader();
                var title = id ? "Editar" : "Crear";
                var data = id ? {id : id} : {};
                if (depId) {
                    data.dep = depId;
                }
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'persona', action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        closeLoader();
                        var b = bootbox.dialog({
                            id    : "dlgCreateEditPersona",
                            title : title + " Usuario",

                            class : "modal-lg",

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
                                        return submitFormPersona();
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

//                $(document).on("dnd_start.vakata", function (data, element, helper, event) {
//                    console.log("data: ", data, " element: ", element, " helper: ", helper, " event: ", event)
//                }).on("dnd_stop.vakata", function (data, element, helper, event) {
//                    console.log("data: ", data, " element: ", element, " helper: ", helper, " event: ", event)
//                });

                $treeContainer.on("loaded.jstree", function () {
                    $("#loading").hide();
                    $("#tree").removeClass("hidden");
                }).on("select_node.jstree", function (node, selected, event) {
//                    $('#tree').jstree('toggle_node', selected.selected[0]);
                }).on("move_node.jstree", function (e, data) {
                    //data.node, data.parent, data.old_parent is what you need
                    console.log(data);
                    console.log(data.node.id);
                    console.log(data.parent);
                }).jstree({
                    plugins     : ["types", "state", "contextmenu", "search", "dnd"],
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
                    dnd         : {
                        copy : false
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
                        "#"             : {
                            valid_children : ["root"],
                            max_children   : 1
                        },
                        root            : {
                            icon           : "fa fa-folder text-warning",
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
                            icon           : "fa fa-user text-success",
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