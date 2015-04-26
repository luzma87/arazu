
<%@ page import="arazu.nomina.Asistencia" %>

<g:if test="${!asistenciaInstance}">
    <elm:notFound elem="Asistencia" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${asistenciaInstance?.fecha}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Fecha
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${asistenciaInstance?.fecha}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${asistenciaInstance?.tipo}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Tipo
                </div>
                
                <div class="col-sm-4">
                    ${asistenciaInstance?.tipo?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${asistenciaInstance?.entrada}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Entrada
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${asistenciaInstance?.entrada}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${asistenciaInstance?.salida}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Salida
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${asistenciaInstance?.salida}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${asistenciaInstance?.empleado}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Empleado
                </div>
                
                <div class="col-sm-4">
                    ${asistenciaInstance?.empleado?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${asistenciaInstance?.registra}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Registra
                </div>
                
                <div class="col-sm-4">
                    ${asistenciaInstance?.registra?.encodeAsHTML()}
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${asistenciaInstance?.fechaRegistro}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Fecha Registro
                </div>
                
                <div class="col-sm-4">
                    <g:formatDate date="${asistenciaInstance?.fechaRegistro}" format="dd-MM-yyyy" />
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${asistenciaInstance?.horas100}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Horas100
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${asistenciaInstance}" field="horas100"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${asistenciaInstance?.horas50}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Horas50
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${asistenciaInstance}" field="horas50"/>
                </div>
                
            </div>
        </g:if>
    
        <g:if test="${asistenciaInstance?.observaciones}">
            <div class="row">
                <div class="col-sm-3 show-label">
                    Observaciones
                </div>
                
                <div class="col-sm-4">
                    <g:fieldValue bean="${asistenciaInstance}" field="observaciones"/>
                </div>
                
            </div>
        </g:if>
    
    </div>
</g:else>