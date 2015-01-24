
<%@ page import="arazu.inventario.Bodega" %>

<g:if test="${!bodegaInstance}">
    <elm:notFound elem="Bodega" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${bodegaInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bodegaInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bodegaInstance?.observaciones}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Observaciones
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bodegaInstance}" field="observaciones"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bodegaInstance?.proyecto}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Proyecto
                </div>
                
                <div class="col-sm-4">
                    ${bodegaInstance?.proyecto?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bodegaInstance?.persona}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Persona
                </div>
                
                <div class="col-sm-4">
                    ${bodegaInstance?.persona?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${bodegaInstance?.activo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Activo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${bodegaInstance}" field="activo"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>