<%@ page import="arazu.parametros.TipoAsistencia" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<imp:js src="${resource(dir: 'js/plugins/bootstrap-colorpicker/dist/js', file: 'bootstrap-colorpicker.min.js')}"/>
<imp:css src="${resource(dir: 'js/plugins/bootstrap-colorpicker/dist/css', file: 'bootstrap-colorpicker.min.css')}"/>

<g:if test="${!tipoAsistenciaInstance}">
    <elm:notFound elem="TipoAsistencia" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmTipoAsistencia" id="${tipoAsistenciaInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-2" label="Codigo" claseField="col-sm-6">
                <g:textField name="codigo" maxlength="4" required="" class="form-control  required unique noEspacios" value="${tipoAsistenciaInstance?.codigo}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-6">
                <g:textField name="nombre" maxlength="100" required="" class="form-control  required" value="${tipoAsistenciaInstance?.nombre}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Orden" claseField="col-sm-6">
                <g:textField name="orden" maxlength="2" required="" class="form-control  required" value="${tipoAsistenciaInstance?.orden}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Color" claseField="col-sm-6">
                <div class="input-group input-color">
                    <g:textField name="color" maxlength="9" class="form-control " value="${tipoAsistenciaInstance?.color}"/>
                    <span class="input-group-addon"><i></i></span>
                </div>
            </elm:fieldRapido>

            <g:hiddenField name="icono" value="${tipoAsistenciaInstance.icono}"/>
            <elm:fieldRapido claseLabel="col-sm-2" label="Icono" claseField="col-sm-6 divIcono">
                <p class="form-control-static">
                    <g:if test="${!tipoAsistenciaInstance.icono}">
                        Seleccionar
                    </g:if>
                    <g:else>
                        <i class="${tipoAsistenciaInstance.icono}"></i>
                    </g:else>
                </p>
            </elm:fieldRapido>
        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmTipoAsistencia").validate({
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
            }, rules       : {
                codigo : {
                    remote : {
                        url  : "${createLink(controller:'tipoAsistencia', action: 'validar_unique_codigo_ajax')}",
                        type : "post",
                        data : {
                            id : "${tipoAsistenciaInstance?.id}"
                        }
                    }
                }
            },
            messages       : {
                codigo : {
                    remote : "Ya existe Codigo"
                }
            }
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormTipoAsistencia();
                return false;
            }
            return true;
        });

        $('.input-color').colorpicker();

        $(".divIcono").click(function () {
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:'icono', action:'dlgIconos_ajax')}",
                data    : {
                    selected : "${tipoAsistenciaInstance?.icono}"
                },
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgIconos",
                        title   : "Cambiar ícono de tipo de asistencia",
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            guardar  : {
                                id        : "btnSave",
                                label     : "<i class='fa fa-check'></i> Aceptar",
                                className : "btn-success",
                                callback  : function () {
                                    var icono = $(".ic.selected").data("str");
                                    $(".divIcono").html("<p class='form-control-static'><i class='" + icono + "'></i></p>");
                                    $("#icono").val(icono);
                                } //callback
                            } //guardar
                        } //buttons
                    }); //dialog
                    setTimeout(function () {
                        b.find(".form-control").first().focus()
                    }, 500);
                } //success
            }); //ajax
        });

    </script>

</g:else>