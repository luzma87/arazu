<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 4/26/2015
  Time: 12:45 PM
--%>

<%@ page import="arazu.solicitudes.NotaPedido; arazu.proyectos.Funcion" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="dashboard">
        <title>Administración</title>
    </head>

    <body>
        <div class="row">
            <div class="card">
                <div class="titulo-card"><i class="fa fa-tachometer"></i> Proyectos</div>

                <div class="cardContent">
                    <div class="circle-card card-bg-green">${proyectos.size()}</div>
                    Proyectos activos
                </div>

                <div class="cardContent">
                    <div class="circle-card ${proyectos.size() > bodegas.size() ? 'svt-bg-warning' : 'card-bg-green'}">
                        ${bodegas.size()}
                    </div>
                    Bodegas activas
                </div>
            </div>

            <div class="table-report">
                <div class="titulo-report"><i class="fa fa-sort-amount-asc"></i>Reporte de actividad</div>

                <div class="report-content">
                    <table class="table table-striped table-hover table-bordered" style="border-top: none">
                        <thead>
                            <tr>
                                <th class="header-table-report" style="width: 70%;text-align: left">Proyecto</th>
                                <th class="header-table-report">Personal</th>
                                <th class="header-table-report">Pedidos</th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${proyectos}" var="p">
                                <tr>
                                    <td>${p.nombre}</td>
                                    <td style="text-align: center">${Funcion.findAllByProyecto(p).size()}</td>
                                    <td style="text-align: center">${NotaPedido.findAllByProyecto(p).size()}</td>
                                </tr>
                            </g:each>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </body>
</html>