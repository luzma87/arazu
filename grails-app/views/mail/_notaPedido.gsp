<%@ page contentType="text/html" %>
<html>
    <head>
        <title>
            Nota de pedido
        </title>
    </head>

    <body>
        <p>
            <img src="cid:springsourceInlineImage" alt="HINSA"/>
        </p>

        <h3>Hola ${recibe.nombre} ${recibe.apellido}!</h3>
        <br/>

        <p>${mensaje}</p>
        <br/>
        <br/>

        <p>Para revisar sus solicitudes pendientes ingrese al sistema con sus credenciales y luego
        haga click en el siguiente link, o copie la dirección y péguela en su navegador.</p>

        <br/>
        <br/>

        <p>
            <a href="${link}">${link}</a>
        </p>

        <br/>
        <br/>
        <br/>

        <p>
            Este email fue generado automáticamente el ${now.format("dd-MM-yyyy")} a las ${now.format("HH:mm")}
            de una cuenta no monitoreada, por favor no lo conteste.
        </p>
    </body>
</html>
