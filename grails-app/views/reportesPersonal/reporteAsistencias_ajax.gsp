<table class="table table-condensed table-striped table-bordered table-hover">
    <thead>
        <tr>
            <th>Proyecto</th>
            <th>Empleado</th>
            <g:each in="${tipos}" var="t">
                <th>${t.nombre}</th>
            </g:each>
            <th>Horas extra 50%</th>
            <th>Horas extra 100%</th>
            <th>Desayunos</th>
            <th>Almuerzos</th>
            <th>Meriendas</th>
        </tr>
    </thead>
    <tbody>
        <g:set var="proy" value=""/>
        <g:each in="${datos}" var="d">
            <g:if test="${d.key.toString().startsWith("invitado")}">
                <tr>
                    <td>${d.value["proyecto"].join(",")}</td>
                    <td>Invitados</td>
                    <td colspan="9"></td>
                    <td style="text-align: right">${d.value["desayunos"]}</td>
                    <td style="text-align: right">${d.value["almuerzos"]}</td>
                    <td style="text-align: right">${d.value["meriendas"]}</td>
                </tr>
            </g:if>
            <g:else>
                <tr>
                    <td>${d.value["proyecto"].join(",")}</td>
                    <td>${d.key.apellido + " " + d.key.nombre}</td>
                    <g:each in="${tipos}" var="t">
                        <td style="text-align: right">${d.value[t.nombre]}</td>
                    </g:each>
                    <td style="text-align: right">${d.value["Horas extra 50%"]}</td>
                    <td style="text-align: right">${d.value["Horas extra 100%"]}</td>
                    <td style="text-align: right">${d.value["desayunos"]}</td>
                    <td style="text-align: right">${d.value["almuerzos"]}</td>
                    <td style="text-align: right">${d.value["meriendas"]}</td>
                </tr>
            </g:else>
        </g:each>
    </tbody>
</table>