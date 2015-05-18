<!DOCTYPE html>
<%@ page import="arazu.nomina.Asistencia" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Registro de asistencia</title>
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


    .table-striped > tbody > tr:nth-of-type(odd) > td.disabled {
        background : #c9c9c9;
    }
    </style>
</head>

<body>
<elm:container tipo="horizontal" titulo="Registro de asistencia">
    <div class="row">
        <div class="col-md-1">
            <label>
                Leyenda:
            </label>
        </div>
        <g:each in="${arazu.parametros.TipoAsistencia.list([sort: 'id'])}" var="ta">
            <div class="col-md-2 ${ta.codigo}">
                <g:if test="${ta.codigo == 'ASTE'}">
                    <i class='fa fa-check'></i>
                </g:if>
                <g:if test="${ta.codigo == 'NAST'}">
                    <i style="color: red"  class='fa fa-times'></i>
                </g:if>
                <g:if test="${ta.codigo == 'VCAN'}">
                    <i class='fa fa-plane'></i>
                </g:if>
                <g:if test="${ta.codigo == 'VCJN'}">
                    <i class='fa fa-car'></i>
                </g:if>
                ${ta.nombre}
            </div>
        </g:each>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-condensed table-bordered table-hover table-striped" style="font-size: 11px">
                <thead>
                <tr>
                    <th colspan="${max - min + 2}">
                        ${now.format("MMMM-yyyy").toUpperCase()}
                    </th>
                </tr>
                <tr>
                    <th>Empleado</th>
                    <g:each in="${min..max}" var="i" status="j">
                        <th>
                            ${i}
                        </th>
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
                            <td class="${i == dia ? 'actual' : 'disabled'}  ${asistencia ? asistencia.tipo.codigo : 'vacio'}">
                                <g:if test="${asistencia}">
                                    <g:if test="${asistencia.tipo.codigo == 'ASTE'}">
                                        <i class='fa fa-check'></i>
                                    </g:if>
                                    <g:if test="${asistencia.tipo.codigo == 'NAST'}">
                                        <i style="color: red"  class='fa fa-times'></i>
                                    </g:if>
                                    <g:if test="${asistencia.tipo.codigo == 'VCAN'}">
                                        <i class='fa fa-plane'></i>
                                    </g:if>
                                    <g:if test="${asistencia.tipo.codigo == 'VCJN'}">
                                        <i class='fa fa-car'></i>
                                    </g:if>
                                </g:if>

                            </td>
                        </g:each>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</elm:container>

<script type="text/javascript">
    var id = null;
    var empleado = null;
    var fecha = null;


    (function ($) {
        $.fn.disableSelection = function () {
            return this
                    .attr('unselectable', 'on')
                    .css('user-select', 'none')
                    .on('selectstart', false);
        };
    })(jQuery);
    $(".actual").disableSelection().click(function () {
        var celda = $(this);
        if (celda.hasClass("VCAN") || celda.hasClass("vacio")) {
            celda.addClass("ASTE");
            celda.attr("tipo","ASTE")
            celda.html("<i class='fa fa-check'></i> Asiste");
            celda.removeClass("NAST");
            celda.removeClass("VCAN");
            celda.removeClass("VCJN");
            celda.removeClass("vacio");
        }else{
            if (celda.hasClass("ASTE")) {
                celda.addClass("NAST");
                celda.attr("tipo","NAST")
                celda.html("<i  style='color:red' class='fa fa-times'></i> No asiste");
                celda.removeClass("ASTE");
                celda.removeClass("VCAN");
                celda.removeClass("VCJN");
            }else{
                if (celda.hasClass("NAST")) {
                    celda.addClass("VCJN");
                    celda.attr("tipo","VCJN")
                    celda.html("<i  style='color:white' class='fa fa-car'></i> Vacaciones de jornada");
                    celda.removeClass("ASTE");
                    celda.removeClass("VCAN");
                    celda.removeClass("NAST");
                }else{
                    if (celda.hasClass("VCJN")) {
                        celda.addClass("VCAN");
                        celda.attr("tipo","VCAN")
                        celda.html("<i  style='color:white' class='fa fa-plane'></i> Vacaciones Anuales");
                        celda.removeClass("ASTE");
                        celda.removeClass("NAST");
                        celda.removeClass("VCJN");
                    }
                }
            }
        }



    });

</script>
</body>
</html>