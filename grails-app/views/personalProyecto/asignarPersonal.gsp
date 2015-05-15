<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 09-May-15
  Time: 23:41
--%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Asignar personal al proyecto ${proyecto}</title>

        <imp:js src="${resource(dir: 'js/plugins/jquery-highlight', file: 'jquery-highlight1.js')}"/>

        <style type="text/css">
        .panel-personal .list-group {
            height   : 300px;
            overflow : auto;
        }

        .highlight {
            background : #f4dd2c;
            color      : #000;
        }
        </style>
    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Asignar personal al proyecto ${proyecto}">
            <div class="row">
                <div class="col-md-5">
                    <div class="panel panel-info panel-personal">
                        <div class="panel-heading">
                            <div class="row" style="margin-top: 0;">
                                <div class="col-md-6">
                                    <h3 class="panel-title">Personal disponible</h3>
                                </div>

                                <div class="col-md-6">
                                    <div class="input-group input-group-sm">
                                        <input type="text" class="form-control" id="txtSearchPersonal"/>
                                        <span class="input-group-addon">
                                            <i class="fa fa-search"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="list-group" id="disponibles">
                            <g:each in="${personalDisponible}" var="p">
                                <a href="#" class="list-group-item disponible" data-id="${p.id}">
                                    ${p}
                                </a>
                            </g:each>
                        </div>
                    </div>
                </div>

                <div class="col-md-1 text-center">
                    <div class="btn-group-vertical" role="group">
                        <a href="#" class="btn btn-default" id="moveRight">
                            <i class="fa fa-angle-right"></i>
                        </a>
                        <a href="#" class="btn btn-default" id="moveLeft">
                            <i class="fa fa-angle-left"></i>
                        </a>
                        %{--<a href="#" class="btn btn-default" id="moveRightAll">--}%
                        %{--<i class="fa fa-angle-double-right"></i>--}%
                        %{--</a>--}%
                        %{--<a href="#" class="btn btn-default" id="moveLeftAll">--}%
                        %{--<i class="fa fa-angle-double-left"></i>--}%
                        %{--</a>--}%
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="panel panel-success panel-personal">
                        <div class="panel-heading">
                            <h3 class="panel-title">Personal asignado</h3>
                        </div>

                        <div class="list-group" id="seleccionados">
                            <g:each in="${personalProyecto}" var="p">
                                <a href="#" class="list-group-item seleccionado" data-id="${p.id}">
                                    ${p.persona}
                                </a>
                            </g:each>
                        </div>
                    </div>
                </div>
            </div>
        </elm:container>

        <script type="text/javascript">
            var $disponibles = $(".disponible");
            var $seleccionados = $(".seleccionado");

            function getIds($lista) {
                var ids = "";
                $lista.find(".active").each(function () {
                    if (ids != "") {
                        ids += ",";
                    }
                    ids += $(this).data("id");
                });
                return ids;
            }

            function removeSelected() {
//                var ids = "";
//                $("#seleccionados").find(".active").each(function () {
//                    if (ids != "") {
//                        ids += ",";
//                    }
//                    ids += $(this).data("id");
//                });
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'quitarPersonalProyecto_ajax')}",
                    data    : {
                        ids : getIds($("#seleccionados"))
                    },
                    success : function (msg) {
                        var parts = msg.split("*");
                        log(parts[1], parts[0]);
                        location.reload(true);
                    },
                    error   : function () {
                        log("Ha ocurrido un error interno", "Error");
                        closeLoader();
                    }
                });
            }

            function addSelected() {
//                var $item = $(this);
//                var ids = "";
//                $("#disponibles").find(".active").each(function () {
//                    if (ids != "") {
//                        ids += ",";
//                    }
//                    ids += $(this).data("id");
//                    $(this).append(spinner);
//                });

                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'agregarPersonalProyecto_ajax')}",
                    data    : {
                        ids : getIds($("#disponibles")),
                        id  : "${proyecto.id}"
                    },
                    success : function (msg) {
                        var parts = msg.split("*");
                        log(parts[1], parts[0]);
                        location.reload(true);
                    },
                    error   : function () {
                        log("Ha ocurrido un error interno", "Error");
                        closeLoader();
                    }
                });

            }

            $(function () {
                $("#txtSearchPersonal").keyup(function () {
                    $disponibles.show().removeHighlight();
                    var txt = $.trim($(this).val());
                    if (txt != "") {
                        $disponibles.hide();
                        $disponibles.highlight(txt, false);
                        $disponibles.find(".highlight").parents(".disponible").show();
                    }
                });

                $disponibles.click(function () {
                    $(this).toggleClass("active");
                    return false;
                });

                $seleccionados.click(function () {
                    $(this).toggleClass("active");
                    return false;
                });

                $("#moveRight").click(function () {
                    addSelected();
                    return false;
                });

                $("#moveLeft").click(function () {
                    removeSelected();
                    return false;
                });
            });
        </script>
    </body>
</html>