<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 13-May-15
  Time: 22:03
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Personal${proy ? ' del proyecto ' + proy.nombre : ' de proyectos'}</title>
    </head>

    <body>
        <elm:container tipo="horizontal" titulo="Personal${proy ? ' del proyecto ' + proy.nombre : ' de proyectos'}">
            <div class="row">
                <div class="col-sm-1">
                    <label for="proyecto">Proyecto</label>
                </div>

                <div class="col-sm-3">
                    <g:select name="proyecto" from="${proyectos}" class="form-control"
                              optionKey="id" noSelection="['': '- Todos -']" data-live-search="true"/>
                </div>

                <div class="col-sm-3">
                    <a href="#" class="btn btn-info" id="btnChangeProy">
                        <i class="fa fa-refresh"></i>
                        Cambiar
                    </a>

                    <a href="#" class="btn btn-success" id="btnSave">
                        <i class="fa fa-save"></i>
                        Guardar
                    </a>

                </div>
            </div>

            <table class="table table-condensed table-striped table-bordered table-hover" style="margin-top: 15px;">
                <thead>
                    <tr>
                        <th>Proyecto</th>
                        <th>Persona</th>
                        <th style="width: 200px;">
                            Fecha de inicio
                        </th>
                        <th style="width: 200px;">
                            Fecha de fin
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${personal}" var="p">
                        <g:set var="desde" value="${p.fechaInicio.format("dd-MM-yyyy HH:mm")}"/>
                        <g:set var="hasta" value="${p.fechaFin?.format("dd-MM-yyyy HH:mm")}"/>
                        <tr>
                            <td>${p.proyecto}</td>
                            <td>${p.persona}</td>
                            <td class="tdDate" data-val="${desde}">
                                <div class="col-md-12 divDate ">
                                    <elm:datepicker class="form-control input-sm txtDate" name="desde_${p.id}" showTime="true"
                                                    value="${p.fechaInicio}" placeholder="Inicio" onHide="cambioFecha"/>
                                </div>
                                %{--<span class="spanDate">--}%
                                %{--${desde}--}%
                                %{--</span>--}%
                            </td>
                            <td class="tdDate" data-val="${hasta}">
                                <div class="col-md-12 divDate ">
                                    <elm:datepicker class="form-control input-sm txtDate" name="hasta_${p.id}" showTime="true"
                                                    value="${p.fechaFin}" placeholder="Fin" onHide="cambioFecha"/>
                                </div>
                                %{--<span class="spanDate">--}%
                                %{--${hasta}--}%
                                %{--</span>--}%
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </elm:container>

        <script type="text/javascript">
            function cambioFecha($elm) {
                var $td = $elm.parents(".tdDate");
                var $tr = $td.parents("tr");
                var fecha = $elm.val();
                var original = $td.data("val");
                if (fecha != original) {
                    $tr.addClass("danger");
                    $elm.addClass("changed");
                } else {
                    $tr.removeClass("danger");
                    $elm.removeClass("changed");
                }
//                var $td = $elm.parents("td");
//                var $dv = $td.find(".divDate");
//                var $sp = $td.find(".spanDate");
//
//                $sp.text(fecha);
//                $dv.addClass("hidden");
            }

            $(function () {
                <g:if test="${proy}">
                $("#proyecto").val('${proy.id}');
                </g:if>
                <g:else>
                $("#proyecto").val('');
                </g:else>
                $('#proyecto').selectpicker('render');

                $("#btnChangeProy").click(function () {
                    location.href = "${createLink(action:'personalProyectosAdmin')}/" + $("#proyecto").val();
                });

                $("#btnSave").click(function () {
                    var data = {};
                    $(".changed").each(function () {
                        data[$(this).attr("id")] = $(this).val();
                    });
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'personalProyecto', action:'saveFechas_ajax')}",
                        data    : data,
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0]); // log(msg, type, title, hide)
                            setTimeout(function () {
                                location.reload(true);
                            }, 1000);
                        },
                        error   : function () {
                            log("Ha ocurrido un error interno", "error");
                            closeLoader();
                        }
                    });
                    return false;
                });
//                $('.txtDate').datetimepicker();
//                $(".tdDate").click(function () {
//                    var $td = $(this);
//                    var $dp = $td.find(".txtDate");
//                    var $dv = $td.find(".divDate");
//                    var $sp = $td.find(".spanDate");
//                    var fechaOriginal = $td.data("val");
//                    $sp.text("");
//                    $dp.val(fechaOriginal);
//                    $dv.removeClass("hidden");
////                    $dp.click();
//                });
            });
        </script>
    </body>
</html>