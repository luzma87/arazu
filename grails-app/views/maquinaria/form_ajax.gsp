<%@ page import="arazu.parametros.Color; arazu.parametros.TipoMaquinaria; arazu.items.Maquinaria" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!maquinariaInstance}">
    <elm:notFound elem="Maquinaria" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmMaquinaria" id="${maquinariaInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapidoDoble claseLabel1="col-sm-4" label1="Tipo" claseField1="col-sm-8"
                                  claseLabel2="col-sm-4" label2="Color" claseField2="col-sm-8">
                <g:select id="tipo" name="tipo.id" from="${TipoMaquinaria.list()}" optionKey="id" required="" value="${maquinariaInstance?.tipo?.id}" class="many-to-one form-control "/>
                <hr/>
                <g:select id="color" name="color.id" from="${Color.list()}" optionKey="id" required="" value="${maquinariaInstance?.color?.id}" class="many-to-one form-control "/>
            </elm:fieldRapidoDoble>

            <elm:fieldRapidoDoble claseLabel1="col-sm-4" label1="Marca" claseField1="col-sm-8"
                                  claseLabel2="col-sm-4" label2="Modelo" claseField2="col-sm-8">
                <g:textField name="marca" maxlength="50" class="form-control " value="${maquinariaInstance?.marca}"/>
                <hr/>
                <g:textField name="modelo" maxlength="50" class="form-control " value="${maquinariaInstance?.modelo}"/>
            </elm:fieldRapidoDoble>

            <elm:fieldRapidoDoble claseLabel1="col-sm-4" label1="Placa" claseField1="col-sm-8"
                                  claseLabel2="col-sm-4" label2="Año" claseField2="col-sm-8">
                <g:textField name="placa" maxlength="20" class="form-control " value="${maquinariaInstance?.placa}"/>
                <hr/>
            %{--<g:textField name="anio" value="${maquinariaInstance.anio}" class="digits form-control  required" required=""/>--}%
                <g:select name="anio" from="${anios}" class="form-control" value="${maquinariaInstance.anio ?: current}"/>
            </elm:fieldRapidoDoble>

            <elm:fieldRapido claseLabel="col-sm-2" label="Descripción" claseField="col-sm-10">
                <g:textArea name="descripcion" cols="40" rows="5" maxlength="255" class="form-control " value="${maquinariaInstance?.descripcion}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Observaciones" claseField="col-sm-10">
                <g:textArea name="observaciones" cols="40" rows="5" maxlength="1023" class="form-control " value="${maquinariaInstance?.observaciones}"/>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
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
    </script>

</g:else>