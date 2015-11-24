<%@ page import="arazu.inventario.Egreso" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Inventario de la bodega ${bodega.descripcion}</title>
    </head>

    <body>
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link controller="bodega" action="list" class="btn btn-default btnCrear">
                    <i class="fa fa-list"></i> Bodegas
                </g:link>
            </div>

            <div class="btn-group">
                <g:link controller="inventario" action="ingresoDeBodega" params="[bodega: bodega.id]" class="btn btn-default btnCrear">
                    <i class="fa fa-file-o"></i> Nuevo ingreso a bodega
                </g:link>
            %{--<g:link controller="inventario" action="egresoDeBodega" params="[bodega: bodega.id]" class="btn btn-default btnCrear">--}%
            %{--<i class="fa fa-arrow-up"></i> Nuevo egreso de bodega--}%
            %{--</g:link>--}%
            </div>
        </div>
        <elm:container tipo="horizontal" titulo="Inventario de la bodega ${bodega.descripcion}">
            <div class="row">
                <div class="col-md-1">
                    <label class=" control-label">
                        Responsables
                    </label>
                </div>

                <div class="col-md-3">
                    <strong>${bodega.responsable}</strong>, ${bodega.suplente}
                </div>

                <div class="col-md-8">
                    <div class="btn-group btn-group-sm" role="group">
                        <a href="#" class="btn btn-info" id="btn-show-search">
                            <g:if test="${params.search_desde || params.search_hasta || params.search_item}">
                                <i class="fa fa-search-minus"></i> Ocultar opciones búsqueda
                            </g:if>
                            <g:else>
                                <i class="fa fa-search-plus"></i> Mostrar opciones búsqueda
                            </g:else>
                        </a>
                    </div>

                    <div class="btn-group btn-group-sm" role="group">
                        <g:link action="inventarioResumen" id="${bodega.id}" class="btn btn-default">
                            <i class="fa fa-th-list"></i> Mostrar resumen
                        </g:link>
                    </div>
                </div>
            </div>

            <div class="bg-info corner-all ${params.search_desde || params.search_hasta ||
                    params.search_item || params.search_pedido ? '' : 'hidden'}"
                 id="div-search" role="toolbar" style="padding: 4px; margin-top: 5px;">
                <form class="form-inline">
                    <div class="form-group">
                        <elm:datepicker class="form-control input-sm buscar" name="search_desde" onChangeDate="validarFechaIni"
                                        value="${params.search_desde}" style="width:90px;" placeholder="Desde"/>
                    </div>

                    <div class="form-group">
                        <elm:datepicker class="form-control input-sm buscar" name="search_hasta" onChangeDate="validarFechaFin"
                                        value="${params.search_hasta}" style="width:90px;" placeholder="Hasta"/>
                    </div>

                    <div class="form-group">
                        <g:textField name="search_pedido" class="form-control input-sm buscar"
                                     value="${params.search_pedido}" placeholder="Pedido"/>
                    </div>

                    <div class="form-group">
                        <g:textField name="search_item" class="form-control input-sm buscar"
                                     value="${params.search_item}" placeholder="Item"/>
                    </div>

                    <div class="btn-group btn-group-sm" role="group">
                        <g:link controller="inventario" action="inventario" id="${bodega.id}" class="btn btn-info btnSearch bsc">
                            <i class="fa fa-search"></i> Buscar
                        </g:link>
                        <g:link controller="inventario" action="inventario" id="${bodega.id}" class="btn btn-default bsc">
                            <i class="fa fa-times"></i> Borrar búsqueda
                        </g:link>
                    </div>
                </form>
            </div>

            <div class="table-wrapper" style="margin-top: 10px; margin-right: 35px;">
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                        <tr>
                            <g:sortableColumn property="fecha" title="Fecha"/>
                            <g:sortableColumn property="pedido" title="Pedido"/>
                            <g:sortableColumn property="item" title="Item"/>
                            <th>Unidad</th>
                            <g:sortableColumn property="cantidad" title="Cantidad"/>
                            <g:sortableColumn property="saldo" title="Saldo"/>
                            <g:sortableColumn property="valor" title="V. Unitario"/>
                            <th>V. Total</th>
                            <th style="width: 90px"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:set var="totalValor" value="${0}"/>
                        <g:set var="totalSaldo" value="${0}"/>
                        <g:set var="totalCantidad" value="${0}"/>
                        <g:if test="${ingresos.size() > 0}">
                            <g:each in="${ingresos}" var="ig" status="i">
                                <g:set var="totalValor" value="${totalValor + ig.valor * ig.saldo}"/>
                                <g:set var="totalCantidad" value="${totalCantidad + ig.cantidad}"/>
                                <g:set var="totalSaldo" value="${totalSaldo + ig.saldo}"/>
                                <tr>
                                    <td>
                                        ${ig.fecha.format("dd-MM-yyyy hh:mm:ss")}
                                    </td>
                                    <td>
                                        ${ig?.pedido}
                                    </td>
                                    <td>
                                        <elm:textoBusqueda search="${params.search_item}">
                                            ${ig.item.descripcion}
                                        </elm:textoBusqueda>
                                    </td>
                                    <td>
                                        ${ig.unidad}
                                    </td>
                                    <td class="text-right">
                                        <g:formatNumber number="${ig.cantidad}" maxFractionDigits="2" minFractionDigits="2"/>
                                    </td>
                                    <td class="text-right">
                                        <g:formatNumber number="${ig.saldo}" maxFractionDigits="2" minFractionDigits="2"/>
                                    </td>
                                    <td class="text-right">
                                        <g:formatNumber number="${ig.valor}" type="currency"/>
                                    </td>
                                    <td class="text-right">
                                        <g:formatNumber number="${ig.valor * ig.cantidad}" type="currency"/>
                                    </td>
                                    <td class="text-left">
                                        <div class="btn-group">
                                            <a target="_blank" href="${elm.pdfLink(filename: "ingreso_" + ig.id + ".pdf", href: createLink(controller: 'reportesInventario', action: 'ingresoDeBodega', id: ig.id))}" title="Imprimir" class="btn btn-primary btn-sm" data-id="${ig.id}">
                                                <i class="fa fa-print"></i>
                                            </a>
                                            <a href="#" title="Egreso" class="btn btn-warning btn-sm btn-eg" data-id="${ig.id}">
                                                <i class="fa fa-upload"></i>
                                            </a>
                                        </div>
                                        <g:if test="${session.perfil.codigo == 'SPAD' && Egreso.countByIngreso(ig) == 0}">
                                            <a href="#" title="Eliminar" class="btn btn-danger btn-sm btn-spad-delete" data-id="${ig.id}">
                                                <i class="fa fa-trash"></i>
                                            </a>
                                        </g:if>
                                    </td>
                                </tr>
                            </g:each>
                        </g:if>
                        <g:else>
                            <tr class="danger">
                                <td class="text-center" colspan="8">
                                    <g:if test="${(params.search_desde && params.search_desde != '') ||
                                            (params.search_hasta && params.search_hasta != '') ||
                                            (params.search_item && params.search_item != '')}">
                                        No se encontraron resultados para su búsqueda
                                    </g:if>
                                    <g:else>
                                        No se encontraron registros que mostrar
                                    </g:else>
                                </td>
                            </tr>
                        </g:else>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="4" class="text-right">TOTAL</th>
                            <th class="text-right">
                                <g:formatNumber number="${totalCantidad.toDouble()}" maxFractionDigits="2" minFractionDigits="2"/>
                            </th>
                            <th class="text-right">
                                <g:formatNumber number="${totalSaldo.toDouble()}" maxFractionDigits="2" minFractionDigits="2"/>
                            </th>
                            <th></th>
                            <th class="text-right">
                                <g:formatNumber number="${totalValor.toDouble()}" type="currency"/>
                            </th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </elm:container>

        <script type="text/javascript">
            function armaParams() {
                var params = "";
                if ("${params.search_item}" != "") {
                    params += "search_item=${params.search_item}";
                }
                if ("${params.search_pedido}" != "") {
                    if (params != "") {
                        params += "&";
                    }
                    params += "search_pedido=${params.search_pedido}";
                }
                if ("${params.search_desde}" != "") {
                    if (params != "") {
                        params += "&";
                    }
                    params += "search_desde=${params.search_desde}";
                }
                if ("${params.search_hasta}" != "") {
                    if (params != "") {
                        params += "&";
                    }
                    params += "search_hasta=${params.search_hasta}";
                }
//                if (params != "") {
//                    params = "?" + params;
//                }
//                var returnParams = "?list=list";
//                if (params != "") {
//                    returnParams += "&" + params;
//                }
                var returnParams = "";
                if (params != "") {
                    returnParams = "?" + params;
                }
                return returnParams;
            }

            function buscar() {
                var $btn = $(".btnSearch");
                var str = "";
                var desde = $.trim($("#search_desde_input").val());
                var hasta = $.trim($("#search_hasta_input").val());
                var item = $.trim($("#search_item").val());
                var pedido = $.trim($("#search_pedido").val());
                if (desde != "") {
                    str += "search_desde=" + desde;
                }
                if (hasta != "") {
                    if (str != "") {
                        str += "&";
                    }
                    str += "search_hasta=" + hasta;
                }
                if (item != "") {
                    if (str != "") {
                        str += "&";
                    }
                    str += "search_item=" + item;
                }
                if (pedido != "") {
                    if (str != "") {
                        str += "&";
                    }
                    str += "search_pedido=" + pedido;
                }
                var url = $btn.attr("href") + "?" + str;
                if (str == "") {
                    url = $btn.attr("href");
                }
                location.href = url;
            }

            function submitEgreso() {
                if ($("#frmEgreso").valid()) {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'inventario', action:'egresoBodega_ajax')}",
                        data    : $("#frmEgreso").serialize(),
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            setTimeout(function () {
                                if (parts[0] == "SUCCESS") {
                                    location.reload(true);
                                } else {
                                    closeLoader();
                                    return false;
                                }
                            }, 1000);
                        },
                        error   : function () {
                            log("Ha ocurrido un error interno", "error");
                            closeLoader();
                        }
                    });
                }
            }

            function validarFechaIni($elm, e) {
//                console.log("validar fecha ini   ", e);
                $('#search_hasta_input').data("DateTimePicker").setMinDate(e.date);
            }
            function validarFechaFin($elm, e) {
//                console.log("validar fecha fin   ", e, e.date);
                $('#search_desde_input').data("DateTimePicker").setMaxDate(e.date);
            }
            $(function () {
                $(".bsc").click(function () {
                    openLoader("Buscando...");
                });
                $(".btnSearch").click(function () {
                    buscar();
                    return false;
                });
                $(".btn-eg").click(function () {
                    var id = $(this).data("id");
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'inventario', action:'dlgEgresoDeBodega_ajax')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            bootbox.dialog({
                                title   : "Egreso de Bodega",
                                message : msg,
                                buttons : {
                                    ok     : {
                                        label     : "<i class='fa fa-save'></i> Guardar",
                                        className : "btn-success",
                                        callback  : function () {
                                            submitEgreso();
                                            return false;
                                        }
                                    },
                                    cancel : {
                                        label     : "Cancelar",
                                        className : "btn-default",
                                        callback  : function () {
                                        }
                                    }
                                }
                            });
                        }
                    });
                    return false;
                });
                $(".buscar").keyup(function (ev) {
                    if (ev.keyCode == 13) {
                        openLoader("Buscando...");
                        buscar();
                    }
                });

                $(".btn-spad-delete").click(function () {
                    var id = $(this).data("id");
                    bootbox.dialog({
                        title   : "Alerta",
                        message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i>" +
                                  "<h2 class='text-danger text-shadow '>Alerta</h2>" +
                                  "<p class='lead text-danger'>Está seguro que desea eliminar el ingreso seleccionado?</p>" +
                                  "<p>Utilice esta funcionalidad únicamente para eliminar ingresos duplicados</p>" +
                                  "<p>Se eliminará toda la información del ingreso a bodega y " +
                                  "<span class='text-danger'>esta acción no se puede deshacer</span>. </p>",
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
                                    openLoader("Eliminando Ingreso");
                                    $.ajax({
                                        type    : "POST",
                                        url     : '${createLink(controller:'inventario', action:'delete_ajax')}',
                                        data    : {
                                            id : id
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
                    return false;
                });

                var $divSearch = $("#div-search");
                $("#btn-show-search").click(function () {
                    if ($divSearch.is(":visible")) {
                        $divSearch.addClass("hidden");
                        $(this).html("<i class='fa fa-search-plus'></i> Mostrar opciones de búsqueda");
                    } else {
                        $divSearch.removeClass("hidden");
                        $(this).html("<i class='fa fa-search-minus'></i> Ocultar opciones de búsqueda");
                    }
                });
            });
        </script>

    </body>
</html>