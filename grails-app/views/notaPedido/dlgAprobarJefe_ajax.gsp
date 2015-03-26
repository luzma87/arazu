<div class="alert alert-info">
    <i class="fa fa-check fa-3x pull-left text-info text-shadow"></i>

    <p class="lead">¿Está seguro de que desea aprobar la nota de pedido?</p>

    <p>Pasará a un jefe de compras para que se le asigne un asistente</p>
</div>

<g:render template="/templates/dlgAprobar"
          model="[nota: nota, lbl: 'Jefe de compras', from: jefesCompras]"/>

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