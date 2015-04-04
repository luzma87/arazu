<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Inventario de la bodega ${bodega.descripcion}</title>
    </head>

    <body>
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                %{--<g:link controller="inventario" action="ingresoDeBodega" params="[bodega: bodega.id]" class="btn btn-default btnCrear">--}%
                %{--<i class="fa fa-file-o"></i> Nuevo ingreso a bodega--}%
                %{--</g:link>--}%
                %{--<g:link controller="inventario" action="egresoDeBodega" params="[bodega: bodega.id]" class="btn btn-default btnCrear">--}%
                %{--<i class="fa fa-arrow-up"></i> Nuevo egreso de bodega--}%
                %{--</g:link>--}%
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
                    ${bodega.responsable}, ${bodega.suplente}
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
                        <g:link action="inventarioDesecho" id="${bodega.id}" class="btn btn-default">
                            <i class="fa fa-list"></i> Mostrar detallado
                        </g:link>
                    </div>
                </div>
            </div>

            <div class="bg-info corner-all ${params.search_item ? '' : 'hidden'}"
                 id="div-search" role="toolbar" style="padding: 4px; margin-top: 5px;">
                <form class="form-inline">

                    <div class="form-group">
                        <label for="search_item">Item</label>
                        <g:textField name="search_item" class="form-control input-sm buscar"
                                     value="${params.search_item}"/>
                    </div>

                    <div class="btn-group btn-group-sm" role="group">
                        <g:link controller="inventario" action="inventarioResumen" id="${bodega.id}" class="btn btn-info btnSearch bsc">
                            <i class="fa fa-search"></i> Buscar
                        </g:link>
                        <g:link controller="inventario" action="inventarioResumen" id="${bodega.id}" class="btn btn-default bsc">
                            <i class="fa fa-times"></i> Borrar búsqueda
                        </g:link>
                    </div>
                </form>
            </div>

            <table class="table table-striped table-hover table-bordered" style="margin-top: 10px">
                <thead>
                    <tr>
                        <g:sortableColumn property="item" title="Item"/>
                        <th>Unidad</th>
                        <g:sortableColumn property="cantidad" title="Cantidad"/>
                    </tr>
                </thead>
                <tbody>
                    <g:if test="${ingresos.size() > 0}">
                        <g:each in="${ingresos}" var="igg" status="i">
                            <g:set var="ig" value="${igg.value}"/>
                            <tr data-id="${ig.item.id}">
                                <td>
                                    <elm:textoBusqueda search="${params.search_item}">
                                        ${ig.item.descripcion}
                                    </elm:textoBusqueda>
                                </td>
                                <td>
                                    ${ig.unidad}
                                </td>
                                <td class="text-center">
                                    ${ig.saldo.toInteger()}
                                </td>
                            </tr>
                        </g:each>
                    </g:if>
                    <g:else>
                        <tr class="danger">
                            <td class="text-center" colspan="3">
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
            </table>
        </elm:container>

        <script type="text/javascript">
            function armaParams() {
                var params = "";
                if ("${params.search_item}" != "") {
                    params += "search_item=${params.search_item}";
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
                var item = $.trim($("#search_item").val());

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