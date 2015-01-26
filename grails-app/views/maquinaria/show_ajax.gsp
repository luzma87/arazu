
<%@ page import="arazu.items.Maquinaria" %>

<g:if test="${!maquinariaInstance}">
    <elm:notFound elem="Maquinaria" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${maquinariaInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Descripcion
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${maquinariaInstance}" field="descripcion"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${maquinariaInstance?.observaciones}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Observaciones
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${maquinariaInstance}" field="observaciones"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${maquinariaInstance?.tipo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Tipo
                </div>
                
                <div class="col-sm-4">
                    ${maquinariaInstance?.tipo?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${maquinariaInstance?.placa}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Placa
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${maquinariaInstance}" field="placa"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${maquinariaInstance?.marca}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Marca
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${maquinariaInstance}" field="marca"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${maquinariaInstance?.modelo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Modelo
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${maquinariaInstance}" field="modelo"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${maquinariaInstance?.color}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Color
                </div>
                
                <div class="col-sm-4">
                    ${maquinariaInstance?.color?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${maquinariaInstance?.anio}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Anio
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${maquinariaInstance}" field="anio"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>