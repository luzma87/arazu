<%@ page import="arazu.parametros.Cargo" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!cargoInstance}">
    <elm:notFound elem="Cargo" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmCargo" id="${cargoInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-2" label="Código" claseField="col-sm-6">
                <g:textField name="codigo" maxlength="4" class="form-control  unique noEspacios" value="${cargoInstance?.codigo}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Descripción" claseField="col-sm-6">
                <g:textField name="descripcion" maxlength="63" required="" class="form-control  required" value="${cargoInstance?.descripcion}"/>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmCargo").validate({
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
                        url  : "${createLink(controller:'cargo', action: 'validar_unique_codigo_ajax')}",
                        type : "post",
                        data : {
                            id : "${cargoInstance?.id}"
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
                submitFormCargo();
                return false;
            }
            return true;
        });
    </script>

</g:else>