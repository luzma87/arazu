<%@ page import="arazu.solicitudes.DetalleTrabajo" %>
<html>
    <head>
        <g:set var="titleCorto" value="Reporte-MX" scope="request"/>
        <meta name="layout" content="reporte_horizontal"/>

        <title>Reporte de asistencia</title>

        <style type="text/css">
        .row {
            width      : 100%;
            height     : 14px;
            margin-top : 10px;
        }

        .label {
            width       : 3cm;
            font-weight : bold;
        }

        table {
            width           : 100%;
            border-collapse : collapse;
            margin-top      : 15px;
        }

        td {
            padding : 3px;
            border  : 1px solid #fff
        }

        th {
            background-color : #3A5DAA;
            color            : #ffffff;
            font-weight      : bold;
            border           : 1px solid #fff;
            padding          : 3px;
        }

        .text-center {
            text-align : center;
        }

        .cotizacion {
            border : solid 1px #000;
        }

        .cotizacion th, .bodega th {
            background-color : #598235;
        }

        .firma {
            font-weight : bold;
            width       : 20%;
        }

        ul, ul li {
            margin  : 10px;
            padding : 0;
        }

        </style>
    </head>

    <body>
        <table class="table bordered table-condensed table-striped table-bordered table-hover">
            <thead>
                <tr>
                    <th>Proyecto(s)</th>
                    <th>Empleado</th>
                    <g:each in="${tipos}" var="t">
                        <th>${t.nombre}</th>
                    </g:each>
                    <th>Horas extra 50%</th>
                    <th>Horas extra 100%</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${datos}" var="d">
                    <tr>
                        <td>${d.value["proyecto"].join(",")}</td>
                        <td>${d.key.apellido + " " + d.key.nombre}</td>
                        <g:each in="${tipos}" var="t">
                            <td style="text-align: right">${d.value[t.nombre]}</td>
                        </g:each>
                        <td style="text-align: right">${d.value["Horas extra 50%"]}</td>
                        <td style="text-align: right">${d.value["Horas extra 100%"]}</td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </body>
</html>