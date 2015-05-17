<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 16-May-15
  Time: 17:46
--%>

<%@ page import="arazu.solicitudes.DetalleTrabajo" %>
<html>
    <head>
        <g:set var="titleCorto" value="Reporte-MX" scope="request"/>
        <meta name="layout" content="reporte_horizontal"/>

        <title>Reporte de solicitudes de mantenimiento externo</title>

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
        <table class="bordered">
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
    </body>
</html>