<!DOCTYPE html>
<%@ page import="arazu.nomina.Asistencia" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Registro de horas extra</title>
        <style type="text/css">
        .empleado {
            background  : #3A5DAA;
            color       : white;
            font-weight : bold;
        }

        .actual {
            background : none;
            cursor     : pointer;
        }

        .NAST {
            background : #FFA324 !important;
            color      : white;
        }

        .ASTE {
            background : #82A640 !important;
            color      : white;
        }
        .VCAN {
            background : #2b96a6 !important;
            color      : white;
        }
        .VCJN {
            background : #a583a6 !important;
            color      : white;
        }

        td {
            width : 50px !important;
        }

        .number {
            text-align : right !important;
        }

        .table-striped > tbody > tr:nth-of-type(odd) > td.disabled {
            background : #c9c9c9;
        }
        </style>
    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Registro de horas extra">
            <div class="row">
                <div class="col-md-12">
                    <table
                            class="table table-condensed table-bordered table-hover table-striped">
                        <thead>
                            <tr>
                                <th colspan="${(max - min + 2) * 2}">
                                    ${now.format("MMMM-yyyy").toUpperCase()}
                                </th>
                            </tr>
                            <tr>
                                <th>Empleado</th>
                                <g:each in="${min..max}" var="i" status="j">
                                    <th colspan="2">
                                        ${i}
                                    </th>
                                </g:each>

                            </tr>
                            <tr>
                                <th></th>
                                <g:each in="${min..max}" var="i" status="j">
                                    <th>50</th>
                                    <th>100</th>
                                </g:each>
                            </tr>
                        </thead>
                        <tbody>

                            <g:each in="${empleados}" var="empleado">
                                <tr>
                                    <td class="empleado">
                                        ${empleado.nombre} ${empleado.apellido}
                                    </td>
                                    <g:each in="${min..max}" var="i" status="j">
                                        <g:set var="fecha"
                                               value="${(i < dia) ? now.minus(dia - i) : now.plus(i - dia)}"/>
                                        <g:set var="asistencia"
                                               value="${Asistencia.findByEmpleadoAndFecha(empleado, fecha.clearTime())}"/>
                                        <g:if test="${asistencia}">
                                            <g:if test="${i <= dia}">
                                                <g:if test="${asistencia.tipo.codigo == 'ASTE'}">
                                                    <td
                                                            class="${i == dia ? 'actual iterador' : 'disabled'} ${asistencia ? asistencia.tipo.codigo : ''}"
                                                            empleado="${empleado.id}"
                                                            fecha="${fecha.format('dd-MM-yyyy')}">
                                                        <input
                                                                type="number" max="16" min="0"
                                                                class="digits form-control input-sm 50"
                                                                value="${asistencia.horas50}"></td>
                                                    <td
                                                            class="${i == dia ? 'actual complemento' : 'disabled'} ${asistencia ? asistencia.tipo.codigo : ''}"
                                                            empleado="${empleado.id}"
                                                            fecha="${fecha.format('dd-MM-yyyy')}"><input
                                                            type="number" max="16" min="0"
                                                            class="digits form-control input-sm 100"
                                                            value="${asistencia.horas100}"></td>
                                                </g:if>
                                                <g:else>
                                                    <td colspan="2"
                                                        class="${i == dia ? 'actual' : 'disabled'} ${asistencia ? asistencia.tipo.codigo : ''}">

                                                        <g:if test="${asistencia.tipo.codigo == 'NAST'}">
                                                            <i style="color: red"  class='fa fa-times'></i>
                                                        </g:if>
                                                        <g:if test="${asistencia.tipo.codigo == 'VCAN'}">
                                                            <i class='fa fa-plane'></i>
                                                        </g:if>
                                                        <g:if test="${asistencia.tipo.codigo == 'VCJN'}">
                                                            <i class='fa fa-car'></i>
                                                        </g:if>
                                                        ${asistencia.tipo.nombre}
                                                    </td>
                                                </g:else>
                                            </g:if>
                                            <g:else>
                                                <td style="text-align: right">${asistencia.horas50}</td>
                                                <td style="text-align: right">${asistencia.horas100}</td>
                                            </g:else>

                                        </g:if>
                                        <g:else>
                                            <td colspan="2"></td>
                                        </g:else>

                                    </g:each>

                                </tr>

                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="row">
                <div class="col-md-1">
                    <a href="#" id="guardar" class="btn btn-success"><i
                            class="fa fa-save"></i> Guardar
                    </a>
                </div>
            </div>
        </elm:container>

        <script type="text/javascript">
            var id = null;
            var empleado = null;
            var fecha = null;

            $("#guardar").click(function () {
                bootbox.confirm("Está seguro?", function (result) {
                    if (result) {
                        openLoader();
                        var data = "";
                        $(".iterador").each(function () {
                            if ($(this).hasClass("ASTE")) {
                                var h50 = $(this).find(".50").val();
                                var h100 = $(this).parent().find(".complemento").find(".100").val();
                                if (isNaN(h50))
                                    h50 = 0;
                                if (isNaN(h100))
                                    h100 = 0;
                                //console.log(h50,h100, $(this).find(".50"), $(this).find(".100"))
                                if ((h50 * 1 + h100 * 1) > 0)
                                    data += $(this).attr("empleado") + ";" + $(this).attr("fecha") + ";" + h50 + ";" + h100 + "|"
                            }
                        });
                        //console.log("data",data)
                        if (data != "") {
                            $.ajax({
                                type    : "POST",
                                url     : "${g.createLink(controller:'asistencia',action:'guardarDatosHoras_ajax')}",
                                data    : "data="
                                          + data,
                                success : function (msg) {
                                    closeLoader();
                                    log(
                                            "Datos guardados",
                                            "Success");
                                },
                                error   : function () {
                                    log(
                                            "Ha ocurrido un error interno",
                                            "Error");
                                    closeLoader();
                                }
                            });
                        } else {
                            closeLoader();
                        }
                    }
                });

            });
        </script>
    </body>
</html>