<%@ page import="arazu.items.Maquinaria; arazu.parametros.TipoItem; arazu.items.Item" %>
<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<style type="text/css">
.scroll {
    height        : 100px;
    overflow-y    : auto;
    overflow-x    : hidden;
    border-bottom : solid 1px #ddd;
    border-left   : solid 1px #ddd;
    border-right  : solid 1px #ddd;
}

.noMargin {
    padding : 3px;
}
</style>

<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<g:if test="${!itemInstance}">
    <elm:notFound elem="Item" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmItem" id="${itemInstance?.id}"
                role="form" action="save_ajax" method="POST">
            <g:if test="${!itemInstance.id && itemInstance.tipo}">
                <g:hiddenField name="tipo.id" value="${itemInstance.tipoId}"/>
            </g:if>

            <elm:fieldRapido claseLabel="col-sm-2" label="Tipo" claseField="col-sm-6">
                <g:if test="${!itemInstance.id && itemInstance.tipo}">
                    <p class="form-control-static">${itemInstance.tipo.nombre}</p>
                </g:if>
                <g:else>
                    <g:select id="tipo" name="tipo.id" from="${TipoItem.list()}" optionKey="id" required="" value="${itemInstance?.tipo?.id}" class="many-to-one form-control required"/>
                </g:else>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Descripción" claseField="col-sm-6">
                <g:textArea name="descripcion" cols="40" rows="5" maxlength="500" class="form-control " value="${itemInstance?.descripcion}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Maquinarias" claseField="col-sm-8">
                <div class="row no-margin-top noMargin bg-success">
                    <div class="col-sm-5">
                        <g:select name="maquina" from="${Maquinaria.list([sort: 'descripcion'])}" class="form-control input-sm"
                                  optionKey="id" optionValue="descripcion"/>
                    </div>

                    <div class="col-sm-2">
                        <a href="#" class="btn btn-success btn-sm" id="btn-addMaquina" title="Agregar maquinaria">
                            <i class="fa fa-plus"></i>
                        </a>
                    </div>
                </div>

                <div class="row no-margin-top noMargin scroll">
                    <div class="col-md-6">
                        <table id="tblMaquinas" class="table table-hover table-bordered table-condensed">
                            <g:each in="${maquinas.maquinaria}" var="maquina">
                                <tr class="maquinas" data-id="${maquina.id}">
                                    <td>
                                        ${maquina.descripcion}
                                    </td>
                                    <td width="35">
                                        <a href="#" class="btn btn-danger btn-xs btn-deleteMaquina">
                                            <i class="fa fa-trash-o"></i>
                                        </a>
                                    </td>
                                </tr>
                            </g:each>
                        </table>
                    </div>
                </div>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
        $(function () {
            $("#btn-addMaquina").click(function () {
                var $maquina = $("#maquina");
                var idMaquinaAdd = $maquina.val();
                $(".maquinas").each(function () {
                    if ($(this).data("id") == idMaquinaAdd) {
                        $(this).remove();
                    }
                });
                var $tabla = $("#tblMaquinas");

                var $tr = $("<tr>");
                $tr.addClass("maquinas");
                $tr.data("id", idMaquinaAdd);
                var $tdNombre = $("<td>");
                $tdNombre.text($maquina.find("option:selected").text());
                var $tdBtn = $("<td>");
                $tdBtn.attr("width", "35");
                var $btnDelete = $("<a>");
                $btnDelete.addClass("btn btn-danger btn-xs");
                $btnDelete.html("<i class='fa fa-trash-o'></i> ");
                $tdBtn.append($btnDelete);

                $btnDelete.click(function () {
                    $tr.remove();
                    return false;
                });

                $tr.append($tdNombre).append($tdBtn);

                $tabla.prepend($tr);
                $tr.effect("highlight");

                return false;
            });
            $(".btn-deleteMaquina").click(function () {
                $(this).parents("tr").remove();
                return false;
            });

            var validator = $("#frmItem").validate({
                errorClass     : "help-block",
                errorPlacement : function (error, element) {
                    if (element.parent().hasClass("input-group")) {
                        error.insertAfter(element.parent());
                    } else {
                        error.insertAfter(element);
                    }
                    element.parents(".grupo").addClass('has-error');
                },
                success        : function (label) {
                    label.parents(".grupo").removeClass('has-error');
                    label.remove();
                }

            });
            $(".form-control").keydown(function (ev) {
                if (ev.keyCode == 13) {
                    submitFormItem();
                    return false;
                }
                return true;
            });
        });
    </script>

</g:else>