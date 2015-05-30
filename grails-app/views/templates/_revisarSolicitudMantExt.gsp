<%@ page import="arazu.solicitudes.DetalleTrabajo" %>
<div class="row">
    <div class="col-md-1">
        <label class=" control-label">
            Código
        </label>
    </div>

    <div class="col-md-2">
        ${solicitud.codigo}
    </div>

    <div class="col-md-1">
        <label class=" control-label">
            Fecha
        </label>
    </div>

    <div class="col-md-3">
        ${solicitud.fecha?.format("dd-MM-yyyy HH:mm:ss")}
    </div>
</div>

<div class="row">
    <div class="col-md-1">
        <label class=" control-label">
            De
        </label>
    </div>

    <div class="col-md-2">
        ${solicitud.de}
    </div>

    <g:if test="${solicitud.firmaJefeCompras}">
        <div class="col-md-1">
            <label class=" control-label">
                Asignado por
            </label>
        </div>

        <div class="col-md-2">
            ${solicitud.firmaJefeCompras.persona}
        </div>
    </g:if>

    <g:if test="${solicitud.firmaAsistenteCompras}">
        <div class="col-md-1">
            <label class=" control-label">
                Cotizaciones por
            </label>
        </div>

        <div class="col-md-2">
            ${solicitud.firmaAsistenteCompras.persona}
        </div>
    </g:if>
</div>

<div class="row">
    <div class="col-md-1">
        <label class=" control-label">
            Proyecto
        </label>
    </div>

    <div class="col-md-2">
        ${solicitud.proyecto}
    </div>

    <div class="col-md-1">
        <label class=" control-label">
            Equipo
        </label>
    </div>

    <div class="col-md-2">
        ${solicitud.maquinaria}
    </div>
</div>

<div class="row">
    <div class="col-md-1">
        <label class=" control-label">
            Trabajos a realizar
        </label>
    </div>

    <div class="col-md-11">
        ${DetalleTrabajo.findAllBySolicitudMantenimientoExterno(solicitud).tipoTrabajo.join(", ")}
    </div>
</div>

<div class="row">
    <div class="col-md-1">
        <label class=" control-label">
            Detalles
        </label>
    </div>

    <div class="col-md-11">
        ${solicitud.detalles}
    </div>
</div>
<g:if test="${solicitud.observaciones}">
    <div class="row">
        <div class="col-md-1">
            <label class="control-label">
                Observaciones
            </label>
        </div>

        <div class="col-md-11">
            ${solicitud.observacionesFormat}
        </div>
    </div>
</g:if>