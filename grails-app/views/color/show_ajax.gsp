
<%@ page import="arazu.parametros.Color" %>

<g:if test="${!colorInstance}">
    <elm:notFound elem="Color" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${colorInstance?.hex}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Hex
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${colorInstance}" field="hex"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${colorInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${colorInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>