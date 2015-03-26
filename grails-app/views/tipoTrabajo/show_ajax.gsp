
<%@ page import="arazu.parametros.TipoTrabajo" %>

<g:if test="${!tipoTrabajoInstance}">
    <elm:notFound elem="TipoTrabajo" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${tipoTrabajoInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoTrabajoInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoTrabajoInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoTrabajoInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>