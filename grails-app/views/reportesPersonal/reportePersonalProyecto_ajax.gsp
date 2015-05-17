<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 16-May-15
  Time: 12:32
--%>

<table class="table table-condensed table-striped table-bordered table-hover">
    <thead>
        <tr>
            <th>Proyecto</th>
            <th>Persona</th>
            <th>Fecha de inicio</th>
            <th>Fecha de fin</th>
        </tr>
    </thead>
    <tbody>
        <g:each in="${personas}" var="personal">
            <tr>
                <td>${personal.proyecto}</td>
                <td>${personal.persona}</td>
                <td>${personal.fechaInicio?.format("dd-MM-yyyy")}</td>
                <td>${personal.fechaFin?.format("dd-MM-yyyy")}</td>
            </tr>
        </g:each>
    </tbody>
</table>
