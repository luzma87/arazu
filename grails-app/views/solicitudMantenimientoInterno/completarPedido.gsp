<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 26/03/15
  Time: 10:52 AM
--%>

<%@ page import="arazu.solicitudes.DetalleTrabajo; arazu.items.Item; arazu.seguridad.Persona; arazu.parametros.Unidad; arazu.parametros.TipoTrabajo; arazu.proyectos.Proyecto" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Solicitud de mantenimiento interno</title>
        <style type="text/css">
        .clickable {
            cursor : pointer;
        }

        body {
            padding-bottom : 50px;
        }
        </style>
    </head>

    <body>
        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
        <elm:container tipo="horizontal" titulo="Completar formulario de mantenimiento interno">
            <g:form class="frmSolicitud" action="saveSolicitud_ignore">
                <div class="row">
                    <div class="col-md-1">
                        <label class=" control-label">
                            Equipo
                        </label>
                    </div>

                    <div class="col-md-5 grupo">
                        ${solicitud.maquinaria}
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Número
                        </label>
                    </div>

                    <div class="col-md-2">
                        ${solicitud.numero}
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Fecha
                        </label>
                    </div>

                    <div class="col-md-2">
                        ${solicitud.fecha.format("dd-MM-yyyy hh:mm:ss")}
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-1">
                        <label class=" control-label">
                            De
                        </label>
                    </div>

                    <div class="col-md-2">
                        ${solicitud.de}
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Para
                        </label>
                    </div>

                    <div class="col-md-2">
                        ${solicitud.paraAF}
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Proyecto
                        </label>
                    </div>

                    <div class="col-md-2">
                        ${solicitud.proyecto}
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Localización
                        </label>
                    </div>

                    <div class="col-md-2 grupo">
                        ${solicitud.localizacion}
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-1">
                        <label class=" control-label">
                            Horómetro
                        </label>
                    </div>

                    <div class="col-md-2 grupo">
                        ${solicitud.horometro}
                    </div>

                    <div class="col-md-1">
                        <label class=" control-label">
                            Kilometraje
                        </label>
                    </div>

                    <div class="col-md-2 grupo">
                        ${solicitud.kilometraje}
                    </div>
                </div>

                <div class="grupo">
                    <div class="row">
                        <div class="col-md-12 text-info">
                            <h3>Trabajos a realizar</h3>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            ${DetalleTrabajo.findAllBySolicitudMantenimientoInterno(solicitud).tipoTrabajo.join(", ")}
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 text-info">
                        <h3>Detalle de los trabajos a realizar</h3>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 grupo ">
                        ${solicitud.detalles}
                    </div>
                </div>

            %{--<g:hiddenField name="materiales"/>--}%
            %{--<g:hiddenField name="manoObra"/>--}%

            </g:form>


            <div class="row">
                <div class="col-md-12 text-info">
                    <h3>Mano de obra</h3>
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
                                        <g:select name="persona" from="${Persona.list([sort: 'apellido'])}" data-live-search="true" data-width="150px"/>
                                    </td>
                                    <td>
                                        <g:textField name="horas" class="form-control input-sm number"/>
                                    </td>
                                    <td class="col-md-2">
                                        <elm:datepicker name="fecha" class="datepicker form-control input-sm" minDate="${solicitud.fecha}"/>
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
                            </tbody>
                        </table>
                    </div>
                </div>
            </form>

            <div class="row">
                <div class="col-md-12 text-info">
                    <h3>Repuestos y materiales utilizados</h3>
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
                                        <g:select name="item" from="${Item.list([sort: 'descripcion'])}" optionKey="id"/>
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
                                        <td><a href="#" class="btn btn-sm btn-danger btnDeleteMaterial"><i class="fa fa-trash-o"></i>
                                        </a></td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </form>
        </elm:container>


        <script type="text/javascript">

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

            function deleteMaterial(id, $tr) {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'deleteMaterial_ajax')}",
                    data    : {
                        id : id
                    },
                    success : function (msg) {
                        var parts = msg.split("*");
                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                        if (parts[0] == "SUCCESS") {
                            $tr.remove();
                        }
                    },
                    error   : function () {
                        log("Ha ocurrido un error interno", "Error");
                        closeLoader();
                    }
                });
            }

            $(function () {

                $(".btnDeleteMaterial").click(function () {
                    deleteMaterial($(this).parents("tr").data("id"), $(this).parents("tr"));
                    return false;
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
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'saveMaterial_ajax')}",
                            data    : {
                                id            : "${solicitud.id}",
                                cantidad      : cant,
                                unidad        : unidadId,
                                item          : itemId,
                                codigo        : cod,
                                marca         : marca,
                                observaciones : obs
                            },
                            success : function (msg) {
                                var parts = msg.split("*");
                                log(parts[2], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "SUCCESS") {
                                    var data = $("#frmMaterial").serialize();

                                    var $tr = $("<tr>");
                                    $tr.addClass("material");
                                    $tr.data({
                                        data          : data,
                                        id            : parts[1],
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
                                        deleteMaterial(parts[1], $tr);
                                        return false;
                                    });

                                    $tdButton.append($btn);

                                    $tr.append($tdCant).append($tdUnidad).append($tdItem).append($tdCod).append($tdMarca).append($tdObs).append($tdButton);

                                    $("#tbMaterial").prepend($tr);

                                    $cant.val("");
                                    $cod.val("");
                                    $marca.val("");
                                    $obs.val("");
                                }

                            },
                            error   : function () {
                                log("Ha ocurrido un error interno", "Error");
                                closeLoader();
                            }
                        });
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
            });
        </script>

    </body>
</html>