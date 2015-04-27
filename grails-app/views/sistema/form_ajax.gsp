<%@ page import="arazu.seguridad.Sistema" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!sistemaInstance}">
    <elm:notFound elem="Sistema" genero="o"/>
</g:if>
<g:else>

    <style type="text/css">
    .divIcono {
        cursor : pointer;
    }
    </style>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmSistema" id="${sistemaInstance?.id}"
                role="form" action="save_ajax" method="POST">

            <elm:fieldRapido claseLabel="col-sm-2" label="Nombre" claseField="col-sm-6">
                <g:textField name="nombre" required="" class="form-control  required" value="${sistemaInstance?.nombre}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Código" claseField="col-sm-6">
                <g:textField name="codigo" required="" maxlength="4" class="form-control  required" value="${sistemaInstance?.codigo}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Descripcion" claseField="col-sm-6">
                <g:textArea name="descripcion" class="form-control " value="${sistemaInstance?.descripcion}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Path Imagen" claseField="col-sm-6">
                <g:textField name="pathImagen" class="form-control " value="${sistemaInstance?.pathImagen}"/>
            </elm:fieldRapido>

            <g:hiddenField name="icono" value="${sistemaInstance.icono}"/>
            <elm:fieldRapido claseLabel="col-sm-2" label="Icono" claseField="col-sm-6 divIcono">
                <p class="form-control-static">
                    <g:if test="${!sistemaInstance.icono}">
                        Seleccionar
                    </g:if>
                    <g:else>
                        <i class="${sistemaInstance.icono}"></i>
                    </g:else>
                </p>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Orden" claseField="col-sm-2">
                <g:textField name="orden" value="${sistemaInstance.orden}" class="digits form-control  required" required=""/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Controlador" claseField="col-sm-6">
                <g:textField name="controlador" required="" class="form-control  required" value="${sistemaInstance?.controlador}"/>
            </elm:fieldRapido>

            <elm:fieldRapido claseLabel="col-sm-2" label="Acción" claseField="col-sm-6">
                <g:textField name="accion" required="" class="form-control  required" value="${sistemaInstance?.accion}"/>
            </elm:fieldRapido>
        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmSistema").validate({
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
            }

        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormSistema();
                return false;
            }
            return true;
        });

        $(".divIcono").click(function () {
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:'icono', action:'dlgIconos_ajax')}",
                data    : {
                    selected : "${sistemaInstance.icono}"
                },
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgIconos",
                        title   : "Cambiar ícono de ${sistemaInstance.nombre}",
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