<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 4/27/2015
  Time: 9:31 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="dashboard">
        <title>Inventario</title>
    </head>

    <body>
        <div class="row">
            <div class="card">
                <div class="titulo-card"><i class="fa fa-archive"></i> Bodegas</div>

                <div class="cardContent">
                    <div class="circle-card card-bg-green">
                        ${bodegas}
                    </div>
                    Bodega${bodegas == 1 ? '' : 's'} activa${bodegas == 1 ? '' : 's'}
                </div>

                <div class="cardContent">
                    <div class="circle-card ${bodegasInactivas > 0 ? 'svt-bg-warning' : 'card-bg-green'}">
                        ${bodegasInactivas}
                    </div>
                    Bodega${bodegasInactivas == 1 ? '' : 's'} inactiva${bodegasInactivas == 1 ? '' : 's'}
                </div>

                <div class="cardContent">
                    <div class="circle-card ${bodegasSinSuplente > 0 ? 'svt-bg-warning' : 'card-bg-green'}">
                        ${bodegasSinSuplente}
                    </div>
                    Bodega${bodegasSinSuplente == 1 ? '' : 's'} sin suplente
                </div>

                <div class="cardContent">
                    <div class="circle-card ${bodegasVacias > 0 ? 'svt-bg-warning' : 'card-bg-green'}">
                        ${bodegasVacias}
                    </div>
                    Bodega${bodegasVacias == 1 ? '' : 's'} vacía${bodegasVacias == 1 ? '' : 's'}
                </div>
            </div>

            <div class="card">
                <div class="titulo-card"><i class="fa flaticon-two195"></i> Items</div>

                <div class="cardContent">
                    <div class="circle-card card-bg-green">
                        ${items}
                    </div>
                    Item${items == 1 ? '' : 's'} en bodegas
                </div>

                <div class="cardContent">
                    <div class="circle-card card-bg-green">
                        ${desechos}
                    </div>
                    Item${desechos == 1 ? '' : 's'} de desecho
                </div>
            </div>

            <div class="card">
                <div class="titulo-card"><i class="fa flaticon-construction11"></i> Maquinaria</div>

                <div class="cardContent">
                    <div class="circle-card card-bg-green">
                        ${maquinas}
                    </div>
                    Maquinaria${maquinas == 1 ? '' : 's'}
                </div>
            </div>
        </div>
    </body>
</html>