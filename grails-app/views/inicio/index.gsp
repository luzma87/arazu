<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 18/12/14
  Time: 11:59 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Pantalla de inicio</title>
        <style type="text/css">
        .inicio img {
            height : 190px;
        }

        i {
            margin-right : 5px;
        }
        </style>
        <link href="${g.resource(dir: 'css/custom/', file: 'dashboard.css')}" rel="stylesheet" type="text/css">
    </head>

    <body>
        <div class="row">
            <div class="card">
                <div class="titulo-card"><i class="fa fa-newspaper-o"></i> Notas de pedido</div>

                <div class="cardContent">
                    <div class="circle-card svt-bg-warning">10</div>
                    Pendientes de revision
                </div>
                <div class="cardContent">
                    <div class="circle-card card-bg-green">3</div>
                    Pendientes de aprobacion
                </div>
            </div>
            <div class="card">
                <div class="titulo-card"><i class="fa fa-shopping-cart"></i> Ordenes de compra - Febrero</div>

                <div class="cardContent">
                    <div class="circle-card card-bg-green">1</div>
                    Emitidas
                </div>
                <div class="cardContent">
                    <div class="circle-card card-bg-green">12</div>
                    Ejecutadas
                </div>
            </div>
            <div class="card">
                <div class="titulo-card"><i class="fa fa-tachometer"></i> Operaciones</div>

                <div class="cardContent">
                    <div class="circle-card card-bg-green">4</div>
                    Proyectos activos
                </div>
                <div class="cardContent">
                    <div class="circle-card svt-bg-warning">3</div>
                    Bodegas activas
                </div>
            </div>

        </div>
        <div class="row">
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
                        <tr>
                            <td>Proyecto 1</td>
                            <td style="text-align: center">30</td>
                            <td style="text-align: center">4</td>
                        </tr>
                        <tr>
                            <td>Proyecto 2</td>
                            <td style="text-align: center">12</td>
                            <td style="text-align: center">1</td>
                        </tr>
                        <tr>
                            <td>Proyecto 3</td>
                            <td style="text-align: center">23</td>
                            <td style="text-align: center">11</td>
                        </tr>
                        <tr>
                            <td>Proyecto 4</td>
                            <td style="text-align: center">0</td>
                            <td style="text-align: center">0</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
            <div class="card">
                <div class="titulo-card"><i class="fa fa-warning"></i> Alertas</div>

                <div class="cardContent">
                    <div class="circle-card svt-bg-danger">2</div>
                    Pendientes
                </div>
            </div>
        </div>



    </body>
</html>