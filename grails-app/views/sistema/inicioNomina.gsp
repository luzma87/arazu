<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 4/26/2015
  Time: 12:45 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Nómina</title>

        <style type="text/css">
        .inicio img {
            height : 190px;
        }

        i {
            margin-right : 5px;
        }
        </style>
        <link href="${g.resource(dir: 'css/custom/', file: 'dashboard.css')}" rel="stylesheet" type="text/css">
    </head>

    <body>
        <div class="row">
            <div class="table-report">
                <div class="titulo-report"><i class="fa fa-user-times"></i> Ausencias</div>

                <div class="report-content">
                    <table class="table table-striped table-hover table-bordered" style="border-top: none">
                        <thead>
                            <tr>
                                <th class="header-table-report" style="width: 50%;text-align: left">Proyecto</th>
                                <th class="header-table-report">Personal</th>
                                <th class="header-table-report">Ausencias</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </body>
</html>