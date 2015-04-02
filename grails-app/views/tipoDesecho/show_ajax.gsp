
<%@ page import="arazu.parametros.TipoDesecho" %>

<g:if test="${!tipoDesechoInstance}">
    <elm:notFound elem="TipoDesecho" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${tipoDesechoInstance?.codigo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Codigo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoDesechoInstance}" field="codigo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoDesechoInstance?.nombre}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Nombre
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoDesechoInstance}" field="nombre"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${tipoDesechoInstance?.requierePrecio}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Requiere Precio
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoDesechoInstance}" field="requierePrecio"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>