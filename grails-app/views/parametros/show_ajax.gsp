
<%@ page import="arazu.parametros.Parametros" %>

<g:if test="${!parametrosInstance}">
    <elm:notFound elem="Parametros" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${parametrosInstance?.maxMX}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Max MX
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${parametrosInstance}" field="maxMX"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${parametrosInstance?.maxNP}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Max NP
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${parametrosInstance}" field="maxNP"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>