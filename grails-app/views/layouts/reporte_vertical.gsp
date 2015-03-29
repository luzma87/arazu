<%@ page import="arazu.alertas.Alerta" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title><g:layoutTitle default="Arazu"/></title>

        <style type='text/css'>
        * {
            font-family : 'PT Sans Narrow';
            font-size   : 11pt;
        }

        @page {
            size          : A4 portrait;
            margin-top    : 3cm;
            margin-right  : 2cm;
            margin-bottom : 3cm;
            margin-left   : 2cm;
        }

        @page {
            @top-left {
                content : element(header);
            }

            @top-right {
                content : element(headerRight);
            }

            @bottom-right {
                content : element(footer);
            }

            @bottom-left {
                content     : '- ${titleCorto} - pág.' counter(page) ' de ' counter(pages);
                font-family : 'PT Sans Narrow';
                font-size   : 8pt;
                font-style  : italic;
            }
        }

        #header {
            position : running(header);
        }

        #headerRight {
            position    : running(headerRight);
            color       : #7D807F;
            font-family : 'PT Sans Narrow';
            font-size   : 8pt;
            font-style  : italic;
            text-align  : center;
            line-height : 8pt;
        }

        #footer {
            position   : running(footer);
            text-align : right;
            color      : #7D807F;
        }

        @page {
            orphans : 4;
            widows  : 2;
        }

        .no-break {
            page-break-inside : avoid;
        }

        table {
            page-break-inside : avoid;
        }

        .tituloReporte {
            text-align     : center;
            text-transform : uppercase;
            font-size      : 15pt;
            font-weight    : bold;
            color          : #454344;
            border-bottom  : solid 2px #a3c23f;
        }
        </style>

        <g:layoutHead/>

    </head>

    <body>
        <div id="header">
            <img src='${resource(dir: "images", file: "logo-pdf-header.png")}' style='height:55px;'/>
        </div>

        <div id="headerRight">
            HIDALGO NARANJO INGENIEROS Y ARQUITECTOS S.A. <br/>
            R.U.C. 1792289564001 <br/>
            Matriz: Av. 6 de Diciembre N 33-55 y Eloy Alfaro Edificio Torre Blanca 7mo piso <br/>
            Telf.: 2564181, 2552952, 2552948 Fax: 2547079 <br/>
            Email: hinsahidalgo@gmail.com <br/>
            Quito - Ecuador
        </div>

        <div class='tituloReporte'>
            <g:layoutTitle/>
        </div>

        <div id="footer" style="font-size: 8pt;">
            Impreso el ${new Date().format("dd-MM-yyyy HH:mm")}
        </div>

        <g:layoutBody/>

    </body>
</html>
