<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 3/21/2015
  Time: 1:16 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Egresos sin ingreso de desecho</title>
    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Egresos sin ingreso de desecho">
            <table class="table table-bordered table-striped table-condensed table-hover" style="margin-top: 15px;">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Item</th>
                        <th>Responsable</th>
                        <th>Bodega</th>
                        <th>Responsables de bodega</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${egresos}" var="egreso">
                        <tr>
                            <td><g:formatDate date="${egreso.fecha}" format="dd-MM-yyyy HH:mm"/></td>
                            <td>${egreso.cantidad} ${egreso.ingreso.item} ${egreso.ingreso.unidad.codigo}</td>
                            <td>${egreso.persona}</td>
                            <td>${egreso.ingreso.bodega}</td>
                            <td>${egreso.ingreso.bodega.responsable}
                                ${egreso.ingreso.bodega.suplente ? ', ' + egreso.ingreso.bodega.suplente : ''}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </elm:container>
    </body>
</html>