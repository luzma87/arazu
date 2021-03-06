<%@ page import="arazu.parametros.Color" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<imp:js src="${resource(dir: 'js/plugins/bootstrap-colorpicker/dist/js', file: 'bootstrap-colorpicker.min.js')}"/>
<imp:css src="${resource(dir: 'js/plugins/bootstrap-colorpicker/dist/css', file: 'bootstrap-colorpicker.min.css')}"/>

<g:if test="${!colorInstance}">
    <elm:notFound elem="Color" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmColor" id="${colorInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-6">
                <g:textField name="nombre" required="" class="form-control  required" value="${colorInstance?.nombre}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Hex" claseField="col-sm-6">
                <div class="input-group input-hex">
                    <g:textField name="hex" maxlength="9" class="form-control " value="${colorInstance?.hex}"/>
                    <span class="input-group-addon"><i></i></span>
                </div>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmColor").validate({
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
        $('.input-hex').colorpicker();
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormColor();
                return false;
            }
            return true;
        });
    </script>

</g:else>