<%@ page import="arazu.parametros.TipoTrabajo" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoTrabajoInstance}">
    <elm:notFound elem="TipoTrabajo" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmTipoTrabajo" id="${tipoTrabajoInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-6">
                <g:textField name="codigo" maxlength="4" required="" class="form-control  required unique noEspacios" value="${tipoTrabajoInstance?.codigo}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-6">
                <g:textField name="nombre" required="" class="form-control  required" value="${tipoTrabajoInstance?.nombre}"/>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmTipoTrabajo").validate({
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

            , rules  : {

                codigo : {
                    remote : {
                        url  : "${createLink(controller:'tipoTrabajo', action: 'validar_unique_codigo_ajax')}",
                        type : "post",
                        data : {
                            id : "${tipoTrabajoInstance?.id}"
                        }
                    }
                }

            },
            messages : {

                codigo : {
                    remote : "Ya existe Codigo"
                }

            }

        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormTipoTrabajo();
                return false;
            }
            return true;
        });
    </script>

</g:else>