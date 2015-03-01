<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Nota de pedido</title>
        <rep:estilos orientacion="p" pagTitle="Nota de pedido #${nota.numero}"/>
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

        .cotizacion, .bodega {
            border : solid 1px #000;
        }

        .cotizacion th, .bodega th {
            background-color : #598235;
        }

        .firma {
            font-weight : bold;
            width       : 20%;
        }

        </style>
    </head>

    <body>

        <rep:headerFooter title="Nota de pedido #${nota.numero}"/>

        %{--Datos--}%
        <table>
            <tbody>
                <tr>
                    <td class="label">Tipo</td>
                    <td>${nota.tipoSolicitud.descripcion}</td>

                    <td class="label">Fecha</td>
                    <td>${nota.fecha.format("dd-MM-yyyy hh:mm:ss")}</td>
                </tr>
                <tr>
                    <g:if test="${nota.proyecto}">
                        <td class="label">Proyecto</td>
                        <td>${nota.proyecto.nombre}</td>
                    </g:if>

                    <td class="label">Equipo</td>
                    <td>${nota.maquinaria}</td>
                </tr>
                <tr>
                    <td class="label">Observaciones</td>
                    <td colspan="3">${nota.observacionesFormat}</td>
                </tr>
            </tbody>
        </table>

        %{--Datos pedido--}%
        <div class="row" style="margin-top: 20px">
            Solicito se digne disponer se despache las especies que constan a continuación
        </div>
        <table style="margin-top: 10px;">
            <thead>
                <tr>
                    <th>Cantidad</th>
                    <th>Unidad</th>
                    <th>Descripción</th>
                </tr>
            </thead>
            <tbody>
                <tr class="odd">
                    <td>
                        ${nota.cantidad.toInteger()}
                        <g:if test="${nota.cantidad != nota.cantidadAprobada}">
                            (Aprobado ${nota.cantidadAprobada})
                        </g:if>
                    </td>
                    <td>
                        ${nota.unidad}
                    </td>
                    <td>
                        ${nota.item.descripcion}
                    </td>

                </tr>
            </tbody>
        </table>

    %{--Cotizaciones--}%
        <g:each in="${cots}" var="cot" status="i">
            <table class="cotizacion" border="1">
                <tr>
                    <th colspan="2">
                        Cotización #${i + 1}
                    </th>
                    <th style="text-align: right;">
                        ${cot.fecha.format("dd-MM-yyyy HH:mm")}
                    </th>
                    <th style="text-align: right; width: 2cm;">
                        <g:if test="${cot.estadoSolicitud.codigo == 'A01' || cot.estadoSolicitud.codigo == 'N01'}">
                            ${cot.estadoSolicitud}
                        </g:if>
                    </th>
                </tr>
                <tr>
                    <td class="label">Proveedor</td>
                    <td>${cot.proveedor}</td>

                    <td class="label">Entrega</td>
                    <td>${cot.diasEntrega} días</td>
                </tr>
                <tr>
                    <td class="label">P. Unitario</td>
                    <td><g:formatNumber number="${cot.valor}" type="currency"/></td>

                    <td class="label">Total</td>
                    <td><g:formatNumber number="${cot.valor * nota.cantidad}" type="currency"/></td>
                </tr>
            </table>
        </g:each>

    %{--Existencias en bodega--}%
        <h4>Existencias en bodegas</h4>
        <g:if test="${bodegas.size() > 0}">
            <table class="bodega">
                <thead>
                    <tr>
                        <th>Bodega</th>
                        <th>Cantidad</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${bodegas}" var="bodega">
                        <tr>
                            <td>${bodega.bodega}</td>
                            <td style="text-align: right;">${bodega.cantidad}${bodega.pedido.unidad.codigo}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </g:if>

    %{--Personas--}%
    %{--<table>--}%
    %{--<tbody>--}%
    %{--<g:if test="${nota.firmaAprueba}">--}%
    %{--<tr>--}%
    %{--<td class="label">Aprueba</td>--}%
    %{--<td>${nota.firmaAprueba.persona}</td>--}%
    %{--</tr>--}%
    %{--</g:if>--}%
    %{--</tbody>--}%
    %{--</table>--}%

    %{--Firmas--}%
        <g:set var="sigue" value="${true}"/>
        <table>
            <tbody>
                <tr>
                    <td class="text-center">
                        <img src="${resource(dir: 'firmas', file: nota.firmaSolicita.path)}" height="100"/>
                    </td>
                    <td class="text-center">
                        <g:if test="${nota.firmaJefe}">
                            <img src="${resource(dir: 'firmas', file: nota.firmaJefe.path)}" height="100"/>
                        </g:if>
                        <g:elseif test="${nota.firmaNiega}">
                            <img src="${resource(dir: 'firmas', file: nota.firmaNiega.path)}" height="100"/>
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                        <g:elseif test="${nota.firmaBodega}">
                            <img src="${resource(dir: 'firmas', file: nota.firmaBodega.path)}" height="100"/>
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                    </td>
                    <td class="text-center">
                        <g:if test="${nota.firmaJefeCompras}">
                            <img src="${resource(dir: 'firmas', file: nota.firmaJefeCompras.path)}" height="100"/>
                        </g:if>
                        <g:elseif test="${sigue && nota.firmaNiega}">
                            <img src="${resource(dir: 'firmas', file: nota.firmaNiega.path)}" height="100"/>
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                        <g:elseif test="${sigue && nota.firmaBodega}">
                            <img src="${resource(dir: 'firmas', file: nota.firmaBodega.path)}" height="100"/>
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                    </td>
                    <td class="text-center">
                        <g:if test="${nota.firmaAsistenteCompras}">
                            <img src="${resource(dir: 'firmas', file: nota.firmaAsistenteCompras.path)}" height="100"/>
                        </g:if>
                        <g:elseif test="${sigue && nota.firmaNiega}">
                            <img src="${resource(dir: 'firmas', file: nota.firmaNiega.path)}" height="100"/>
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                        <g:elseif test="${sigue && nota.firmaBodega}">
                            <img src="${resource(dir: 'firmas', file: nota.firmaBodega.path)}" height="100"/>
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                    </td>
                    <td class="text-center">
                        <g:if test="${nota.firmaAprueba}">
                            <img src="${resource(dir: 'firmas', file: nota.firmaAprueba.path)}" height="100"/>
                        </g:if>
                        <g:elseif test="${sigue && nota.firmaNiega}">
                            <img src="${resource(dir: 'firmas', file: nota.firmaNiega.path)}" height="100"/>
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                        <g:elseif test="${sigue && nota.firmaBodega}">
                            <img src="${resource(dir: 'firmas', file: nota.firmaBodega.path)}" height="100"/>
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                    </td>
                </tr>
                <tr>
                    <g:set var="sigue" value="${true}"/>
                    <td class="text-center">
                        ${nota.de}
                    </td>
                    <td class="text-center">
                        <g:if test="${nota.firmaJefe}">
                            ${nota.firmaJefe.persona}
                        </g:if>
                        <g:elseif test="${nota.firmaNiega}">
                            ${nota.firmaNiega.persona}
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                        <g:elseif test="${nota.firmaBodega}">
                            ${nota.firmaBodega.persona}
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                    </td>
                    <td class="text-center">
                        <g:if test="${nota.firmaJefeCompras}">
                            ${nota.firmaJefeCompras.persona}
                        </g:if>
                        <g:elseif test="${sigue && nota.firmaNiega}">
                            ${nota.firmaNiega.persona}
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                        <g:elseif test="${sigue && nota.firmaBodega}">
                            ${nota.firmaBodega.persona}
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                    </td>
                    <td class="text-center">
                        <g:if test="${nota.firmaAsistenteCompras}">
                            ${nota.firmaAsistenteCompras.persona}
                        </g:if>
                        <g:elseif test="${sigue && nota.firmaNiega}">
                            ${nota.firmaNiega.persona}
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                        <g:elseif test="${sigue && nota.firmaBodega}">
                            ${nota.firmaBodega.persona}
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                    </td>
                    <td class="text-center">
                        <g:if test="${nota.firmaAprueba}">
                            ${nota.firmaAprueba.persona}
                        </g:if>
                        <g:elseif test="${sigue && nota.firmaNiega}">
                            ${nota.firmaNiega.persona}
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                        <g:elseif test="${sigue && nota.firmaBodega}">
                            ${nota.firmaBodega.persona}
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                    </td>
                </tr>
                <tr>
                    <g:set var="sigue" value="${true}"/>
                    <td class="text-center firma">
                        Solicita
                    </td>
                    <td class="text-center firma">
                        <g:if test="${nota.firmaJefe}">
                            Aprueba (${nota.firmaJefe.persona.tipoUsuario})
                        </g:if>
                        <g:elseif test="${nota.firmaNiega}">
                            Niega (${nota.firmaNiega.persona.tipoUsuario})
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                        <g:elseif test="${nota.firmaBodega}">
                            Notifica existencia en bodega (${nota.firmaBodega.persona.tipoUsuario})
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                    </td>
                    <td class="text-center firma">
                        <g:if test="${nota.firmaJefeCompras}">
                            Aprueba (${nota.firmaJefeCompras.persona.tipoUsuario})
                        </g:if>
                        <g:elseif test="${sigue && nota.firmaNiega}">
                            Niega (${nota.firmaNiega.persona.tipoUsuario}
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                        <g:elseif test="${sigue && nota.firmaBodega}">
                            Notifica existencia en bodega (${nota.firmaBodega.persona.tipoUsuario})
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                    </td>
                    <td class="text-center firma">
                        <g:if test="${nota.firmaAsistenteCompras}">
                            Aprueba (${nota.firmaAsistenteCompras.persona.tipoUsuario})
                        </g:if>
                        <g:elseif test="${sigue && nota.firmaNiega}">
                            Niega (${nota.firmaNiega.persona.tipoUsuario})
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                        <g:elseif test="${sigue && nota.firmaBodega}">
                            Notifica existencia en bodega (${nota.firmaBodega.persona.tipoUsuario})
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                    </td>
                    <td class="text-center firma">
                        <g:if test="${nota.firmaAprueba}">
                            Aprueba (${nota.firmaAprueba.persona.tipoUsuario})
                        </g:if>
                        <g:elseif test="${sigue && nota.firmaNiega}">
                            Niega (${nota.firmaNiega.persona.tipoUsuario})
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                        <g:elseif test="${sigue && nota.firmaBodega}">
                            Notifica existencia en bodega (${nota.firmaBodega.persona.tipoUsuario})
                            <g:set var="sigue" value="${false}"/>
                        </g:elseif>
                    </td>
                </tr>
            </tbody>
        </table>
    </body>
</html>