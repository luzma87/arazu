<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 21/02/2015
  Time: 22:50
--%>
<div class="alert alert-info">
    <i class="fa fa-check fa-3x pull-left text-info text-shadow"></i>

    <p class="lead">¿Está seguro de que desea aprobar la nota de pedido?</p>

    <p>Pasará a un asistente de compras para que se asignen las cotizaciones</p>
</div>

<form id="frmAprobar">
    <div class="row">
        <div class="col-md-3">Asistente de compras</div>

        <div class="col-md-5">
            <g:select name="para" from="${asistentesCompras}" class="form-control input-sm required" optionKey="id"/>
        </div>
    </div>

    <div class="row">
        <div class="col-md-3">Clave de autorización</div>

        <div class="col-md-5">
            <div class="grupo">
                <div class="input-group input-group-sm">
                    <g:passwordField name="auth" class="form-control input-sm required"/>
                    <span class="input-group-addon">
                        <i class="fa fa-unlock-alt"></i>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-3">Observaciones</div>

        <div class="col-md-9">
            <g:textArea name="obs" class="form-control input-sm"/>
        </div>
    </div>
</form>

<script type="text/javascript">
    $(function () {
        $(window).keydown(function (event) {
            if (event.keyCode == 13) {
                event.preventDefault();
                return false;
            }
        });

        $(".form-control").keyup(function (ev) {
            if (ev.keyCode == 13) {
                ev.preventDefault();
                submitAprobar();
                return false;
            }
        });
        var validator = $("#frmAprobar").validate({
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
    })
</script>