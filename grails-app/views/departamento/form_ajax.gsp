<%@ page import="arazu.parametros.Departamento" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!departamentoInstance}">
    <elm:notFound elem="Departamento" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmDepartamento" id="${departamentoInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-2" label="Padre" claseField="col-sm-6">
                <g:select id="padre" name="padre.id"
                          from="${departamentoInstance.id ? Departamento.findAllByIdNotEqualAndActivo(departamentoInstance.id, 1, [sort: 'nombre']) : Departamento.findAllByActivo(1, [sort: 'nombre'])}"
                          optionKey="id" value="${departamentoInstance?.padre?.id}" class="many-to-one form-control "
                          noSelection="['null': '- Sin padre -']"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Código" claseField="col-sm-6">
                <g:textField name="codigo" maxlength="4" required="" class="form-control  required unique noEspacios" value="${departamentoInstance?.codigo}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-6">
                <g:textField name="nombre" maxlength="25" required="" class="form-control  required" value="${departamentoInstance?.nombre}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Descripción" claseField="col-sm-6">
                <g:textArea cols="5" rows="5" maxlength="127" name="descripcion" class="form-control " value="${departamentoInstance?.descripcion}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Activo" claseField="col-sm-2">
                <g:select name="activo" from="[1: 'Sí', 0: 'No']" optionKey="key" optionValue="value" value="${departamentoInstance?.activo}"
                          class="form-control "/>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmDepartamento").validate({
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

            , rules        : {

                codigo : {
                    remote : {
                        url  : "${createLink(controller:'departamento', action: 'validar_unique_codigo_ajax')}",
                        type : "post",
                        data : {
                            id : "${departamentoInstance?.id}"
                        }
                    }
                }

            },
            messages       : {

                codigo : {
                    remote : "Ya existe Codigo"
                }

            }

        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormDepartamento();
                return false;
            }
            return true;
        });
    </script>

</g:else>