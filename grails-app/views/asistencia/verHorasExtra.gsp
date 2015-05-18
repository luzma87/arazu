<!DOCTYPE html>
<%@ page import="arazu.nomina.Asistencia" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Registro de horas extra</title>
    <style type="text/css">
    .empleado {
        background  : #3A5DAA;
        color       : white;
        font-weight : bold;
    }

    .actual {
        background : none;
        cursor     : pointer;
    }

    .NAST {
        background : #FFA324 !important;
        color      : white;
    }

    .ASTE {
        background : #82A640 !important;
        color      : white;
        text-align : center !important;
    }
    .VCAN {
        background : #2b96a6 !important;
        color      : white;
    }
    .VCJN {
        background : #a583a6 !important;
        color      : white;
    }

    td {
        width : 50px !important;
    }

    .number {
        text-align : right !important;
    }

    .table-striped > tbody > tr:nth-of-type(odd) > td.disabled {
        background : #c9c9c9;
    }
    </style>
</head>

<body>
<elm:container tipo="horizontal" titulo="Registro de horas extra">
    <div class="row">
        <div class="col-md-12" style="overflow-x: auto">
            <table class="table table-condensed table-bordered table-hover table-striped" style="font-size: 11px">
                <thead>
                <tr>
                    <th colspan="${(max - min + 2) * 2}">
                        ${now.format("MMMM-yyyy").toUpperCase()}
                    </th>
                </tr>
                <tr>
                    <th>Empleado</th>
                    <g:each in="${min..max}" var="i" status="j">
                        <th colspan="2">
                            ${i}
                        </th>
                    </g:each>

                </tr>
                <tr>
                    <th></th>
                    <g:each in="${min..max}" var="i" status="j">
                        <th>50</th>
                        <th>100</th>
                    </g:each>
                </tr>
                </thead>
                <tbody>

                <g:each in="${empleados}" var="empleado">
                    <tr>
                        <td class="empleado">
                            ${empleado.nombre} ${empleado.apellido}
                        </td>
                        <g:each in="${min..max}" var="i" status="j">
                            <g:set var="fecha"
                                   value="${(i < dia) ? now.minus(dia - i) : now.plus(i - dia)}"/>
                            <g:set var="asistencia"
                                   value="${Asistencia.findByEmpleadoAndFecha(empleado, fecha.clearTime())}"/>
                            <g:if test="${asistencia}">
                                <g:if test="${i <= dia}">
                                    <g:if test="${asistencia.tipo.codigo == 'ASTE'}">
                                        <td class="${i == dia ? 'actual iterador' : 'disabled'} ${asistencia ? asistencia.tipo.codigo : ''}">
                                            ${asistencia.horas50}
                                        <td class="${i == dia ? 'actual complemento' : 'disabled'} ${asistencia ? asistencia.tipo.codigo : ''}">
                                            ${asistencia.horas100}
                                        </td>
                                    </g:if>
                                    <g:else>
                                        <td colspan="2">

                                        </td>
                                    </g:else>
                                </g:if>
                                <g:else>
                                    <td style="text-align: right">${asistencia.horas50}</td>
                                    <td style="text-align: right">${asistencia.horas100}</td>
                                </g:else>

                            </g:if>
                            <g:else>
                                <td colspan="2"></td>
                            </g:else>

                        </g:each>

                    </tr>

                </g:each>
                </tbody>
            </table>
        </div>
    </div>

</elm:container>

<script type="text/javascript">


</script>
</body>
</html>