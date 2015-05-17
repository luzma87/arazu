<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 16-May-15
  Time: 18:07
--%>

<table class="table table-condensed table-striped table-bordered table-hover">
    <thead>
        <tr>
            <th>Proyecto</th>
            <th>Persona</th>
            <th>Fecha</th>
            <th>Asistencia</th>
        </tr>
    </thead>
    <tbody>
        <g:each in="${asistencia}" var="a">
            <tr>
                <td>${a.empleado.getProyectoPorFecha(a.fecha)}</td>
                <td>${a.empleado}</td>
                <td>${a.fecha.format("dd-MM-yyyy")}</td>
                <td>${a.tipo}</td>
            </tr>
        </g:each>
    </tbody>
</table>