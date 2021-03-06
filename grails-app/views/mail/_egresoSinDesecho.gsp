<%@ page contentType="text/html" %>
<html>
    <head>
        <title>
            Nota de pedido
        </title>
    </head>

    <body>
        <p>
            <img src="cid:logo" alt="HINSA"/>
        </p>

        <h3>Hola ${recibe.nombre} ${recibe.apellido}!</h3>

        <p>${mensaje}</p>

        <p>Para revisar los egresos realizados sin ingreso de desecho ingrese al sistema con sus credenciales y luego
        haga click en el siguiente link, o copie la dirección y péguela en su navegador.</p

        <p>
            <a href="${link}">${link}</a>
        </p>

        <p>
            Este email fue generado automáticamente el ${now.format("dd-MM-yyyy")} a las ${now.format("HH:mm")}
            de una cuenta no monitoreada, por favor no lo conteste.
        </p>
    </body>
</html>
