<html>
    <head>
        <g:set var="titleCorto" value="Reporte-NP" scope="request"/>
        <meta name="layout" content="reporte_horizontal"/>

        <title>Reporte de notas de pedido</title>

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
    </body>
</html>