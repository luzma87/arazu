
<%@ page import="arazu.parametros.TipoMaquinaria" %>

<g:if test="${!tipoMaquinariaInstance}">
    <elm:notFound elem="TipoMaquinaria" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">
    
        <g:if test="${tipoMaquinariaInstance?.codigo}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Código
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoMaquinariaInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoMaquinariaInstance?.nombre}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoMaquinariaInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>

        <g:if test="${tipoMaquinariaInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Descripción
                </div>

                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoMaquinariaInstance}" field="descripcion"/>
                </div>

            </div>
        </g:if>
    
    </div>
</g:else>