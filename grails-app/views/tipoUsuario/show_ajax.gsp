
<%@ page import="arazu.parametros.TipoUsuario" %>

<g:if test="${!tipoUsuarioInstance}">
    <elm:notFound elem="TipoUsuario" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${tipoUsuarioInstance?.padre}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Padre
                </div>
                
                <div class="col-sm-4">
                    ${tipoUsuarioInstance?.padre?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>

        <g:if test="${tipoUsuarioInstance?.codigo}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Código
                </div>

                <div class="col-sm-4">
                    <g:fieldValue bean="${tipoUsuarioInstance}" field="codigo"/>
                </div>

            </div>
        </g:if>

        <g:if test="${tipoUsuarioInstance?.nombre}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Nombre
                </div>

                <div class="col-sm-8">
                    <g:fieldValue bean="${tipoUsuarioInstance}" field="nombre"/>
                </div>

            </div>
        </g:if>
    
        <g:if test="${tipoUsuarioInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Descripción
                </div>
                
                <div class="col-sm-10">
                    <g:fieldValue bean="${tipoUsuarioInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>