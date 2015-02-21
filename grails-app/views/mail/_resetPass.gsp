<%@ page contentType="text/html" %>
<html>
    <head>
        <title>
            ${title}
        </title>
    </head>

    <body>
        <p>
            <img src="cid:springsourceInlineImage" alt="HINSA"/>
        </p>

        <h3>Hola ${recibe.nombre} ${recibe.apellido}!</h3>

        <p>${mensaje}</p>

        <p>
            Este email fue generado automáticamente el ${now.format("dd-MM-yyyy")} a las ${now.format("HH:mm")}
            de una cuenta no monitoreada, por favor no lo conteste.
        </p>
    </body>
</html>
