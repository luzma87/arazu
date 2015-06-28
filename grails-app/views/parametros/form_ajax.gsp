<%@ page import="arazu.parametros.Parametros" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!parametrosInstance}">
    <elm:notFound elem="Parametros" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmParametros" id="${parametrosInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-4" label="Valor máximo mantenimiento externo" claseField="col-sm-3">
                <div class="input-group">
                    <g:textField name="maxMX" value="${fieldValue(bean: parametrosInstance, field: 'maxMX')}" class="number form-control   required" required=""/>
                    <span class="input-group-addon"><i class="fa fa-usd"></i></span>
                </div>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-4" label="Valor máximo nota de pedido" claseField="col-sm-3">
                <div class="input-group">
                    <g:textField name="maxNP" value="${fieldValue(bean: parametrosInstance, field: 'maxNP')}" class="number form-control   required" required=""/>
                    <span class="input-group-addon"><i class="fa fa-usd"></i></span>
                </div>
            </elm:fieldRapido>

            <hr/>

            <elm:fieldRapidoDoble claseLabel1="col-sm-6" label1="Inicio desayuno" claseField1="col-sm-6"
                                  claseLabel2="col-sm-6" label2="Fin desayuno" claseField2="col-sm-6">
                <elm:datepicker showDate="false" showTime="true" name="horaInicioDesayuno" format="HH:mm" class="form-control"
                                value="${parametrosInstance.horaInicioDesayuno}"/>
                <hr/>
                <elm:datepicker showDate="false" showTime="true" name="horaFinDesayuno" format="HH:mm" class="form-control"
                                value="${parametrosInstance.horaFinDesayuno}"/>
            </elm:fieldRapidoDoble>

            <elm:fieldRapidoDoble claseLabel1="col-sm-6" label1="Inicio almuerzo" claseField1="col-sm-6"
                                  claseLabel2="col-sm-6" label2="Fin almuerzo" claseField2="col-sm-6">
                <elm:datepicker showDate="false" showTime="true" name="horaInicioAlmuerzo" format="HH:mm" class="form-control"
                                value="${parametrosInstance.horaInicioAlmuerzo}"/>
                <hr/>
                <elm:datepicker showDate="false" showTime="true" name="horaFinAlmuerzo" format="HH:mm" class="form-control"
                                value="${parametrosInstance.horaFinAlmuerzo}"/>
            </elm:fieldRapidoDoble>

            <elm:fieldRapidoDoble claseLabel1="col-sm-6" label1="Inicio merienda" claseField1="col-sm-6"
                                  claseLabel2="col-sm-6" label2="Fin merienda" claseField2="col-sm-6">
                <elm:datepicker showDate="false" showTime="true" name="horaInicioMerienda" format="HH:mm" class="form-control"
                                value="${parametrosInstance.horaInicioMerienda}"/>
                <hr/>
                <elm:datepicker showDate="false" showTime="true" name="horaFinMerienda" format="HH:mm" class="form-control"
                                value="${parametrosInstance.horaFinMerienda}"/>
            </elm:fieldRapidoDoble>

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