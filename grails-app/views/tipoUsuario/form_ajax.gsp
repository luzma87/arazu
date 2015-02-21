<%@ page import="arazu.parametros.TipoUsuario" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoUsuarioInstance}">
    <elm:notFound elem="Tipo de Usuario" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmTipoUsuario" id="${tipoUsuarioInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <g:if test="${tipoUsuarioInstance.id}">
                <g:hiddenField name="codigo" value="${tipoUsuarioInstance.codigo}"/>
            </g:if>

            <elm:fieldRapido claseLabel="col-sm-2" label="Padre" claseField="col-sm-6">
                <g:select id="padre" name="padre.id"
                          from="${tipoUsuarioInstance.id ? TipoUsuario.findAllByIdNotEqualAndActivo(tipoUsuarioInstance.id, 1, [sort: 'nombre']) : TipoUsuario.findAllByActivo(1, [sort: 'nombre'])}"
                          optionKey="id" value="${tipoUsuarioInstance?.padre?.id}" class="many-to-one form-control "
                          noSelection="['null': '- Sin padre -']"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Código" claseField="col-sm-6">
                <g:if test="${tipoUsuarioInstance.id}">
                    <p class="form-control-static">
                        ${tipoUsuarioInstance.codigo}
                    </p>
                </g:if>
                <g:else>
                    <g:textField name="codigo" maxlength="4" minlength="4" required="" class="form-control allCaps required unique noEspacios" value="${tipoUsuarioInstance?.codigo}"/>
                </g:else>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-6">
                <g:textField name="nombre" maxlength="25" required="" class="form-control  required" value="${tipoUsuarioInstance?.nombre}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Descripción" claseField="col-sm-6">
                <g:textArea cols="5" rows="5" maxlength="127" name="descripcion" class="form-control " value="${tipoUsuarioInstance?.descripcion}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Activo" claseField="col-sm-2">
                <g:select name="activo" from="[1: 'Sí', 0: 'No']" optionKey="key" optionValue="value"
                          value="${tipoUsuarioInstance?.activo == 0 ? 0 : 1}"
                          class="form-control "/>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmTipoUsuario").validate({
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
            }, rules       : {

                codigo : {
                    remote : {
                        url  : "${createLink(controller:'tipoUsuario', action: 'validar_unique_codigo_ajax')}",
                        type : "post",
                        data : {
                            id : "${tipoUsuarioInstance?.id}"
                        }
                    }
                }

            },
            messages       : {

                codigo : {
                    remote : "Ya existe el Código"
                }

            }

        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormTipoUsuario();
                return false;
            }
            return true;
        });
    </script>

</g:else>