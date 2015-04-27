<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 4/26/2015
  Time: 12:45 PM
--%>

<%@ page import="arazu.solicitudes.NotaPedido; arazu.proyectos.Funcion" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Solicitudes</title>
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
                <div class="titulo-card"><i class="fa fa-folder-open"></i> Notas de pedido</div>
                <g:each in="${np}" var="n">
                    <div class="cardContent" title="${n.value.estado.descripcion}">
                        <div class="circle-card ${n.value.clase}">${n.value.cant}</div>
                        ${n.value.estado.nombre}
                    </div>
                </g:each>
            </div>

            <div class="card">
                <div class="titulo-card"><i class="fa fa-folder-open"></i> Mantenimiento externo</div>
                <g:each in="${mx}" var="n">
                    <div class="cardContent" title="${n.value.estado.descripcion}">
                        <div class="circle-card ${n.value.clase}">${n.value.cant}</div>
                        ${n.value.estado.nombre}
                    </div>
                </g:each>
            </div>

            <div class="card">
                <div class="titulo-card"><i class="fa fa-folder-open"></i> Mantenimiento interno</div>
                <g:each in="${mi}" var="n">
                    <div class="cardContent" title="${n.value.estado.descripcion}">
                        <div class="circle-card ${n.value.clase}">${n.value.cant}</div>
                        ${n.value.estado.nombre}
                    </div>
                </g:each>
            </div>

        </div>

    </body>
</html>