<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 4/26/2015
  Time: 2:17 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Selección de sistema</title>

        <style type="text/css">
        .sistema {
            cursor : pointer;
        }
        </style>
    </head>

    <body>
        <div class="row">
            <g:each in="${session.sistemas}" var="sistema">
                <g:if test="${sistema}">
                    <div class="col-md-3">
                        <div class="panel panel-info sistema" data-url="${createLink(controller: sistema.controlador, action: sistema.accion)}">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <g:if test="${sistema.icono}">
                                        <i class="${sistema.icono}"></i>
                                    </g:if>
                                    ${sistema.nombre}
                                </h3>
                            </div>

                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <g:if test="${sistema.pathImagen}">
                                            <img class="img-responsive" src="${resource(dir: 'images/inicio', file: sistema.pathImagen)}"/>
                                        </g:if>
                                    </div>

                                    <div class="col-md-8">
                                        ${sistema.descripcion}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </g:if>
            </g:each>
        </div>

        <script type="text/javascript">
            $(function () {
                $(".sistema").hover(function () {
                    $(this).find(".panel-body").addClass("bg-info");
                }, function () {
                    $(this).find(".panel-body").removeClass("bg-info");
                }).click(function () {
                    location.href = $(this).data("url");
                });
            });
        </script>

    </body>
</html>