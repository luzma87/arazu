<%@ page import="arazu.parametros.Parametros" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!parametrosInstance}">
    <elm:notFound elem="Parametros" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmParametros" id="${parametrosInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-2" label="Max MX" claseField="col-sm-3">
                <div class="input-group">
                    <g:textField name="maxMX" value="${fieldValue(bean: parametrosInstance, field: 'maxMX')}" class="number form-control   required" required=""/>
                    <span class="input-group-addon"><i class="fa fa-usd"></i></span>
                </div>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Max NP" claseField="col-sm-3">
                <div class="input-group">
                    <g:textField name="maxNP" value="${fieldValue(bean: parametrosInstance, field: 'maxNP')}" class="number form-control   required" required=""/>
                    <span class="input-group-addon"><i class="fa fa-usd"></i></span>
                </div>
            </elm:fieldRapido>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmParametros").validate({
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
                submitFormParametros();
                return false;
            }
            return true;
        });
    </script>

</g:else>