<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 4/24/2015
  Time: 7:20 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Archivos</title>

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

        .fileName, .dirName {
            font-size : large;
            /*font-weight : bold;*/
            /*color       : red;*/
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

        <div id="tree">
            ${html}
        </div>

        <script type="text/javascript">
            var searchRes = [];
            var posSearchShow = 0;
            var $treeContainer = $("#tree");

            var okContents = {
                'image/png'                                                                 : 'png',
                'image/jpeg'                                                                : 'jpeg',
                'image/jpg'                                                                 : 'jpg',
                'image/bmp'                                                                 : 'bmp',
                'application/pdf'                                                           : 'pdf',
                'application/download'                                                      : 'pdf',
                'application/excel'                                                         : 'xls',
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'         : 'xlsx',
                'application/mspowerpoint'                                                  : 'pps',
                'application/vnd.ms-powerpoint'                                             : 'pps',
                'application/powerpoint'                                                    : 'ppt',
                'application/x-mspowerpoint'                                                : 'ppt',
                'application/vnd.openxmlformats-officedocument.presentationml.slideshow'    : 'ppsx',
                'application/vnd.openxmlformats-officedocument.presentationml.presentation' : 'pptx',
                'application/msword'                                                        : 'doc',
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document'   : 'docx',
                'application/vnd.oasis.opendocument.text'                                   : 'odt',
                'application/vnd.oasis.opendocument.presentation'                           : 'odp',
                'application/vnd.oasis.opendocument.spreadsheet'                            : 'ods',
                'text/plain'                                                                : 'txt',
                'application/zip'                                                           : 'zip',
                'audio/x-mpeg'                                                              : 'mp3',
                'audio/x-wav'                                                               : 'wav',
                'video/mp4'                                                                 : 'mp4',
                'video/x-ms-wmv'                                                            : 'wmv'
            };

            function createContextMenu(node) {
                var nodeStrId = node.id;
                var $node = $("#" + nodeStrId);
                var nodeType = $node.data("jstree").type;
                var nodePath = $node.data("path");
                var nodeName = $node.data("name");

                var isDir = nodeType == "dir";

                var items = {};

                var download = {
                    label  : "Descargar",
                    icon   : "fa fa-download text-info",
                    action : function () {
//                        openLoader("Comprimiendo");
                        bootbox.alert("Su archivo está preparándose para la descarga. " +
                                      "Por favor cierre esta pantalla cuando termine la descarga");
                        location.href = "${createLink(controller:'archivos', action:'downloadArchivo')}?path=" + nodePath;
                    }
                };
                var downloadZip = {
                    label  : "Descargar comprimido",
                    icon   : "fa fa-arrow-circle-o-down text-info",
                    action : function () {
                        openLoader("Comprimiendo");
                        location.href = "${createLink(controller:'archivos', action:'downloadZip_ajax')}?path=" + nodePath + "&text=" + nodeName;
//                        closeLoader();
                        %{--$.ajax({--}%
                        %{--type    : "POST",--}%
                        %{--url     : "${createLink(controller:'archivos', action:'downloadZip_ajax')}",--}%
                        %{--data    : {--}%
                        %{--path : nodePath,--}%
                        %{--text : nodeName--}%
                        %{--},--}%
                        %{--success : function (msg) {--}%
                        %{--var parts = msg.split("*");--}%
                        %{--log(parts[1], parts[0]);--}%
                        %{--closeLoader();--}%
                        %{--}--}%
                        %{--});--}%
                    }
                };
                var crearDir = {
                    label            : "Crear carpeta",
                    icon             : "fa fa-folder-open text-success",
                    separator_before : true,
                    action           : function () {
                        bootbox.prompt({
                            title    : "Crear carpeta en <span class='text-info'>" + nodeName + "</span>",
                            class    : "modal-sm",
                            callback : function (result) {
                                if (result === null) {
                                } else {
                                    openLoader("Creando carpeta");
                                    $.ajax({
                                        type    : "POST",
                                        url     : "${createLink(controller:'archivos', action:'createFolder_ajax')}",
                                        data    : {
                                            name   : result,
                                            parent : nodePath
                                        },
                                        success : function (msg) {
                                            var parts = msg.split("*");
                                            log(parts[1], parts[0]);
                                            if (parts[0] == "SUCCESS") {
                                                setTimeout(function () {
                                                    location.reload(true);
                                                }, 1000);
                                            } else {
                                                closeLoader();
                                            }
                                        }
                                    });
                                }
                            }
                        });
                    }
                };
                var upload = {
                    label  : "Subir archivo",
                    icon   : "fa fa-upload text-info",
                    action : function () {
                        var dialogHtml = '<form action="" enctype="multipart/form-data" method="post" id="frm">';
                        dialogHtml += '<input type="file" name="file" id="file"/>';
                        dialogHtml += '<input type="hidden" name="path" id="path" value="' + nodePath + '"/>';

                        bootbox.dialog({
                            message : dialogHtml,
                            title   : 'Subir archivo',
                            buttons : {
                                cancel : {
                                    label     : "Cancelar",
                                    className : "btn-default",
                                    callback  : function () {

                                    }
                                },
                                upload : {
                                    label     : "<i class='fa fa-upload'></i> Cargar",
                                    className : "btn-primary",
                                    callback  : function () {
                                        var $form = $("#frm");
                                        var formData = new FormData($form[0]);
                                        $.ajax({
                                            type        : "POST",
                                            url         : "${createLink(action:'uploadFile_ignore')}",
                                            data        : formData,
                                            async       : false,
                                            cache       : false,
                                            contentType : false,
                                            processData : false,
                                            success     : function (msg) {
                                                openLoader("Cargando archivo");
                                                var parts = msg.split("*");
                                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                                setTimeout(function () {
                                                    if (parts[0] == "SUCCESS") {
                                                        location.reload(true);
                                                    } else {
                                                        closeLoader();
                                                    }
                                                }, 1000);
                                            }
                                        });
                                        return false;
                                    }
                                }
                            }
                        });
                    }
                };
                var rename = {
                    label            : "Cambiar nombre",
                    icon             : "fa fa-pencil text-info",
                    separator_before : true,
                    action           : function () {
                        bootbox.prompt({
                            title    : "Cambiar nombre de <span class='text-info'>" + nodeName + "</span>",
                            class    : "modal-sm",
                            callback : function (result) {
                                if (result === null) {
                                } else {
                                    openLoader("Cambiando nombre");
                                    $.ajax({
                                        type    : "POST",
                                        url     : "${createLink(controller:'archivos', action:'rename_ajax')}",
                                        data    : {
                                            name : result,
                                            path : nodePath,
                                            text : nodeName
                                        },
                                        success : function (msg) {
                                            var parts = msg.split("*");
                                            log(parts[1], parts[0]);
                                            if (parts[0] == "SUCCESS") {
                                                setTimeout(function () {
                                                    location.reload(true);
                                                }, 1000);
                                            } else {
                                                closeLoader();
                                            }
                                        }
                                    });
                                }
                            }
                        });
                    }
                };
                var eliminar = {
                    label            : "Eliminar",
                    icon             : "fa fa-trash text-danger",
                    separator_before : true,
                    action           : function () {
                        bootbox.confirm("<i class='fa fa-trash-o text-danger fa-3x'></i> Está seguro de querer eliminar <span class='text-danger'>" + nodeName + "</span>? " +
                                        "Esta acción no se puede deshacer.", function (res) {
                            if (res) {
                                openLoader("Eliminando");
                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink(controller:'archivos', action:'delete_ajax')}",
                                    data    : {
                                        path : nodePath
                                    },
                                    success : function (msg) {
                                        var parts = msg.split("*");
                                        log(parts[1], parts[0]);
                                        if (parts[0] == "SUCCESS") {
                                            setTimeout(function () {
                                                location.reload(true);
                                            }, 1000);
                                        } else {
                                            closeLoader();
                                        }
                                    }
                                });
                            }
                        });
                    }
                };

                if (isDir) {
//                    items.downloadZip = downloadZip;
                    items.upload = upload;
                    items.crearDir = crearDir;
                } else {
                    items.download = download;
//                    if (nodeType != "zip") {
//                        items.downloadZip = downloadZip;
//                    }
                }
                items.rename = rename;
                items.eliminar = eliminar;
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
                var $scrollTo = $(searchRes[posSearchShow]);
                $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + searchRes.length);
                scrollToNode($scrollTo);
            }

            $(function () {
                $treeContainer.on("search.jstree", function (event, res) {
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
                        key : "archivos"
                    },
                    search      : {
                        fuzzy : false
                    },
                    types       : {
                        dir   : {
                            icon : "fa fa-folder-open text-success"
                        },
                        file  : {
                            icon : "fa fa-file-o"
                        },
                        pdf   : {
                            icon : "fa fa-file-pdf-o text-danger"
                        },
                        text  : {
                            icon : "fa fa-file-text-o"
                        },
                        doc   : {
                            icon : "fa fa-file-word-o text-info"
                        },
                        xls   : {
                            icon : "fa fa-file-excel-o text-success"
                        },
                        ppt   : {
                            icon : "fa fa-file-powerpoint-o text-danger"
                        },
                        image : {
                            icon : "fa fa-file-image-o text-warning"
                        },
                        zip   : {
                            icon : "fa fa-file-archive-o "
                        },
                        audio : {
                            icon : "fa fa-file-audio-o text-info"
                        },
                        video : {
                            icon : "fa fa-file-video-o"
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