<%@ page import="arazu.proyectos.Funcion" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!funcionInstance}">
    <elm:notFound elem="Funcion" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmFuncion" id="${funcionInstance?.id}"
            role="form" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Cargo" claseField="col-sm-6">
            <g:select id="cargo" name="cargo.id" from="${arazu.parametros.Cargo.list()}" optionKey="id" required="" value="${funcionInstance?.cargo?.id}" class="many-to-one form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Persona" claseField="col-sm-6">
            <g:select id="persona" name="persona.id" from="${arazu.seguridad.Persona.list()}" optionKey="id" required="" value="${funcionInstance?.persona?.id}" class="many-to-one form-control "/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Proyecto" claseField="col-sm-6">
            <g:select id="proyecto" name="proyecto.id" from="${arazu.proyectos.Proyecto.list()}" optionKey="id" required="" value="${funcionInstance?.proyecto?.id}" class="many-to-one form-control "/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmFuncion").validate({
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
                submitFormFuncion();
                return false;
            }
            return true;
        });
    </script>

</g:else>