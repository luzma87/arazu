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

        %{--<imp:js href="${resource(dir: 'js', file: 'jdb.js')}"/>--}%

        <style type="text/css">
        .clickable {
            cursor      : pointer;
            font-weight : bold;
        }

        .clickableNum {
            font-weight : bold;
        }

        td {
            vertical-align : middle !important;
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
                                <g:if test="${empleado.proyecto}">
                                    <g:if test="${lastProyId != empleado.proyecto?.id}">
                                        <g:set var="lastProyId" value="${empleado.proyecto?.id}"/>
                                        <tr>
                                            <th class="success" colspan="4">
                                                ${empleado.proyecto ?: 'Sin proyecto'}
                                            </th>
                                        </tr>
                                        <g:set var="asistenciaInvitado"
                                               value="${Asistencia.findAllByFechaAndProyecto(new Date().clearTime(), empleado.proyecto)}"/>
                                        <g:if test="${asistenciaInvitado.size() == 1}">
                                            <g:set var="asistenciaInvitado" value="${asistenciaInvitado.first()}"/>
                                        </g:if>
                                        <g:else>
                                            <g:set var="asistenciaInvitado" value="${null}"/>
                                        </g:else>
                                        <g:set var="cantDes" value="${asistenciaInvitado ? asistenciaInvitado.desayunosInvitado : 0}"/>
                                        <g:set var="cantAlm" value="${asistenciaInvitado ? asistenciaInvitado.almuerzosInvitado : 0}"/>
                                        <g:set var="cantMer" value="${asistenciaInvitado ? asistenciaInvitado.meriendasInvitado : 0}"/>
                                        <tr>
                                            <td class="empleado">INVITADOS ${empleado.proyecto}</td>

                                            <td data-tipo="desayuno" class="text-center ${okDesayuno ? 'clickableNum' : 'disabled'}"
                                                data-cant="${cantDes}" data-original="${cantDes}" data-comida="desayuno" data-proyecto="${empleado.proyecto.id}">
                                                <g:if test="${okDesayuno}">
                                                    <div class="col-md-4">
                                                        <a href="#" class="btn btn-danger btn-xs btn-minus" style="width: 100%;">
                                                            <i class="fa fa-minus"></i>
                                                        </a>
                                                    </div>

                                                    <div class="col-md-4 div-num">
                                                        ${cantDes}
                                                    </div>

                                                    <div class="col-md-4">
                                                        <a href="#" class="btn btn-success btn-xs btn-plus" style="width: 100%;">
                                                            <i class="fa fa-plus"></i>
                                                        </a>
                                                    </div>
                                                </g:if>
                                                <g:else>
                                                    <g:if test="${asistenciaInvitado}">
                                                        ${asistenciaInvitado.desayunosInvitado}
                                                    </g:if>
                                                    <g:else>
                                                        No puede registrar desyunos
                                                    </g:else>
                                                </g:else>
                                            </td>

                                            <td data-tipo="almuerzo" class="text-center ${okAlmuerzo ? 'clickableNum' : 'disabled'}"
                                                data-cant="${cantAlm}" data-original="${cantAlm}" data-comida="almuerzo" data-proyecto="${empleado.proyecto.id}">
                                                <g:if test="${okAlmuerzo}">
                                                    <div class="col-md-4">
                                                        <a href="#" class="btn btn-danger btn-xs btn-minus" style="width: 100%;">
                                                            <i class="fa fa-minus"></i>
                                                        </a>
                                                    </div>

                                                    <div class="col-md-4 div-num">
                                                        ${cantAlm}
                                                    </div>

                                                    <div class="col-md-4">
                                                        <a href="#" class="btn btn-success btn-xs btn-plus" style="width: 100%;">
                                                            <i class="fa fa-plus"></i>
                                                        </a>
                                                    </div>
                                                </g:if>
                                                <g:else>
                                                    <g:if test="${asistenciaInvitado}">
                                                        ${asistenciaInvitado.almuerzosInvitado}
                                                    </g:if>
                                                    <g:else>
                                                        No puede registrar almuerzos
                                                    </g:else>
                                                </g:else>
                                            </td>

                                            <td data-tipo="merienda" class="text-center ${okMerienda ? 'clickableNum' : 'disabled'}"
                                                data-cant="${cantMer}" data-original="${cantMer}" data-comida="merienda" data-proyecto="${empleado.proyecto.id}">
                                                <g:if test="${okMerienda}">
                                                    <div class="col-md-4">
                                                        <a href="#" class="btn btn-danger btn-xs btn-minus" style="width: 100%;">
                                                            <i class="fa fa-minus"></i>
                                                        </a>
                                                    </div>

                                                    <div class="col-md-4 div-num">
                                                        ${cantMer}
                                                    </div>

                                                    <div class="col-md-4">
                                                        <a href="#" class="btn btn-success btn-xs btn-plus" style="width: 100%;">
                                                            <i class="fa fa-plus"></i>
                                                        </a>
                                                    </div>
                                                </g:if>
                                                <g:else>
                                                    <g:if test="${asistenciaInvitado}">
                                                        ${asistenciaInvitado.meriendasInvitado}
                                                    </g:if>
                                                    <g:else>
                                                        No puede registrar meriendas
                                                    </g:else>
                                                </g:else>
                                            </td>
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

                                        <td data-tipo="desayuno" data-id="${empleado.id}" data-comio="${asistencia && asistencia.desayuno == 'S' ? 'S' : 'N'}" data-original="${asistencia && asistencia.desayuno == 'S' ? 'S' : 'N'}"
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

                                        <td data-tipo="almuerzo" data-id="${empleado.id}" data-comio="${asistencia && asistencia.almuerzo == 'S' ? 'S' : 'N'}" data-original="${asistencia && asistencia.almuerzo == 'S' ? 'S' : 'N'}"
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

                                        <td data-tipo="merienda" data-id="${empleado.id}" data-comio="${asistencia && asistencia.merienda == 'S' ? 'S' : 'N'}" data-original="${asistencia && asistencia.merienda == 'S' ? 'S' : 'N'}"
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
                                </g:if>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="row">
                <div class="col-md-1">
                    <a href="#" id="guardar" class="btn btn-success">
                        <i class="fa fa-save"></i> Guardar
                    </a>
                </div>
            </div>
        </elm:container>

        <script type="text/javascript">
            var id = null;
            var empleado = null;
            var fecha = null;
            var $proyecto = $("#proyecto");

            (function ($) {
                $.fn.disableSelection = function () {
                    return this
                            .attr('unselectable', 'on')
                            .css('user-select', 'none')
                            .on('selectstart', false);
                };
            })(jQuery);

            $(function () {

                setInterval(function () {
                    myTimer()
                }, 1000);

                $("td").disableSelection();

                function myTimer() {
                    var d = new Date();
//                    var t = d.toLocaleTimeString();
//                    var t = d.toLocaleTimeString();

                    var h = d.getHours();
                    var m = d.getMinutes();
                    var s = d.getSeconds();

                    var t = h.toString().lpad("0", 2) + ":" + m.toString().lpad("0", 2) + ":" + s.toString().lpad("0", 2);

                    $("#hora").text(t);

                    %{--if ((h == ${horaInicioDesayuno} && m == ${minInicioDesayuno} && s == 0) ||--}%
                    %{--(h == ${horaInicioAlmuerzo} && m == ${minInicioAlmuerzo} && s == 0) ||--}%
                    %{--(h == ${horaInicioMerienda} && m == ${minInicioMerienda} && s == 0)) {--}%
                    %{--location.reload(true);--}%
                    %{--}--}%
                }

                <g:if test="${proy}">
                $proyecto.val('${proy.id}');
                </g:if>
                <g:else>
                $proyecto.val('');
                </g:else>
                $proyecto.selectpicker('render');

                $("#btnChangeProy").click(function () {
                    location.href = "${createLink(action:'registroComidas')}/" + $("#proyecto").val();
                });

                function cambiarComidaInv($celda, cant) {
                    var comida = $celda.data("comida");
                    var cantActual = parseInt($celda.data("cant"));
                    var cantOriginal = parseInt($celda.data("original"));
                    var cantNueva = cantActual + cant;
                    $celda.find(".div-num").text(cantNueva);
                    $celda.data("cant", cantNueva);
                    if (cantNueva == 0) {
                        $celda.find(".btn-minus").addClass("disabled");
                    } else {
                        $celda.find(".btn-minus").removeClass("disabled");
                    }
                    if (cantOriginal != cantNueva) {
                        $celda.addClass("changed");
                    } else {
                        $celda.removeClass("changed");
                    }
                }

                $(".clickableNum").each(function () {
                    var celda = $(this);
                    if (parseInt(celda.data("cant")) == 0) {
                        celda.find(".btn-minus").addClass("disabled");
                    } else {
                        celda.find(".btn-minus").removeClass("disabled");
                    }
                });

                $(".btn-plus").click(function () {
                    var celda = $(this).parents("td");
                    cambiarComidaInv(celda, 1);
                    return false;
                });

                $(".btn-minus").click(function () {
                    var celda = $(this).parents("td");
                    cambiarComidaInv(celda, -1);
                    return false;
                });

                $(".clickable").click(function () {
                    var $celda = $(this);
                    var claseAdd, claseRemove, texto;
                    var comio = false;
                    var comioOriginal = $celda.data("original");
                    if ($celda.hasClass("vacio") || $celda.hasClass("danger")) {
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
                    $celda.removeClass(claseRemove).addClass(claseAdd).html(texto).data("comio", comio);
                    if (comio != comioOriginal) {
                        $celda.addClass("changed");
                    } else {
                        $celda.removeClass("changed");
                    }
                });

                $("#guardar").click(function () {
                    bootbox.confirm("¿Está seguro de querer registrar el registro de comidas?", function (result) {
                        if (result) {

                            openLoader();
                            var data = "";
                            $(".changed").each(function () {
                                var $this = $(this);
                                if ($this.data("id")) {
                                    data += $this.data("id") + ";" + $this.data("tipo") + ";" + $this.data("comio") + "|"
                                } else {
                                    data += "p_" + $this.data("proyecto") + ";" + $this.data("tipo") + ";" + $this.data("cant") + "|"
                                }
                            });

                            if (data != "") {
                                $.ajax({
                                    type    : "POST",
                                    url     : "${g.createLink(controller:'asistencia', action:'guardarComidas_ajax')}",
                                    data    : "data=" + data,
                                    success : function (msg) {
                                        closeLoader();
                                        var parts = msg.split("*");
                                        console.log(msg);
                                        log("Datos guardados", "Success");
                                    },
                                    error   : function () {
                                        log("Ha ocurrido un error interno", "Error");
                                        closeLoader();
                                    }
                                });
                            } else {
                                closeLoader();
                            }
                        }
                    });
                });
            });
        </script>

    </body>
</html>