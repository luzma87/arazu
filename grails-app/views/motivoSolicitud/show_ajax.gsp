
<%@ page import="arazu.parametros.MotivoSolicitud" %>

<g:if test="${!motivoSolicitudInstance}">
    <elm:notFound elem="MotivoSolicitud" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${motivoSolicitudInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${motivoSolicitudInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${motivoSolicitudInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${motivoSolicitudInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>