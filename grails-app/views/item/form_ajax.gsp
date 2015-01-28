<%@ page import="arazu.parametros.TipoItem; arazu.items.Item" %>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
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

            <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-6">
                <g:textArea name="descripcion" cols="40" rows="5" maxlength="500" class="form-control " value="${itemInstance?.descripcion}"/>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
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
    </script>

</g:else>