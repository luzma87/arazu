
<%@ page import="arazu.parametros.Departamento" %>

<g:if test="${!departamentoInstance}">
    <elm:notFound elem="Departamento" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${departamentoInstance?.padre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Padre
                </div>
                
                <div class="col-sm-4">
                    ${departamentoInstance?.padre?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${departamentoInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${departamentoInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${departamentoInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${departamentoInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${departamentoInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${departamentoInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>