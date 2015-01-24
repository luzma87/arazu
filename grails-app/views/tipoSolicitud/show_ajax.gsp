
<%@ page import="arazu.parametros.TipoSolicitud" %>

<g:if test="${!tipoSolicitudInstance}">
    <elm:notFound elem="TipoSolicitud" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${tipoSolicitudInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoSolicitudInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoSolicitudInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoSolicitudInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoSolicitudInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoSolicitudInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>