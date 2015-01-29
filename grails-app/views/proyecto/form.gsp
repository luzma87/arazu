<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 28/01/2015
  Time: 22:01
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Nuevo Proyecto</title>

        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?language=es&key=AIzaSyDffD8MyvUA80jsioz1yh-o-iP6ZR4Prvc"></script>

        <style type="text/css">
        #map {
            height     : 350px;
            background : #6495ed;
            border     : double 5px #42619a;
        }
        </style>

    </head>

    <body>

        <g:if test="${!proyectoInstance}">
            <elm:message tipo="notFound">No se encontró elproyecto solicitado</elm:message>
        </g:if>
        <g:else>

            <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

            <!-- botones -->
            <div class="btn-toolbar toolbar">
                <div class="btn-group">
                    <g:link action="list" class="btn btn-default">
                        <i class="fa fa-list"></i> Lista de proyectos
                    </g:link>
                </div>

                <div class="btn-group">
                    <a href="#" id="btnSave" class="btn btn-success">
                        <i class="fa fa-save"></i> Guardar
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 col-sm-12">
                    <g:form class="form-horizontal" name="frmProyecto" id="${proyectoInstance?.id}"
                            role="form" action="save" method="POST">

                        <g:hiddenField name="lat" class="required" required=""/>
                        <g:hiddenField name="long"/>
                        <g:hiddenField name="zoom"/>

                        <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-10">
                            <g:textField name="nombre" required="" class="form-control  required" value="${proyectoInstance?.nombre}"/>
                        </elm:fieldRapido>

                        <elm:fieldRapido claseLabel="col-sm-2" label="Entidad" claseField="col-sm-10">
                            <g:textField name="entidad" required="" class="form-control  required" value="${proyectoInstance?.entidad}"/>
                        </elm:fieldRapido>

                        <elm:fieldRapidoDoble claseLabel1="col-sm-4" label1="Fecha Inicio" claseField1="col-sm-8"
                                              claseLabel2="col-sm-4" label2="Fecha Fin" claseField2="col-sm-8">
                            <elm:datepicker name="fechaInicio" class="datepicker form-control  required" value="${proyectoInstance?.fechaInicio}"/>
                            <hr/>
                            <elm:datepicker name="fechaFin" class="datepicker form-control " value="${proyectoInstance?.fechaFin}"/>
                        </elm:fieldRapidoDoble>

                        <elm:fieldRapido claseLabel="col-sm-2" label="Descripción" claseField="col-sm-10">
                            <g:textArea style="height:100px;" name="descripcion" required="" class="form-control  required" value="${proyectoInstance?.descripcion}"/>
                        </elm:fieldRapido>
                    </g:form>
                </div>

                <div class="col-md-6 col-sm-12 corner-all" id="map">
                </div>
            </div>

            <script type="text/javascript">
                var map;
                var marker;
                function placeMarker(location) {
                    if (marker) {
                        marker.setMap(null);
                    }

                    var image = {
                        url    : '${resource(dir:"images/markers", file: "flag_32.png")}',
                        size   : new google.maps.Size(32, 32),
                        origin : new google.maps.Point(0, 0),
                        anchor : new google.maps.Point(10, 28)
                    };

                    marker = new google.maps.Marker({
                        position  : location,
                        map       : map,
                        animation : google.maps.Animation.DROP,
                        draggable : true,
                        icon      : image,
                        title     : "Ubicar proyecto aquí"
                    });
                    google.maps.event.addListener(marker, 'dragend', function (evt) {
                        $("#lat").val(evt.latLng.lat());
                        $("#long").val(evt.latLng.lng());
                    });
                    $("#lat").val(location.lat());
                    $("#long").val(location.lng());
                    $("#zoom").val(map.getZoom());
                }

                function initialize() {
                    var mapOptions = {
                        center : {
                            lat : -2.074938318155129,
                            lng : 282.54310888671876
                        },
                        zoom   : 6
                    };
                    map = new google.maps.Map(document.getElementById('map'), mapOptions);

                    google.maps.event.addListener(map, 'click', function (event) {
                        placeMarker(event.latLng);
                    });
                    google.maps.event.addListener(map, 'zoom_changed', function (event) {
                        $("#zoom").val(map.getZoom());
                    });
                }
                google.maps.event.addDomListener(window, 'load', initialize);

                $(function () {
                    $("#lat").val("");
                    $("#long").val("");
                    $("#zoom").val("");

                    $("#btnSave").click(function () {
                        openLoader("Guardando proyecto");
                        $("#frmProyecto").submit();
                    });

                    var validator = $("#frmProyecto").validate({
                        ignore         : [],
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
                            lat : {
                                required : "Ubique el proyecto en el mapa"
                            }
                        }
                    });
                    $(".form-control").keydown(function (ev) {
                        if (ev.keyCode == 13) {
                            submitFormProyecto();
                            return false;
                        }
                        return true;
                    });
                });
            </script>

        </g:else>

    </body>
</html>