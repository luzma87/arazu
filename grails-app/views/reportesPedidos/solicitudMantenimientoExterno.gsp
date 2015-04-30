<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 3/28/2015
  Time: 6:28 PM
--%>
<%@ page import="arazu.solicitudes.DetalleTrabajo" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <g:set var="titleCorto" value="${solicitud.codigo}" scope="request"/>
        <meta name="layout" content="reporte_vertical"/>

        <title>Solicitud de mantenimiento externo #${solicitud.numero}</title>

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

        <h4>La solicitud está <span class="estado">${solicitud.estadoSolicitud}</span></h4>

        %{--Datos--}%
        <table>
            <tbody>
                <tr>
                    <td class="label">Fecha</td>
                    <td>${solicitud.fecha.format("dd-MM-yyyy hh:mm:ss")}</td>

                    <td class="label">Equipo</td>
                    <td>${solicitud.maquinaria}</td>
                </tr>
                <tr>
                    <g:if test="${solicitud.proyecto}">
                        <td class="label">Proyecto</td>
                        <td>${solicitud.proyecto.nombre}</td>
                    </g:if>

                    <td class="label">Localización</td>
                    <td>${solicitud.localizacion}</td>
                </tr>
                <tr>
                    <td class="label">Horómetro</td>
                    <td>${solicitud.horometro}</td>

                    <td class="label">Kilometraje</td>
                    <td>${solicitud.kilometraje}</td>
                </tr>
                <tr>
                    <td class="label">Trabajos a realizar</td>
                    <td colspan="3">${DetalleTrabajo.findAllBySolicitudMantenimientoExterno(solicitud).tipoTrabajo.join(", ")}</td>
                </tr>
                <tr>
                    <td class="label">Detalles</td>
                    <td colspan="3">${solicitud.detalles}</td>
                </tr>
                <tr>
                    <td class="label">Observaciones</td>
                    <td colspan="3">${solicitud.observacionesFormat}</td>
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
                        <g:if test="${cot.estadoSolicitud.codigo == 'A11' || cot.estadoSolicitud.codigo == 'N11'}">
                            ${cot.estadoSolicitud}
                        </g:if>
                    </th>
                </tr>
                <tr>
                    <td class="label">Taller</td>
                    <td>${cot.proveedor}</td>

                    <td class="label">Precio</td>
                    <td><g:formatNumber number="${cot.valor}" type="currency"/></td>
                </tr>
            </table>
        </g:each>

    %{--Firmas--}%
        <div class="no-break">
            <h3>Firmas</h3>
            <g:set var="sigue" value="${true}"/>
            <table>
                <tbody>
                    <tr>
                        <td class="text-center">
                            <img src="${resource(dir: 'firmas', file: solicitud.firmaSolicita.path)}" height="100"/>
                        </td>
                        <td class="text-center">
                            <g:if test="${solicitud.firmaJefeCompras}">
                                <img src="${resource(dir: 'firmas', file: solicitud.firmaJefeCompras.path)}" height="100"/>
                            </g:if>
                            <g:elseif test="${sigue && solicitud.firmaNiega}">
                                <img src="${resource(dir: 'firmas', file: solicitud.firmaNiega.path)}" height="100"/>
                                <g:set var="sigue" value="${false}"/>
                            </g:elseif>
                        </td>
                        <td class="text-center">
                            <g:if test="${solicitud.firmaAsistenteCompras}">
                                <img src="${resource(dir: 'firmas', file: solicitud.firmaAsistenteCompras.path)}" height="100"/>
                            </g:if>
                            <g:elseif test="${sigue && solicitud.firmaNiega}">
                                <img src="${resource(dir: 'firmas', file: solicitud.firmaNiega.path)}" height="100"/>
                                <g:set var="sigue" value="${false}"/>
                            </g:elseif>
                        </td>
                        <td class="text-center">
                            <g:if test="${solicitud.firmaAprueba}">
                                <img src="${resource(dir: 'firmas', file: solicitud.firmaAprueba.path)}" height="100"/>
                            </g:if>
                            <g:elseif test="${sigue && solicitud.firmaNiega}">
                                <img src="${resource(dir: 'firmas', file: solicitud.firmaNiega.path)}" height="100"/>
                                <g:set var="sigue" value="${false}"/>
                            </g:elseif>
                        </td>
                    </tr>
                    <tr>
                        <g:set var="sigue" value="${true}"/>
                        <td class="text-center">
                            ${solicitud.de}
                        </td>
                        <td class="text-center">
                            <g:if test="${solicitud.firmaJefeCompras}">
                                ${solicitud.firmaJefeCompras.persona}
                            </g:if>
                            <g:elseif test="${sigue && solicitud.firmaNiega}">
                                ${solicitud.firmaNiega.persona}
                                <g:set var="sigue" value="${false}"/>
                            </g:elseif>
                        </td>
                        <td class="text-center">
                            <g:if test="${solicitud.firmaAsistenteCompras}">
                                ${solicitud.firmaAsistenteCompras.persona}
                            </g:if>
                            <g:elseif test="${sigue && solicitud.firmaNiega}">
                                ${solicitud.firmaNiega.persona}
                                <g:set var="sigue" value="${false}"/>
                            </g:elseif>
                        </td>
                        <td class="text-center">
                            <g:if test="${solicitud.firmaAprueba}">
                                ${solicitud.firmaAprueba.persona}
                            </g:if>
                            <g:elseif test="${sigue && solicitud.firmaNiega}">
                                ${solicitud.firmaNiega.persona}
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
                            <g:if test="${solicitud.firmaJefeCompras}">
                                Aprueba (${solicitud.firmaJefeCompras.persona.tipoUsuario})
                            </g:if>
                            <g:elseif test="${sigue && solicitud.firmaNiega}">
                                Niega (${solicitud.firmaNiega.persona.tipoUsuario}
                                <g:set var="sigue" value="${false}"/>
                            </g:elseif>
                        </td>
                        <td class="text-center firma">
                            <g:if test="${solicitud.firmaAsistenteCompras}">
                                Aprueba (${solicitud.firmaAsistenteCompras.persona.tipoUsuario})
                            </g:if>
                            <g:elseif test="${sigue && solicitud.firmaNiega}">
                                Niega (${solicitud.firmaNiega.persona.tipoUsuario})
                                <g:set var="sigue" value="${false}"/>
                            </g:elseif>
                        </td>
                        <td class="text-center firma">
                            <g:if test="${solicitud.firmaAprueba}">
                                Aprueba (${solicitud.firmaAprueba.persona.tipoUsuario})
                            </g:if>
                            <g:elseif test="${sigue && solicitud.firmaNiega}">
                                Niega (${solicitud.firmaNiega.persona.tipoUsuario})
                                <g:set var="sigue" value="${false}"/>
                            </g:elseif>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>