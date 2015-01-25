<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Inventario de la bodega ${bodega.descripcion}</title>
    </head>

    <body>
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link controller="inventario" action="ingresoDeBodega" params="[bodega: bodega.id]" class="btn btn-default btnCrear">
                    <i class="fa fa-file-o"></i> Nuevo ingreso a bodega
                </g:link>
            </div>
        </div>
        <elm:container tipo="horizontal" titulo="Inventario de la bodega ${bodega.descripcion}">
            <div class="row">
                <div class="col-md-1">
                    <label class=" control-label">
                        Responsable
                    </label>
                </div>

                <div class="col-md-3">
                    ${bodega.persona}
                </div>

                <div class="col-md-2">
                    <a href="#" class="btn btn-sm btn-info" id="btn-show-search">
                        <g:if test="${params.search_desde || params.search_hasta || params.search_item}">
                            <i class="fa fa-search-minus"></i> Ocultar opciones búsqueda
                        </g:if>
                        <g:else>
                            <i class="fa fa-search-plus"></i> Mostrar opciones búsqueda
                        </g:else>
                    </a>
                </div>
            </div>

            <div class="bg-info corner-all ${params.search_desde || params.search_hasta || params.search_item ? '' : 'hidden'}" id="div-search" role="toolbar" style="padding: 4px; margin-top: 5px;">
                <form class="form-inline">
                    <div class="form-group">
                        <label for="search_desde">Desde</label>
                        <elm:datepicker class="form-control input-sm buscar" name="search_desde" onChangeDate="validarFechaIni"
                                        value="${params.search_desde}"/>
                    </div>

                    <div class="form-group">
                        <label for="search_hasta">Hasta</label>
                        <elm:datepicker class="form-control input-sm buscar" name="search_hasta" onChangeDate="validarFechaFin"
                                        value="${params.search_hasta}"/>
                    </div>

                    <div class="form-group">
                        <label for="search_item">Item</label>
                        <g:textField name="search_item" class="form-control input-sm buscar"
                                     value="${params.search_item}"/>
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

            <table class="table table-striped table-hover table-bordered" style="margin-top: 10px">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Pedido</th>
                        <th>Item</th>
                        <th>Unidad</th>
                        <th>Cantidad</th>
                        <th>V. Unitario</th>
                        <th>V. Total</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <g:set var="total" value="${0}"/>
                    <g:if test="${ingresos.size() > 0}">
                        <g:each in="${ingresos}" var="ig" status="i">
                            <tr>
                                <g:set var="total" value="${total += ig.valor * ig.cantidad}"/>
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
                                <td class="text-center">
                                    ${ig.cantidad.toInteger()}
                                </td>
                                <td class="text-right">
                                    <g:formatNumber number="${ig.valor}" type="currency"/>
                                </td>
                                <td class="text-right">
                                    <g:formatNumber number="${ig.valor * ig.cantidad}" type="currency"/>
                                </td>
                                <td class="text-center">
                                    <a href="${elm.pdfLink(href: createLink(controller: 'reportesInventario', action: 'ingresoDeBodega', id: ig.id))}" title="Imprimir" class="btn btn-primary btn-sm" data-id="${ig.id}">
                                        <i class="fa fa-print"></i>
                                    </a>
                                </td>
                            </tr>
                        </g:each>
                    </g:if>
                    <g:else>
                        <tr class="danger">
                            <td class="text-center" colspan="7">
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
                        <td colspan="6" style="text-align: right;font-weight: bold">TOTAL</td>
                        <td style="text-align: right;font-weight: bold">
                            <g:formatNumber number="${total.toDouble()}" type="currency"/>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </elm:container>

        <script type="text/javascript">
            function armaParams() {
                var params = "";
                if ("${params.search_item}" != "") {
                    params += "search_item=${params.search_item}";
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
                var url = $btn.attr("href") + "?" + str;
                if (str == "") {
                    url = $btn.attr("href");
                }
                location.href = url;
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
                $(".buscar").keyup(function (ev) {
                    if (ev.keyCode == 13) {
                        openLoader("Buscando...");
                        buscar();
                    }
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