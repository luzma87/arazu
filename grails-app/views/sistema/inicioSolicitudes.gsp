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
        <title>Solicitudes</title>
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
                <div class="titulo-card"><i class="fa flaticon-forklift3"></i> Mantenimiento externo</div>
                <g:each in="${mx}" var="n">
                    <div class="cardContent" title="${n.value.estado.descripcion}">
                        <div class="circle-card ${n.value.clase}">${n.value.cant}</div>
                        ${n.value.estado.nombre}
                    </div>
                </g:each>
            </div>

            <div class="card">
                <div class="titulo-card"><i class="fa fa-automobile"></i> Mantenimiento interno</div>
                <g:each in="${mi}" var="n">
                    <div class="cardContent" title="${n.value.estado.descripcion}">
                        <div class="circle-card ${n.value.clase}">${n.value.cant}</div>
                        ${n.value.estado.nombre}
                    </div>
                </g:each>
            </div>
        </div>

        <script type="text/javascript">
            $(function () {
                $(".cardContent").hover(function () {
                    $(this).addClass("bg-info");
                }, function () {
                    $(this).removeClass("bg-info");
                });
            });
        </script>

    </body>
</html>