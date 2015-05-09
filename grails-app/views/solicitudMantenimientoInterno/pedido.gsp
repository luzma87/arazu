<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 26/03/15
  Time: 10:52 AM
--%>

<%@ page import="arazu.items.Item; arazu.seguridad.Persona; arazu.parametros.Unidad; arazu.parametros.TipoTrabajo; arazu.proyectos.Proyecto" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Solicitud de mantenimiento interno</title>
        <style type="text/css">
        .clickable {
            cursor : pointer;
        }

        /*body {*/
        /*padding-bottom : 150px;*/
        /*}*/
        </style>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Nueva solicitud de mantenimiento interno">
            <div class="alert alert-info" style="margin-top: 10px;">
                <strong>Nota:</strong> el número mostrado en esta pantalla es un número tentativo que puede cambiar al momento de guardar.
            Se le informará el número final de su solicitud después de guardar.
            </div>

            <g:form class="frmSolicitud" action="saveSolicitud_ignore">
                <div class="row">
                    <div class="col-md-1">
                        <label class=" control-label">
                            Equipo
                        </label>
                    </div>

                    <div class="col-md-5 grupo">
                        <div class="input-group">
                            <input type="text" class="form-control" id="maquina_input" readonly/>
                            <span class="input-group-addon svt-bg-warning">
                                <i class="fa fa-keyboard-o"></i>
                            </span>
                            <g:hiddenField name="maquinaria.id" id="maquina" class="required"/>
                        </div><!-- /input-group -->
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Número
                        </label>
                    </div>

                    <div class="col-md-2">
                        ${numero}
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Fecha
                        </label>
                    </div>

                    <div class="col-md-2">
                        ${new Date().format("dd-MM-yyyy hh:mm:ss")}
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-1">
                        <label class=" control-label">
                            De
                        </label>
                    </div>

                    <div class="col-md-2">
                        ${session.usuario}
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Para
                        </label>
                    </div>

                    <div class="col-md-2">
                        <g:select name="paraAF.id" from="${jefes}" optionKey="id"
                                  class="form-control input-sm required select" required=""/>
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Proyecto
                        </label>
                    </div>

                    <div class="col-md-2">
                        <g:select name="proyecto.id" from="${Proyecto.findAllByFechaFinIsNullOrFechaFinGreaterThan(new Date())}" optionKey="id" optionValue="nombre"
                                  class="form-control input-sm select" noSelection="['': '-- Seleccione --']"/>
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Localización
                        </label>
                    </div>

                    <div class="col-md-2 grupo">
                        <g:textField name="localizacion" class="form-control input-sm required"/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-1">
                        <label class=" control-label">
                            Horómetro
                        </label>
                    </div>

                    <div class="col-md-2 grupo">
                        <g:textField name="horometro" class="form-control input-sm number required"/>
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Kilometraje
                        </label>
                    </div>

                    <div class="col-md-2 grupo">
                        <g:textField name="kilometraje" class="form-control input-sm number required"/>
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Encargado
                        </label>
                    </div>

                    <div class="col-md-2">
                        <g:select name="encargado.id" from="${mecanicos}" optionKey="id"
                                  class="form-control input-sm required select" required=""/>
                    </div>
                </div>

                <div class="grupo">
                    <div class="row">
                        <div class="col-md-12 text-info">
                            <h3>Trabajos a realizar <small>Seleccione todos los que apliquen</small></h3>
                            <a href="#" id="selectNone" class="btn btn-danger btn-xs">Quitar toda la selección</a>
                        </div>
                    </div>

                <g:each in="${TipoTrabajo.list([sort: 'nombre'])}" var="tipo" status="i">
                    <g:if test="${i % 4 == 0}">
                        <g:if test="${i > 0}">
                            </div>
                        </g:if>
                        <div class='row'>
                    </g:if>
                    <div class="col-md-3">
                        <span class="clickable" data-state="off" data-id="${tipo.id}">
                            <i class="fa fa-square-o"></i> ${tipo}
                        </span>
                    </div>
                </g:each>
                </div>
                <g:hiddenField name="trabajos" class="required"/>
                </div>

                <div class="row">
                    <div class="col-md-12 text-info">
                        <h3>Detalle de los trabajos a realizar</h3>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 grupo ">
                        <g:textArea name="detalles" class="form-control required" style="height: 200px;"/>
                    </div>
                </div>

                <g:textField name="materiales"/>
                <g:textField name="manoObra"/>

            </g:form>

            <div class="row">
                <div class="col-md-12 text-info">
                    <h3>Planificación de mano de obra</h3>
                </div>
            </div>

            <form id="frmPersona">
                <div class="row">
                    <div class="col-md-12">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th style="width: 150px;">Persona</th>
                                    <th style="width: 100px;">Horas de trabajo</th>
                                    <th style="width: 150px;">Fecha</th>
                                    <th style="width: 300px;">Observaciones</th>
                                    <th style="width: 35px;"></th>
                                </tr>
                                <tr class="success">
                                    <td>
                                        <g:select name="persona" from="${Persona.list([sort: 'apellido'])}" data-live-search="true"
                                                  data-width="150px" optionKey="id"/>
                                    </td>
                                    <td>
                                        <g:textField name="horas" class="form-control input-sm number"/>
                                    </td>
                                    <td class="col-md-2">
                                        <elm:datepicker name="fecha" class="datepicker form-control input-sm" minDate="${new Date()}"/>
                                    </td>
                                    <td>
                                        <g:textField name="observacionesp" class="form-control input-sm"/>
                                    </td>
                                    <td>
                                        <a href="#" class="btn btn-sm btn-success" id="btnAddPersona">
                                            <i class="fa fa-plus"></i>
                                        </a>
                                    </td>
                                </tr>
                            </thead>
                            <tbody id="tbPersona">
                                <g:each in="${detalleManoObra}" var="dt">
                                    <tr data-id="${dt.id}"
                                        data-persona="${dt.personaId}"
                                        data-horas="${dt.horasTrabajo}"
                                        data-fecha="${dt.fecha.format('dd-MM-yyyy')}"
                                        data-observaciones="${dt.observaciones}">
                                        <td>${dt.persona}</td>
                                        <td>${dt.horasTrabajo}</td>
                                        <td>${dt.fecha.format('dd-MM-yyyy')}</td>
                                        <td>${dt.observaciones}</td>
                                        <td>
                                            <a href="#" class="btn btn-sm btn-danger btnDeletePersona">
                                                <i class="fa fa-trash-o"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </form>

            <div class="row">
                <div class="col-md-12 text-info">
                    <h3>Planificación de repuestos y materiales</h3>
                </div>
            </div>

            <form id="frmMaterial">
                <div class="row">
                    <div class="col-md-12">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th style="width: 100px;">Cantidad</th>
                                    <th style="width: 100px;">Unidad</th>
                                    <th style="width: 300px;">Item</th>
                                    <th style="width: 150px;">Código o N. parte</th>
                                    <th style="width: 150px;">Marca</th>
                                    <th style="width: 300px;">Observaciones</th>
                                    <th style="width: 35px;"></th>
                                </tr>
                                <tr class="success">
                                    <td>
                                        <g:textField name="cantidad" class="form-control input-sm number"/>
                                    </td>
                                    <td>
                                        <g:select name="unidad" from="${Unidad.list([sort: 'descripcion'])}" data-width="90px" optionKey="id"/>
                                    </td>
                                    <td>
                                        <g:select name="item" from="${Item.list([sort: 'descripcion'])}" optionKey="id" data-live-search="true"/>
                                    </td>
                                    <td>
                                        <g:textField name="codigo" class="form-control input-sm"/>
                                    </td>
                                    <td>
                                        <g:textField name="marca" class="form-control input-sm"/>
                                    </td>
                                    <td>
                                        <g:textField name="observaciones" class="form-control input-sm"/>
                                    </td>
                                    <td>
                                        <a href="#" class="btn btn-sm btn-success" id="btnAddMaterial">
                                            <i class="fa fa-plus"></i>
                                        </a>
                                    </td>
                                </tr>
                            </thead>
                            <tbody id="tbMaterial">
                                <g:each in="${detalleMaterial}" var="dt">
                                    <tr data-id="${dt.id}"
                                        data-cantidad="${dt.cantidad}"
                                        data-item="${dt.itemId}"
                                        data-unidad="${dt.unidadId}"
                                        data-codigo="${dt.codigo}"
                                        data-marca="${dt.marca}"
                                        data-observaciones="${dt.observaciones}">
                                        <td>${dt.cantidad}</td>
                                        <td>${dt.unidad}</td>
                                        <td>${dt.item}</td>
                                        <td>${dt.codigo}</td>
                                        <td>${dt.marca}</td>
                                        <td>${dt.observaciones}</td>
                                        <td>
                                            <a href="#" class="btn btn-sm btn-danger btnDeleteMaterial">
                                                <i class="fa fa-trash-o"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </form>

            <div class="row" style="margin-top: 20px">
                <div class="col-md-1">
                    <a href="#" class="btn btn-primary" id="guardar">
                        <i class="fa fa-paper-plane-o"></i> Enviar
                    </a>
                </div>
            </div>
        </elm:container>


        <script type="text/javascript">

            function select($elm) {
                $elm.addClass("text-info");
                $elm.data("state", "on");
                $elm.find("i").removeClass("fa-square-o").addClass("fa-check-square-o");
                $elm.css("font-weight", "bold");
            }
            function deselect($elm) {
                $elm.removeClass("text-info");
                $elm.data("state", "off");
                $elm.find("i").removeClass("fa-check-square-o").addClass("fa-square-o");
                $elm.css("font-weight", "normal");
            }

            function validarMaterial(cant, unidad, item, cod, marca, obs) {
                var ok = true;
                $("#tbMaterial").children().each(function () {
                    var $tr = $(this);
                    var data = $tr.data();
                    if (data.unidad == unidad && data.item == item && data.marca == marca) {
                        ok = false;
                    }
                });
                return ok;
            }

            function validarPersona(pers, horas, fecha, obs) {
                var ok = true;
                $("#tbPersona").children().each(function () {
                    var $tr = $(this);
                    var data = $tr.data();
                    if (data.persona == pers && data.fecha == fecha) {
                        ok = false;
                    }
                });
                return ok;
            }

            $(function () {
                $("#maquina").val("");
                $("#trabajos").val("");
                $("#materiales").val("");
                $("#manoObra").val("");

                $("#maquina_input").val("").click(function () {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'maquinaria', action:'list_ajax')}",
                        success : function (msg) {
                            closeLoader();
                            var b = bootbox.dialog({
                                id      : "dlgFindMaquinaria",
                                title   : "Buscar Maquinaria",
//                            class   : "modal-lg",
                                message : msg,
                                buttons : {
                                    cancelar : {
                                        label     : "Cerrar",
                                        className : "btn-primary",
                                        callback  : function () {
                                        }
                                    }
                                } //buttons
                            }); //dialog
                            setTimeout(function () {
                                b.find(".form-control").first().focus()
                            }, 500);
                        } //success
                    }); //ajax
                    return false;
                });

                $("#selectNone").click(function () {
                    $(".clickable").each(function () {
                        deselect($(this));
                    });
                    return false;
                });

                $(".clickable").click(function () {
                    var state = $(this).data("state");
                    if (state == "off") {
                        select($(this));
                    } else {
                        deselect($(this));
                    }
                });

                $(".frmSolicitud").validate({
                    ignore         : [], //para que valide los hiddens
                    errorClass     : "help-block",
                    errorPlacement : function (error, element) {
                        if (element.parent().hasClass("input-group")) {
                            error.insertAfter(element.parent());
                        } else {
                            error.insertAfter(element);
                        }
                        element.parents(".grupo").addClass('has-error');
                    },
                    success        : function (label) {
                        label.parents(".grupo").removeClass('has-error');
                        label.remove();
                    },
                    messages       : {
                        trabajos       : {
                            required : "Por favor seleccione al menos un trabajo a realizar"
                        },
                        "maquina\\.id" : {
                            required : "Por favor seleccione el equipo al cual se le va a realizar el mantenimiento"
                        }
                    }
                });

                $("#btnAddMaterial").click(function () {
                    var $cant = $("#cantidad");
                    var $unidad = $("#unidad");
                    var $item = $("#item");
                    var $cod = $("#codigo");
                    var $marca = $("#marca");
                    var $obs = $("#observaciones");

                    var cant = $cant.val();
                    var unidad = $unidad.find("option:selected").text();
                    var item = $item.find("option:selected").text();
                    var cod = $cod.val();
                    var marca = $marca.val();
                    var obs = $obs.val();

                    var unidadId = $unidad.val();
                    var itemId = $item.val();

                    if (validarMaterial(cant, unidadId, itemId, cod, marca, obs)) {
                        var data = $("#frmMaterial").serialize();

                        var $tr = $("<tr>");
                        $tr.addClass("material");
                        $tr.data({
                            data          : data,
                            cantidad      : cant,
                            unidad        : unidadId,
                            item          : itemId,
                            codigo        : cod,
                            marca         : marca,
                            observaciones : obs
                        });

                        var $tdCant = $("<td>" + cant + "</td>");
                        var $tdUnidad = $("<td>" + unidad + "</td>");
                        var $tdItem = $("<td>" + item + "</td>");
                        var $tdCod = $("<td>" + cod + "</td>");
                        var $tdMarca = $("<td>" + marca + "</td>");
                        var $tdObs = $("<td>" + obs + "</td>");
                        var $tdButton = $("<td>");

                        var $btn = $("<a href='#' class='btn btn-danger btn-sm'><i class='fa fa-trash-o'></i></a>");
                        $btn.click(function () {
                            $(this).parents("tr").remove();
                            return false;
                        });

                        $tdButton.append($btn);

                        $tr.append($tdCant).append($tdUnidad).append($tdItem).append($tdCod).append($tdMarca).append($tdObs).append($tdButton);

                        $("#tbMaterial").prepend($tr);

                        $cant.val("");
                        $cod.val("");
                        $marca.val("");
                        $obs.val("");
                    } else {
                        log("No puede ingresar la misma combinación de unidad - item - marca más de una vez.", "error");
                    }
                    return false;
                });

                $("#btnAddPersona").click(function () {
                    var $pers = $("#persona");
                    var $horas = $("#horas");
                    var $fecha = $("#fecha_input");
                    var $obs = $("#observacionesp");

                    var pers = $pers.find("option:selected").text();
                    var horas = $horas.val();
                    var fecha = $fecha.val();
                    var obs = $obs.val();

                    var persId = $pers.val();

                    if (validarPersona(persId, horas, fecha, obs)) {
                        var data = $("#frmPersona").serialize();

                        var $tr = $("<tr>");
                        $tr.addClass("persona");
                        $tr.data({
                            data          : data,
                            persona       : persId,
                            horas         : horas,
                            fecha         : fecha,
                            observaciones : obs
                        });

                        var $tdPers = $("<td>" + pers + "</td>");
                        var $tdHoras = $("<td>" + horas + "</td>");
                        var $tdFecha = $("<td>" + fecha + "</td>");
                        var $tdObs = $("<td>" + obs + "</td>");
                        var $tdButton = $("<td>");

                        var $btn = $("<a href='#' class='btn btn-danger btn-sm'><i class='fa fa-trash-o'></i></a>");
                        $btn.click(function () {
                            $(this).parents("tr").remove();
                            return false;
                        });

                        $tdButton.append($btn);

                        $tr.append($tdPers).append($tdHoras).append($tdFecha).append($tdObs).append($tdButton);

                        $("#tbPersona").prepend($tr);

                        $horas.val("");
                        $fecha.val("");
                        $obs.val("");
                    } else {
                        log("No puede ingresar la misma combinación de persona - fecha más de una vez.", "error");
                    }
                    return false;
                });

                $("#guardar").click(function () {
                    var trabajos = "";
                    $(".clickable").each(function () {
                        if ($(this).data("state") == "on") {
                            trabajos += $(this).data("id") + ",";
                        }
                    });
                    var $frm = $(".frmSolicitud");
                    $("#trabajos").val(trabajos);
                    if ($frm.valid()) {

                        var mat = "", pers = "";
                        $("#tbMaterial").children().each(function () {
                            mat += $(this).data("cantidad") + "||" + $(this).data("unidad") + "||" + $(this).data("item") + "||" + $(this).data("codigo") +
                                   "||" + $(this).data("marca") + "||" + $(this).data("observaciones") + "**";
                        });
                        $("#tbPersona").children().each(function () {
                            pers += $(this).data("persona") + "||" + $(this).data("horas") + "||" +
                                    $(this).data("fecha") + "||" + $(this).data("observaciones") + "**";
                        });

                        if (mat != "" && pers != "") {
                            $("#materiales").val(mat);
                            $("#manoObra").val(pers);
                            openLoader("Generando solicitud");
                            $frm.submit();
                        } else {
                            if (mat == "") {
                                log("Por favor ingrese al menos un material", "error");
                            }
                            if (pers == "") {
                                log("Por favor ingrese al menos una persona", "error");
                            }
                        }
                    }
                    return false;
                });
            });
        </script>
    </body>
</html>