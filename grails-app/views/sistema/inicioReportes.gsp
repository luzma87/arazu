<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 4/27/2015
  Time: 9:46 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="dashboard">
        <title>Reportes</title>
    </head>

    <body>

        <div class="row">
            <div class="card">
                <div class="titulo-card"><i class="fa fa-file-pdf-o"></i> Reportes</div>

                <g:link controller="reportesInterfaz" action="notasDePedido">
                    <div class="cardContent">
                        <div class="circle-card circle-card-icon card-bg-green ">
                            <i class="fa fa-folder-open fa-2x"></i>
                        </div>
                        Notas de pedido
                    </div>
                </g:link>
                <g:link controller="reportesInterfaz" action="mantenimientoExterno">
                    <div class="cardContent">
                        <div class="circle-card circle-card-icon card-bg-green ">
                            <i class="fa flaticon-forklift3 fa-2x"></i>
                        </div>
                        Mantenimiento externo
                    </div>
                </g:link>
                <g:link controller="reportesInterfaz" action="mantenimientoInterno">
                    <div class="cardContent">
                        <div class="circle-card circle-card-icon card-bg-green ">
                            <i class="fa fa-automobile fa-2x"></i>
                        </div>
                        Mantenimiento interno
                    </div>
                </g:link>
                <g:link controller="reportesInterfaz" action="bodegas">
                    <div class="cardContent">
                        <div class="circle-card circle-card-icon card-bg-green ">
                            <i class="fa fa-archive fa-2x"></i>
                        </div>
                        Bodegas
                    </div>
                </g:link>
            </div>
        </div>
    </body>
</html>