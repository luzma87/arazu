<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 027 27-Jun-15
  Time: 20:58
--%>

<%@ page import="arazu.nomina.Asistencia; arazu.parametros.Parametros" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Registro de comidas${proy ? ' del proyecto ' + proy.nombre : ''}</title>

        <style type="text/css">
        .clickable {
            cursor      : pointer;
            font-weight : bold;
        }
        </style>
    </head>

    <body>

        <elm:container tipo="horizontal" titulo="Registro de comidas${proy ? ' del proyecto ' + proy.nombre : ''}">
            <div class="row">
                <div class="col-sm-1">
                    <label for="proyecto">Proyecto</label>
                </div>

                <div class="col-sm-3">
                    <g:select name="proyecto" from="${proyectos}" class="form-control"
                              optionKey="id" noSelection="['': '- Todos -']" data-live-search="true"/>
                </div>

                <div class="col-sm-1">
                    <a href="#" class="btn btn-info" id="btnChangeProy">
                        <i class="fa fa-refresh"></i>
                        Cambiar
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <table class="table table-condensed table-bordered table-hover table-striped">
                        <thead>
                            <tr>
                                <th colspan="4">
                                    ${g.formatDate(date: now, format: 'dd MMMM yyyy', locale: 'es').toString().toUpperCase()}
                                    <span id="hora">${g.formatDate(date: now, format: 'HH:mm:ss')}</span>
                                </th>
                            </tr>
                            <tr>
                                <th style="width: 25%;">Empleado</th>
                                <th style="width: 25%;">
                                    Desayuno: de ${inicioDesayuno} a ${finDesayuno}
                                </th>
                                <th style="width: 25%;">
                                    Almuerzo: de ${inicioAlmuerzo} a ${finAlmuerzo}
                                </th>
                                <th style="width: 25%;">
                                    Merienda: de ${inicioMerienda} a ${finMerienda}
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:set var="lastProyId" value="${''}"/>
                            <g:each in="${empleados}" var="empleado">
                                <g:if test="${lastProyId != empleado.proyecto?.id}">
                                    <g:set var="lastProyId" value="${empleado.proyecto?.id}"/>
                                    <tr>
                                        <th class="success" colspan="4">
                                            ${empleado.proyecto ?: 'Sin proyecto'}
                                        </th>
                                    </tr>
                                </g:if>
                                <tr>
                                    <g:set var="asistencia" value="${Asistencia.findAllByFechaAndEmpleado(new Date().clearTime(), empleado)}"/>
                                    <g:if test="${asistencia.size() == 1}">
                                        <g:set var="asistencia" value="${asistencia.first()}"/>
                                    </g:if>
                                    <g:else>
                                        <g:set var="asistencia" value="${null}"/>
                                    </g:else>
                                    <td class="empleado">
                                        ${empleado.nombre} ${empleado.apellido}
                                        <g:if test="${empleado.proyecto}">
                                            <g:set var="fechas" value="${empleado.fechasProyectoActual}"/>
                                            <br/><small>(desde ${fechas?.inicio?.format("dd-MM-yyyy")}${fechas?.final ? ' a ' + fechas.final.format("dd-MM-yyyy") : ''})</small>
                                        </g:if>
                                    </td>

                                    <td data-tipo="desayuno" data-id="${empleado.id}"
                                        class="text-center ${okDesayuno ? 'clickable vacio' : 'disabled'} ${asistencia ? (asistencia.desayuno == 'S' ? 'success text-success' : asistencia.desayuno == 'N' ? 'danger text-danger' : '') : ''}">
                                        <g:if test="${asistencia && asistencia.desayuno == 'S'}">
                                            <i class="fa fa-check-circle"></i> SI
                                        </g:if>
                                        <g:elseif test="${asistencia && asistencia.desayuno == 'N'}">
                                            <i class="fa fa-times-circle"></i> NO
                                        </g:elseif>
                                        <g:else>
                                            <g:if test="${!okDesayuno}">
                                                No puede registrar desayuno
                                            </g:if>
                                        </g:else>
                                    </td>

                                    <td data-tipo="almuerzo" data-id="${empleado.id}"
                                        class="text-center ${okAlmuerzo ? 'clickable vacio' : 'disabled'} ${asistencia ? (asistencia.almuerzo == 'S' ? 'success text-success' : asistencia.almuerzo ? 'danger text-danger' : '') : ''}">
                                        <g:if test="${asistencia && asistencia.almuerzo == 'S'}">
                                            <i class="fa fa-check-circle"></i> SI
                                        </g:if>
                                        <g:elseif test="${asistencia && asistencia.almuerzo == 'N'}">
                                            <i class="fa fa-times-circle"></i> NO
                                        </g:elseif>
                                        <g:if test="${!okAlmuerzo}">
                                            No puede registrar almuerzo
                                        </g:if>
                                    </td>

                                    <td data-tipo="merienda" data-id="${empleado.id}"
                                        class="text-center ${okMerienda ? 'clickable vacio' : 'disabled'} ${asistencia ? (asistencia.merienda == 'S' ? 'success text-success' : asistencia.merienda ? 'danger text-danger' : '') : ''}">
                                        <g:if test="${asistencia && asistencia.merienda == 'S'}">
                                            <i class="fa fa-check-circle"></i> SI
                                        </g:if>
                                        <g:elseif test="${asistencia && asistencia.merienda == 'N'}">
                                            <i class="fa fa-times-circle"></i> NO
                                        </g:elseif>
                                        <g:if test="${!okMerienda}">
                                            No puede registrar merienda
                                        </g:if>
                                    </td>
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

            $(function () {

                setInterval(function () {
                    myTimer()
                }, 1000);

                function myTimer() {
                    var d = new Date();
//                    var t = d.toLocaleTimeString();
//                    var t = d.toLocaleTimeString();

                    var h = d.getHours();
                    var m = d.getMinutes();
                    var s = d.getSeconds();

                    var t = h.toString().lpad("0", 2) + ":" + m.toString().lpad("0", 2) + ":" + s.toString().lpad("0", 2);

                    $("#hora").text(t);

                    if ((h == ${horaInicioDesayuno} && m == ${minInicioDesayuno} && s == 0) ||
                        (h == ${horaInicioAlmuerzo} && m == ${minInicioAlmuerzo} && s == 0) ||
                        (h == ${horaInicioMerienda} && m == ${minInicioMerienda} && s == 0)) {
                        location.reload(true);
                    }
                }

                <g:if test="${proy}">
                $("#proyecto").val('${proy.id}');
                </g:if>
                <g:else>
                $("#proyecto").val('');
                </g:else>
                $('#proyecto').selectpicker('render');

                $("#btnChangeProy").click(function () {
                    location.href = "${createLink(action:'registroComidas')}/" + $("#proyecto").val();
                });

                $(".clickable").click(function () {
                    var celda = $(this);
                    var claseAdd, claseRemove, texto;
                    var comio = false;
                    if (celda.hasClass("vacio") || celda.hasClass("danger")) {
                        claseAdd = "success text-success";
                        claseRemove = "vacio danger text-danger";
                        texto = "<i class='fa fa-check-circle'></i> SI";
                        comio = "S";
                    } else {
                        claseAdd = "danger text-danger";
                        claseRemove = "success text-success";
                        texto = "<i class='fa fa-times-circle'></i> NO";
                        comio = "N";
                    }
                    var comida = celda.data("tipo");
                    var persona = celda.data("id");

                    $.ajax({
                        type    : "POST",
                        url     : '${createLink( action:'cambiarEstadoComida_ajax')}',
                        data    : {
                            persona : persona,
                            comida  : comida,
                            comio   : comio
                        },
                        success : function (msg) {
                            var parts = msg.split("*");
//                            log(parts[1], parts[0]); // log(msg, type, title, hide)
                            if (parts[0] == "SUCCESS") {
                                celda.removeClass(claseRemove).addClass(claseAdd).html(texto);
                            }
                        },
                        error   : function () {
                            log("Ha ocurrido un error interno", "Error");
                            closeLoader();
                        }
                    });
                });

            });
        </script>

    </body>
</html>