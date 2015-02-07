<imp:js src="${resource(dir: 'js', file: 'ui.js')}"/>
<imp:js src="${resource(dir: 'js/plugins/jquery-highlight', file: 'jquery-highlight1.js')}"/>

<style type="text/css">
.scroll {
    max-height : 250px;
    overflow-y : auto;
}
</style>

<div class="row no-margin-top" style="margin-bottom: 10px;">
    <div class="col-md-6">
        <div class="input-group">
            <input type="text" class="form-control" id="inputBuscarMq" placeholder="Buscar" value="${params.search}">
            <span class="input-group-addon svt-bg-warning"><i class="fa fa-search"></i></span>
        </div>
    </div>
</div>

<div class="scroll">
    <table class="table table-condensed table-bordered table-striped table-hover">
        <thead>
            <tr>
                <th>Tipo</th>
                <th>Marca</th>
                <th>Modelo</th>
                <th>Placa</th>
                <th>Descripción</th>
                <th>Observaciones</th>
                <th style="width: 33px;"></th>
            </tr>
        </thead>
        <tbody id="tbMq">
            <g:if test="${maquinariaInstanceCount > 0}">
                <g:each in="${maquinariaInstanceList}" status="i" var="maquinariaInstance">
                    <tr data-id="${maquinariaInstance.id}" data-descripcion="${maquinariaInstance.toString()}">
                        <td>
                            <elm:textoBusqueda search="${params.search}">
                                <g:fieldValue bean="${maquinariaInstance}" field="tipo"/>
                            </elm:textoBusqueda>
                        </td>
                        <td>
                            <elm:textoBusqueda search="${params.search}">
                                <g:fieldValue bean="${maquinariaInstance}" field="marca"/>
                            </elm:textoBusqueda>
                        </td>
                        <td>
                            <elm:textoBusqueda search="${params.search}">
                                <g:fieldValue bean="${maquinariaInstance}" field="modelo"/>
                            </elm:textoBusqueda>
                        </td>
                        <td>
                            <elm:textoBusqueda search="${params.search}">
                                <g:fieldValue bean="${maquinariaInstance}" field="placa"/>
                            </elm:textoBusqueda>
                        </td>
                        <td>
                            <elm:textoBusqueda search="${params.search}">
                                ${maquinariaInstance.descripcion}
                            </elm:textoBusqueda>
                        </td>
                        <td>
                            <elm:textoBusqueda search="${params.search}">
                                <g:fieldValue bean="${maquinariaInstance}" field="observaciones"/>
                            </elm:textoBusqueda>
                        </td>
                        <td>
                            <a href="#" class="btn btn-success btn-sm btnSelectMq" title="Seleccionar">
                                <i class="fa fa-check"></i>
                            </a>
                        </td>
                    </tr>
                </g:each>
            </g:if>
            <g:else>
                <tr class="danger">
                    <td class="text-center" colspan="8">
                        No se encontraron registros que mostrar
                    </td>
                </tr>
            </g:else>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(function () {
        var $input = $("#inputBuscarMq");
        var $tbody = $("#tbMq");
        var $td = $("td");

        $(".btnSelectMq").click(function () {
            var $tr = $(this).parents("tr");
            var id = $tr.data("id");
            var desc = $tr.data("descripcion");
            $("#maquina").val(id);
            $("#maquina_input").val(desc);
            $("#dlgFindMaquinaria").modal("hide");
            $('.qtip.ui-tooltip').qtip('hide');
            if (!$(".toggle").is(":visible")) {
                $(".toggle").removeClass("hidden");
            }
        });

        function loadTabla() {
            $td.removeHighlight();
            $tbody.find("tr").hide();
            var search = $.trim($input.val());
            if (search != "") {
                $td.highlight(search, true);
                $(".highlight").parents("tr").show();
            } else {
                $tbody.find("tr").show();
            }
        }

        $input.keyup(function () {
            loadTabla();
        });

    });
</script>