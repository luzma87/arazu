<style type="text/css">
.table-striped > tbody > tr:nth-of-type(even) {
    background-color : white;
}
</style>

<div class="titulo-alertas">
    <i class="fa fa-warning"></i>
    Alertas del usuario ${session.usuario}
</div>
<table class="table table-condensed table-bordered table-striped table-hover" style="font-size: 11px">
    <thead>
        <tr>
            <th></th>
            <th style="width: 63px;">Fecha</th>
            <th>Mensaje</th>
            <th>Link</th>
        </tr>
    </thead>
    <tbody>
        <g:if test="${alertaInstanceCount > 0}">
            <g:each in="${alertaInstanceList}" status="i" var="alertaInstance">
                <tr>
                    <td>
                        <a href="#" class="btn btn-default btn-xs btnRead" data-id="${alertaInstance.id}" title="Marcar como leído">
                            <i class="fa fa-check-square-o"></i>
                        </a>
                    </td>
                    <td style="text-align: center"><g:formatDate date="${alertaInstance.fechaEnvio}" format="dd-MM-yyyy"/></td>
                    <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${alertaInstance}" field="mensaje"/></elm:textoBusqueda></td>
                    <td class="text-center">
                        <g:link controller="alerta" action="showAlerta" id="${alertaInstance.id}"
                                class="btn btn-warning btn-sm btn-alerta">
                            IR
                        </g:link>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <tr class="danger">
                <td class="text-center" colspan="8">
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

<script type="text/javascript">
    $(function () {
        $(".btn-alerta").click(function () {
            openLoader();
        });

        $(".btnRead").click(function () {
            var id = $(this).data("id");
            bootbox.confirm("<div class='alert alert-warning'>" +
                            "<i class='fa fa-exclamation-triangle fa-3x text-warning pull-left'></i> " +
                            "<p>¿Está seguro de querer marcar esta alerta como leída?</p>" +
                            "<p>Ya no aparecerá en la lista.</p>" +
                            "</div>",
                    function (res) {
                        if (res) {
                            $.ajax({
                                type    : "POST",
                                url     : "${g.createLink(controller: 'alerta',action: 'marcarLeida_ajax')}",
                                data    : {
                                    id : id
                                },
                                success : function (msg) {
                                    $("#divTotalAlertas").text(msg);
                                    $.ajax({
                                        type    : "POST",
                                        url     : "${g.createLink(controller: 'alerta',action: 'list_ajax')}",
                                        data    : "",
                                        success : function (msg) {
                                            $(".content-alertas").html(msg)
                                        },
                                        error   : function () {
                                            log("Ha ocurrido un error interno", "Error");
                                            closeLoader();
                                        }
                                    });
                                },
                                error   : function () {
                                    log("Ha ocurrido un error interno", "Error");
                                    closeLoader();
                                }
                            });
                        }
                    });
            return false;
        });
    });
</script>