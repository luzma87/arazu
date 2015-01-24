<%@ page import="arazu.parametros.EstadoSolicitud" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!estadoSolicitudInstance}">
    <elm:notFound elem="EstadoSolicitud" genero="o" />
</g:if>
<g:else>
    
    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmEstadoSolicitud" id="${estadoSolicitudInstance?.id}"
            role="form" action="save_ajax" method="POST">

        
        <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-6">
            <g:textField name="descripcion" class="form-control " value="${estadoSolicitudInstance?.descripcion}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-6">
            <g:textField name="codigo" maxlength="4" required="" class="form-control  required unique noEspacios" value="${estadoSolicitudInstance?.codigo}"/>
        </elm:fieldRapido>
        
        <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-6">
            <g:textField name="nombre" required="" class="form-control  required" value="${estadoSolicitudInstance?.nombre}"/>
        </elm:fieldRapido>
        
    </g:form>
        </div>

    <script type="text/javascript">
        var validator = $("#frmEstadoSolicitud").validate({
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
            
            , rules          : {
                
                codigo: {
                    remote: {
                        url: "${createLink(controller:'estadosolicitud', action: 'validar_unique_codigo_ajax')}",
                        type: "post",
                        data: {
                            id: "${estadoSolicitudInstance?.id}"
                        }
                    }
                }
                
            },
            messages : {
                
                codigo: {
                    remote: "Ya existe Codigo"
                }
                
            }
            
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormEstadoSolicitud();
                return false;
            }
            return true;
        });
    </script>

</g:else>