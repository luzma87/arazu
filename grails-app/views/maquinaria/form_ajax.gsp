<%@ page import="arazu.items.Item; arazu.parametros.Color; arazu.parametros.TipoMaquinaria; arazu.items.Maquinaria" %>

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

<g:if test="${!maquinariaInstance}">
    <elm:notFound elem="Maquinaria" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmMaquinaria" id="${maquinariaInstance?.id}"
                role="form" action="save_ajax" method="POST">
            <g:if test="${!maquinariaInstance.id && maquinariaInstance.tipo}">
                <g:hiddenField name="tipo.id" value="${maquinariaInstance.tipoId}"/>
            </g:if>

            <elm:fieldRapidoDoble claseLabel1="col-sm-4" label1="Tipo" claseField1="col-sm-8"
                                  claseLabel2="col-sm-4" label2="Color" claseField2="col-sm-8">
                <g:if test="${!maquinariaInstance.id && maquinariaInstance.tipo}">
                    <p class="form-control-static">${maquinariaInstance.tipo.nombre}</p>
                </g:if>
                <g:else>
                    <g:select id="tipo" name="tipo.id" from="${TipoMaquinaria.list()}" optionKey="id" required="" value="${maquinariaInstance?.tipo?.id}" class="many-to-one form-control "/>
                </g:else>
                <hr/>
                <g:select id="color" name="color.id" from="${Color.list()}" optionKey="id" required=""
                          value="${maquinariaInstance?.color?.id}" class="many-to-one form-control "/>
            </elm:fieldRapidoDoble>

            <elm:fieldRapidoDoble claseLabel1="col-sm-4" label1="Marca" claseField1="col-sm-8"
                                  claseLabel2="col-sm-4" label2="Año" claseField2="col-sm-8">
                <g:textField name="marca" maxlength="50" class="form-control " value="${maquinariaInstance?.marca}"/>
                <hr/>
                <g:select name="anio" from="${anios}" class="form-control" data-size="6" value="${maquinariaInstance.anio ?: current}"/>
            </elm:fieldRapidoDoble>

            <elm:fieldRapidoDoble claseLabel1="col-sm-4" label1="Placa" claseField1="col-sm-8"
                                  claseLabel2="col-sm-4" label2="Código" claseField2="col-sm-8">
                <g:textField name="placa" maxlength="20" class="form-control allCaps placa" value="${maquinariaInstance?.placa}"/>
                <hr/>
                <g:textField name="codigo" maxlength="50" class="form-control " value="${maquinariaInstance?.codigo}"/>
            </elm:fieldRapidoDoble>

            <elm:fieldRapido claseLabel="col-sm-2" label="Modelo" claseField="col-sm-10">
                <g:textField name="modelo" maxlength="50" class="form-control " value="${maquinariaInstance?.modelo}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Descripción" claseField="col-sm-10">
                <g:textArea name="descripcion" cols="40" rows="3" maxlength="255" class="form-control " value="${maquinariaInstance?.descripcion}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Observaciones" claseField="col-sm-10">
                <g:textArea name="observaciones" cols="40" rows="3" maxlength="1023" class="form-control " value="${maquinariaInstance?.observaciones}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Items" claseField="col-sm-10">
                <div class="row no-margin-top noMargin bg-success">
                    <div class="col-sm-5">
                        <g:select name="item" from="${Item.list([sort: 'descripcion'])}" class="form-control input-sm"
                                  optionKey="id" optionValue="descripcion"/>
                    </div>

                    <div class="col-sm-2">
                        <a href="#" class="btn btn-success btn-sm" id="btn-addItem" title="Agregar item">
                            <i class="fa fa-plus"></i>
                        </a>
                    </div>
                </div>

                <div class="row no-margin-top noMargin scroll">
                    <div class="col-md-6">
                        <table id="tblItems" class="table table-hover table-bordered table-condensed">
                            <g:each in="${items.item}" var="item">
                                <tr class="items" data-id="${item.id}">
                                    <td>
                                        ${item.descripcion}
                                    </td>
                                    <td width="35">
                                        <a href="#" class="btn btn-danger btn-xs btn-deleteItem">
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

            $("#btn-addItem").click(function () {
                var $item = $("#item");
                var idItemAdd = $item.val();
                $(".items").each(function () {
                    if ($(this).data("id") == idItemAdd) {
                        $(this).remove();
                    }
                });
                var $tabla = $("#tblItems");

                var $tr = $("<tr>");
                $tr.addClass("items");
                $tr.data("id", idItemAdd);
                var $tdNombre = $("<td>");
                $tdNombre.text($item.find("option:selected").text());
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
            $(".btn-deleteItem").click(function () {
                $(this).parents("tr").remove();
                return false;
            });

            var validator = $("#frmMaquinaria").validate({
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
                    submitFormMaquinaria();
                    return false;
                }
                return true;
            });
        });
    </script>

</g:else>