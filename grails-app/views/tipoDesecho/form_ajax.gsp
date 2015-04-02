<%@ page import="arazu.parametros.TipoDesecho" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoDesechoInstance}">
    <elm:notFound elem="TipoDesecho" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmTipoDesecho" id="${tipoDesechoInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-3" label="Requiere Precio" claseField="col-sm-2">
                <g:select from="[0: 'No', 1: 'Sí']" name="requierePrecio" value="${tipoDesechoInstance.requierePrecio}" class="form-control  required" required=""
                          optionKey="key" optionValue="value"/>
            </elm:fieldRapido>
            <elm:fieldRapido claseLabel="col-sm-3" label="Código" claseField="col-sm-6">
                <g:textField name="codigo" maxlength="2" required="" class="form-control  required unique noEspacios" value="${tipoDesechoInstance?.codigo}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-3" label="Nombre" claseField="col-sm-6">
                <g:textField name="nombre" required="" class="form-control  required" value="${tipoDesechoInstance?.nombre}"/>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmTipoDesecho").validate({
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
                        url  : "${createLink(controller:'tipoDesecho', action: 'validar_unique_codigo_ajax')}",
                        type : "post",
                        data : {
                            id : "${tipoDesechoInstance?.id}"
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
                submitFormTipoDesecho();
                return false;
            }
            return true;
        });
    </script>

</g:else>