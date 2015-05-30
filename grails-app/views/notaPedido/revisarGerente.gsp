<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 25/02/2015
  Time: 0:08
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Nota de pedido ${nota.codigo}</title>
    </head>

    <body>
        <g:render template="/templates/revisarAprobacionFinal"
                  model="[tipo: 'Gerente', flash: flash, existencias: existencias, nota: nota, locked: locked, cots: cots]"/>
    </body>
</html>