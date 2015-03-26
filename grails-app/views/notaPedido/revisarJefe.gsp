<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 24/02/2015
  Time: 23:58
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Nota de pedido #${nota.numero}</title>
    </head>

    <body>
        <g:render template="/templates/revisarAprobacionFinal"
                  model="[tipo: 'Jefe', flash: flash, existencias: existencias, nota: nota, locked: locked, cots: cots]"/>
    </body>
</html>