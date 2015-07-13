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
            <div class="col-md-4">
                <div class="list-group">
                    <g:each in="${acciones}" var="a">
                        <g:link controller="${a.control}" action="${a.nombre}" class="list-group-item">
                            <g:if test="${a.icono}">
                                <i class="${a.icono}"></i>
                            </g:if>
                            ${a.descripcion}
                        </g:link>
                    </g:each>
                </div>
            </div>
        </div>
    </body>
</html>