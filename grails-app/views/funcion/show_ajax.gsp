
<%@ page import="arazu.proyectos.Funcion" %>

<g:if test="${!funcionInstance}">
    <elm:notFound elem="Funcion" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${funcionInstance?.cargo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Cargo
                </div>
                
                <div class="col-sm-4">
                    ${funcionInstance?.cargo?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${funcionInstance?.persona}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Persona
                </div>
                
                <div class="col-sm-4">
                    ${funcionInstance?.persona?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${funcionInstance?.proyecto}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Proyecto
                </div>
                
                <div class="col-sm-4">
                    ${funcionInstance?.proyecto?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>