<%@ page import="arazu.inventario.Bodega" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!bodegaInstance}">
    <elm:notFound elem="Bodega" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmBodega" id="${bodegaInstance?.id}"
            role="form" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-6">
            <g:textField name="descripcion" maxlength="50" class="form-control " value="${bodegaInstance?.descripcion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Observaciones" claseField="col-sm-6">
            <g:textArea name="observaciones" cols="40" rows="5" maxlength="1023" class="form-control " value="${bodegaInstance?.observaciones}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Proyecto" claseField="col-sm-6">
            <g:select id="proyecto" name="proyecto.id" from="${arazu.proyectos.Proyecto.list()}" optionKey="id" value="${bodegaInstance?.proyecto?.id}" class="many-to-one form-control " noSelection="['null': '']"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Persona" claseField="col-sm-6">
            <g:select id="persona" name="persona.id" from="${arazu.seguridad.Persona.list()}" optionKey="id" required="" value="${bodegaInstance?.persona?.id}" class="many-to-one form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Activo" claseField="col-sm-2">
            <g:textField name="activo" value="${bodegaInstance.activo}" class="digits form-control  required" required=""/>
        </elm:fieldRapido>
        
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