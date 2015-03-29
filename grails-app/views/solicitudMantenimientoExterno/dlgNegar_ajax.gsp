<div class="alert alert-danger">
    <i class="fa fa-times fa-3x pull-left text-danger text-shadow"></i>

    <p class="lead">¿Está seguro de que desea negar la solicitud de mantenimiento externo?</p>
</div>

<form id="frmNegar">

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
        <div class="col-md-3">Razón</div>

        <div class="col-md-9">
            <g:textArea name="razon" class="form-control input-sm required"/>
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
                submitNegar();
                return false;
            }
        });
        var validator = $("#frmNegar").validate({
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