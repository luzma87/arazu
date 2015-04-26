
<%@ page import="arazu.parametros.TipoAsistencia" %>

<g:if test="${!tipoAsistenciaInstance}">
    <elm:notFound elem="TipoAsistencia" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${tipoAsistenciaInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoAsistenciaInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoAsistenciaInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoAsistenciaInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>