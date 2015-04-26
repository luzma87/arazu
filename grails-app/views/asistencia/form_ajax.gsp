<%@ page import="arazu.nomina.Asistencia" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!asistenciaInstance}">
    <elm:notFound elem="Asistencia" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmAsistencia" id="${asistenciaInstance?.id}"
            role="form" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Fecha" claseField="col-sm-2">
        <input type="text" name="descripciones" value="${fecha}" class="form-control disabled input-sm" disabled>
        <input type="hidden" name="fecha" value="${fecha}">
       
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Tipo" claseField="col-sm-7">
            <g:select id="tipo" name="tipo.id" from="${arazu.parametros.TipoAsistencia.list()}" optionValue="nombre" optionKey="id" required="" value="${asistenciaInstance?.tipo?.id}" class="many-to-one form-control "/>
        </elm:fieldRapido>       
    
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Empleado" claseField="col-sm-7">
             <input type="text" name="descripciones" value="${empleado.nombre}" class="form-control disabled input-sm" disabled>
             <input type="hidden" name="empleado.id" value="${empleado.id}">
            
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Registra" claseField="col-sm-7">
             
              <input type="text" name="descripciones" value=" ${session.usuario.nombre }" class="form-control disabled input-sm" disabled>
              <input type="hidden" name="registra" value="${session.usuario.id}">
        </elm:fieldRapido>      
       
       
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Observaciones" claseField="col-sm-7">
            <g:textField name="observaciones" required="" class="form-control  required" value="${asistenciaInstance?.observaciones}"/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmAsistencia").validate({
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
                submitFormAsistencia();
                return false;
            }
            return true;
        });
    </script>

</g:else>