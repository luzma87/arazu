<table class="table table-bordered table-hover table-condensed table-striped">
    <thead>
        <tr>
            <th>#</th>
            <th>Fecha</th>
            <th>Requirente</th>
            <th>Proyecto</th>
            <th>Maquinaria</th>
            <th>Item</th>
            <th>Motivo</th>
            <th>Estado</th>
        </tr>
    </thead>
    <tbody>
        <g:each in="${notas}" var="nota">
            <tr>
                <td>${nota.codigo}</td>
                <td>${nota.fecha.format("dd-MM-yyyy")}</td>
                <td>${nota.de}</td>
                <td>${nota.proyecto}</td>
                <td>${nota.maquinaria}</td>
                <td><g:formatNumber number="${nota.cantidad}" minFractionDigits="2" maxFractionDigits="2"/><b>${nota.unidad.codigo}</b> ${nota.item}
                </td>
                <td>${nota.motivoSolicitud}</td>
                <td>${nota.estadoSolicitud}</td>
            </tr>
        </g:each>
    </tbody>
</table>