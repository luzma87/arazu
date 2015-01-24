
<%@ page import="arazu.parametros.TipoItem" %>

<g:if test="${!tipoItemInstance}">
    <elm:notFound elem="TipoItem" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${tipoItemInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoItemInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoItemInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoItemInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoItemInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoItemInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>