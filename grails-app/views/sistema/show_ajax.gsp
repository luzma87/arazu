
<%@ page import="arazu.seguridad.Sistema" %>

<g:if test="${!sistemaInstance}">
    <elm:notFound elem="Sistema" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${sistemaInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${sistemaInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${sistemaInstance?.pathImagen}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Path Imagen
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${sistemaInstance}" field="pathImagen"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${sistemaInstance?.icono}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Icono
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${sistemaInstance}" field="icono"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${sistemaInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${sistemaInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${sistemaInstance?.orden}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Orden
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${sistemaInstance}" field="orden"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>