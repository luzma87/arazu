<div class="row">
    <div class="col-md-1">
        <label class=" control-label">
            Motivo
        </label>
    </div>

    <div class="col-md-2">
        ${nota.motivoSolicitud.nombre}
    </div>

    <div class="col-md-1">
        <label class=" control-label">
            Número
        </label>
    </div>

    <div class="col-md-2">
        ${nota.numero}
    </div>

    <div class="col-md-1">
        <label class=" control-label">
            Fecha
        </label>
    </div>

    <div class="col-md-3">
        ${nota.fecha?.format("dd-MM-yyyy HH:mm:ss")}
    </div>
</div>

<div class="row">
    <div class="col-md-1">
        <label class=" control-label">
            De
        </label>
    </div>

    <div class="col-md-2">
        ${nota.de}
    </div>

    <g:if test="${nota.firmaJefe}">
        <div class="col-md-1">
            <label class=" control-label">
                Aprobado por
            </label>
        </div>

        <div class="col-md-2">
            ${nota.firmaJefe.persona}
        </div>
    </g:if>

    <g:if test="${nota.firmaJefeCompras}">
        <div class="col-md-1">
            <label class=" control-label">
                Asignado por
            </label>
        </div>

        <div class="col-md-2">
            ${nota.firmaJefeCompras.persona}
        </div>
    </g:if>

    <g:if test="${nota.firmaAsistenteCompras}">
        <div class="col-md-1">
            <label class=" control-label">
                Cotizaciones por
            </label>
        </div>

        <div class="col-md-2">
            ${nota.firmaAsistenteCompras.persona}
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
        ${nota.proyecto}
    </div>

    <div class="col-md-1">
        <label class=" control-label">
            Equipo
        </label>
    </div>

    <div class="col-md-2">
        ${nota.maquinaria}
    </div>
</div>
<g:if test="${nota.observaciones}">
    <div class="row">
        <div class="col-md-1">
            <label class="control-label">
                Observaciones
            </label>
        </div>

        <div class="col-md-11">
            ${nota.observacionesFormat}
        </div>
    </div>
</g:if>

<table class="table table-striped table-hover table-bordered" style="margin-top: 10px">
    <thead>
        <tr>
            <th style="width: 110px">Cantidad</th>
            <th style="width: 150px">Unidad</th>
            <th>Descripción</th>
        </tr>
    </thead>
    <tbody id="tabla-items">
        <tr>
            <td class="cantidad">
                ${nota.cantidad}
                ${nota.cantidadAprobada != 0 ? '(Ap. ' + nota.cantidadAprobada + ')' : ''}
            </td>
            <td style="text-align: center">
                ${nota.unidad}
            </td>
            <td>
                ${nota.item}
            </td>

        </tr>
    </tbody>
</table>

<g:if test="${locked && locked.size() > 0}">
    <div class="alert alert-success">
        <h4>Existencias reservadas:</h4>
        <ul class="fa-ul">
            <g:each in="${locked}" var="l">
                <li>
                    <i class="fa-li fa fa-dropbox"></i>
                    ${l.cantidad}${nota.unidad.codigo} ${nota.item}
                    en la bodega ${l.ingreso.bodega}
                </li>
            </g:each>
        </ul>
    </div>
</g:if>

<g:if test="${existencias.size() > 0}">
    <table class="table table-striped table-hover table-bordered" style="margin-top: 10px">
        <thead>
            <tr>
                <th>Bodega</th>
                <th>Cantidad</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${existencias.values()}" var="ex">
                <tr>
                    <td>
                        ${ex.bodega}
                    </td>
                    <td class="text-right">
                        <g:formatNumber number="${ex.total}" maxFractionDigits="2" minFractionDigits="2"/>${ex.unidad.codigo}
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
</g:if>
<g:else>
    <div class='alert alert-warning'>
        <i class="fa fa-warning fa-2x"></i> No se encontró ${nota.item} en ninguna bodega
    </div>
</g:else>