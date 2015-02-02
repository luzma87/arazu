<%@ page import="arazu.seguridad.Persona; arazu.proyectos.Proyecto; arazu.inventario.Bodega" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!bodegaInstance}">
    <elm:notFound elem="Bodega" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:set var="maxChars" value="${1023 - bodegaInstance.observaciones.size() - 80}"/>
        <g:set var="maxChars" value="${maxChars <= 0 ? 0 : maxChars}"/>
        <g:form class="form-horizontal" name="frmBodega" id="${bodegaInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-2" label="Proyecto" claseField="col-sm-6">
                <g:select id="proyecto" name="proyecto.id" from="${Proyecto.list()}" optionKey="id" value="${bodegaInstance?.proyecto?.id}" class="many-to-one form-control " noSelection="['null': '']"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Responsable" claseField="col-sm-6">
                <g:select id="persona" name="persona.id" from="${Persona.list()}" optionKey="id" required="" value="${bodegaInstance?.persona?.id}" class="many-to-one form-control "/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Activa" claseField="col-sm-2">
                <g:select name="activo" from="[1: 'Sí', 0: 'No']" class="form-control required" required=""
                          optionKey="key" optionValue="value" value="${bodegaInstance.activo}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Descripción" claseField="col-sm-10">
                <g:textField name="descripcion" maxlength="50" class="form-control " value="${bodegaInstance?.descripcion}"/>
            </elm:fieldRapido>

            <g:if test="${bodegaInstance.observaciones && bodegaInstance.observaciones.trim() != ''}">
                <elm:fieldRapido claseLabel="col-sm-2" label="Observaciones previas" claseField="col-sm-10">
                    <div style="max-height: 150px; overflow-y: auto;">
                        ${bodegaInstance.observaciones}
                    </div>
                </elm:fieldRapido>
            </g:if>

            <g:if test="${maxChars > 0}">
                <elm:fieldRapido claseLabel="col-sm-2" label="Observaciones" claseField="col-sm-10">
                    <g:textArea name="observaciones" cols="40" rows="5" maxlength="${maxChars}" class="form-control " value=""/>
                </elm:fieldRapido>
            </g:if>

        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmBodega").validate({
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
                submitFormBodega();
                return false;
            }
            return true;
        });
    </script>

</g:else>