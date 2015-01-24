
<%@ page import="arazu.parametros.EstadoSolicitud" %>

<g:if test="${!estadoSolicitudInstance}">
    <elm:notFound elem="EstadoSolicitud" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${estadoSolicitudInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${estadoSolicitudInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${estadoSolicitudInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${estadoSolicitudInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${estadoSolicitudInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${estadoSolicitudInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>