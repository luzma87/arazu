
<%@ page import="arazu.parametros.Unidad" %>

<g:if test="${!unidadInstance}">
    <elm:notFound elem="Unidad" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${unidadInstance?.padre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Padre
                </div>
                
                <div class="col-sm-4">
                    ${unidadInstance?.padre?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${unidadInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${unidadInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${unidadInstance?.conversion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Conversion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${unidadInstance}" field="conversion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${unidadInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${unidadInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>