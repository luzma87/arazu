<%@ page import="arazu.solicitudes.Cotizacion; arazu.parametros.EstadoSolicitud; arazu.items.Item; arazu.items.Maquinaria; arazu.seguridad.Persona" %>

<style type="text/css">
table {
    margin-top : 10px;
    font-size  : 12px;
}

.dp {
    width : 100px !important;
}

.nm {
    width : 70px !important;
}
</style>

<div class="btn-toolbar toolbar bg-info corner-all"
     style="padding: 5px; margin-top: 10px; margin-left: 0; margin-bottom: 0;">

    <form class="form-inline">
        <div class="form-group">
            <g:textField name="search_numero" class="form-control input-sm buscar nm" value="${params.search_numero}" placeholder="Número"/>
        </div>

        <div class="form-group">
            <elm:datepicker class="form-control input-sm buscar dp" name="search_desde" onChangeDate="validarFechaIni"
                            value="${params.search_desde}" placeholder="Desde"/>
        </div>

        <div class="form-group">
            <elm:datepicker class="form-control input-sm buscar dp" name="search_hasta" onChangeDate="validarFechaFin"
                            value="${params.search_hasta}" placeholder="Hasta"/>
        </div>

        <div class="form-group">
            <g:select name="search_de" from="${Persona.list([sort: 'apellido'])}"
                      optionKey="id" class="form-control input-sm buscar" data-style="btn-sm" data-live-search="true"
                      noSelection="['': '- Cualquier persona -']" value="${params.search_de}"/>
        </div>

        <div class="form-group">
            <g:select name="search_maquina" from="${Maquinaria.list([sort: 'descripcion'])}"
                      optionKey="id" class="form-control input-sm buscar" data-style="btn-sm" data-live-search="true"
                      noSelection="['': '- Cualquier maquinaria -']" value="${params.search_maquina}"/>
        </div>

        <div class="form-group">
            <g:select name="search_item" from="${Item.list([sort: 'descripcion'])}"
                      optionKey="id" noSelection="['': '- Cualquier item -']" value="${params.search_item}"
                      optionValue="${{
                          it.descripcion.decodeHTML()
                      }}" class="form-control input-sm buscar" data-style="btn-sm" data-live-search="true"/>
        </div>

        <g:if test="${buscarEstado}">
            <div class="form-group">
                <g:select name="search_estado" from="${EstadoSolicitud.findAllByTipo('NP', [sort: 'nombre'])}" optionKey="id" optionValue="nombre"
                          class="form-control input-sm buscar" data-style="btn-sm"
                          noSelection="['': '- Cualquier estado -']" value="${params.search_estado}"/>
            </div>
        </g:if>

        <div class="form-group">
            <div class="btn-group">
                <g:link controller="notaPedido" action="${linkBusqueda}" class="btn btn-sm btn-default btnSearch btnBuscar">
                    <i class="fa fa-search"></i> Buscar
                </g:link>
                <g:link controller="notaPedido" action="${linkBusqueda}" class="btn btn-sm btn-default btnSearch">
                    <i class="fa fa-close"></i> Borrar búsqueda
                </g:link>
            </div><!-- /input-group -->
        </div>

    </form>
</div>

<div class="alert alert-info" style="padding: 5px; margin-top: 2px; margin-bottom: 8px;">
    ${strSearch}
</div>
<g:set var="colspan" value="8"/>
<table class="table table-striped  table-bordered table-hover table-condensed" style="margin-top: 0;">
    <thead>
        <tr>
            <g:if test="${banderas}">
                <g:sortableColumn property="prioridad" title="Prioridad" style="width: 50px;"/>
                <g:set var="colspan" value="${colspan + 1}"/>
            </g:if>
            <g:sortableColumn property="numero" title="Número" style="width: 50px;"/>
            <g:sortableColumn property="fecha" title="Fecha" style="width: 130px;"/>
            <g:sortableColumn property="de" title="Solicita" style="width: 150px;"/>
            <g:sortableColumn property="motivoSolicitud" title="Motivo" style="width: 80px;"/>
            <g:sortableColumn property="maquinaria" title="Maquinaria" style="width: 150px;"/>
            <g:sortableColumn property="item" title="Item"/>
            <g:sortableColumn property="estadoSolicitud" title="Estado" style="width: 150px;"/>
            <g:if test="${cotizaciones}">
                <th style="width: 90px">Cotizaciones</th>
                <g:set var="colspan" value="${colspan + 1}"/>
            </g:if>
            <th style="width: 75px">Acciones</th>
        </tr>
    </thead>
    <tbody id="tabla-items">
        <g:if test="${notasCount > 0}">
            <g:each in="${notas}" var="nota">
                <tr>
                    <g:if test="${banderas}">
                        <td>
                            <g:if test="${nota.prioridad == '1AL'}">
                                <i class="fa fa-flag text-danger"></i> Alta
                            </g:if>
                            <g:elseif test="${nota.prioridad == '2MD'}">
                                <i class="fa fa-flag text-warning"></i> Media
                            </g:elseif>
                            <g:elseif test="${nota.prioridad == '3BJ'}">
                                <i class="fa fa-flag text-success"></i> Baja
                            </g:elseif>
                        </td>
                    </g:if>
                    <td>${nota.numero}</td>
                    <td>${nota.fecha.format("dd-MM-yyyy hh:mm:ss")}</td>
                    <td>${nota.de}</td>
                    <td>${nota.motivoSolicitud}</td>
                    <td>${nota.maquinaria}</td>
                    <td>
                        ${nota.cantidad.toInteger()}${nota.unidad.codigo} ${nota.item}
                        <g:if test="${nota.cantidad != nota.cantidadAprobada}">
                            (Aprobado ${nota.cantidadAprobada})
                        </g:if>
                    </td>
                    <td style="font-weight: bold" title="${nota.estadoSolicitud?.descripcion}">${nota.estadoSolicitud}</td>
                    <g:if test="${cotizaciones}">
                        <td>${Cotizacion.countByPedido(nota)}</td>
                    </g:if>
                    <td style="text-align: center">
                        <div class="btn-group" role="group">
                            <g:if test="${ingreso}">
                                <a href="#" title="Ingreso" data-id="${nota.id}" class="btn btn-primary btn-sm btnIng">
                                    <i class="fa fa-cart-arrow-down"></i>
                                </a>
                            </g:if>
                            <g:if test="${revisar}">
                                <g:link controller="notaPedido" action="${revisar}" title="Revisar" id="${nota.id}"
                                        class="btn btn-primary btn-sm">
                                    <i class="fa fa-pencil-square-o"></i>
                                </g:link>
                            </g:if>
                            <a href="${elm.pdfLink(href: createLink(controller: 'reportesPedidos', action: 'notaDePedido', id: nota.id), filename: 'nota_pedido_' + nota.numero + '_' + nota.fecha.format('dd-MM-yyyy') + ".pdf")}"
                               title="Imprimir" class="btn btn-info btn-sm " data-ref="Nota de pedido #${nota.numero}"
                               data-pp=""
                               target="_blank"
                               iden="${nota.id}">
                                <i class="fa fa-print"></i>
                            </a>
                        </div>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <tr class="danger">
                <td class="text-center" colspan="${colspan}">
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
<elm:pagination total="${notasCount}" params="${params}"/>

<script type="text/javascript">
    function armaParams() {
        var params = "";
        if ("${params.search_estado}" != "") {
            params += "search_programa=${params.search_programa}";
        }
        if ("${params.search_numero}" != "") {
            if (params != "") {
                params += "&";
            }
            params += "search_numero=${params.search_numero}";
        }
        if ("${params.search_de}" != "") {
            if (params != "") {
                params += "&";
            }
            params += "search_nombre=${params.search_nombre}";
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
        if ("${params.search_item}" != "") {
            if (params != "") {
                params += "&";
            }
            params += "search_item=${params.search_item}";
        }
        if ("${params.search_maquina}" != "") {
            if (params != "") {
                params += "&";
            }
            params += "search_maquina=${params.search_maquina}";
        }
//                if (params != "") {
//                    params = "?" + params;
//                }
        var returnParams = "?list=list";
        if (params != "") {
            returnParams += "&" + params;
        }
        return returnParams;
    }

    function validarFechaIni($elm, e) {
//                console.log("validar fecha ini   ", e);
        $('#search_hasta_input').data("DateTimePicker").setMinDate(e.date);
    }
    function validarFechaFin($elm, e) {
//                console.log("validar fecha fin   ", e, e.date);
        $('#search_desde_input').data("DateTimePicker").setMaxDate(e.date);
    }
    function buscar() {
        var $btn = $(".btnSearch");
        var str = "";
        var numero = $.trim($("#search_numero").val());
        var desde = $.trim($("#search_desde_input").val());
        var hasta = $.trim($("#search_hasta_input").val());
        var estado = $.trim($("#search_estado").val());
        var de = $.trim($("#search_de").val());
        var item = $.trim($("#search_item").val());
        var maquina = $.trim($("#search_maquina").val());
        if (desde != "") {
            str += "search_desde=" + desde;
        }
        if (hasta != "") {
            if (str != "") {
                str += "&";
            }
            str += "search_hasta=" + hasta;
        }
        if (numero != "") {
            if (str != "") {
                str += "&";
            }
            str += "search_numero=" + numero;
        }
        if (estado != "") {
            if (str != "") {
                str += "&";
            }
            str += "search_estado=" + estado;
        }
        if (de != "") {
            if (str != "") {
                str += "&";
            }
            str += "search_de=" + de;
        }
        if (item != "") {
            if (str != "") {
                str += "&";
            }
            str += "search_item=" + item;
        }
        if (maquina != "") {
            if (str != "") {
                str += "&";
            }
            str += "search_maquina=" + maquina;
        }
        var url = $btn.attr("href") + "?" + str;
        if (str == "") {
            url = $btn.attr("href");
        }
        location.href = url;
    }

    $(function () {
        $(".btnBuscar").click(function () {
            buscar();
            return false;
        });
        $(".btnSearch").click(function () {
            openLoader("Buscando");
        });
        $(".buscar").keyup(function (ev) {
            if (ev.keyCode == 13) {
                buscar();
            }
        });
    });
</script>