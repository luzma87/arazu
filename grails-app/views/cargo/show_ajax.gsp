
<%@ page import="arazu.parametros.Cargo" %>

<g:if test="${!cargoInstance}">
    <elm:notFound elem="Cargo" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${cargoInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${cargoInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${cargoInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${cargoInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>