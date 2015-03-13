<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 25/02/2015
  Time: 0:26
--%>
<div class="alert alert-info">
    <i class="fa fa-check fa-3x pull-left text-info text-shadow"></i>

    <p class="lead">¿Está seguro de que desea aprobar definitivamente la nota de pedido?</p>
</div>

<form id="frmAprobar">
    <div class="row">
        <div class="col-md-3">Cotización</div>

        <div class="col-md-5">
            <g:select name="cot" from="${cots}" class="form-control input-sm required" optionKey="id"
                      optionValue="${{
                          it.proveedor + ' (' +
                                  g.formatNumber(number: it.valor * (nota.cantidadAprobada > 0 ? nota.cantidadAprobada : nota.cantidad), type: 'currency') +
                                  ', ' + it.diasEntrega + ' día' + (it.diasEntrega == 1 ? '' : 's') +
                                  ')'
                      }}"/>
        </div>
    </div>

    <div class="row">
        <div class="col-md-3">Cantidad</div>

        <div class="col-md-3">
            <div class="input-group">
                <g:textField name="cant" class="form-control input-sm number"
                             value="${nota.cantidadAprobada != 0 ? nota.cantidadAprobada : nota.cantidad}"/>
                <span class="input-group-addon">${nota.unidad.codigo}</span>
            </div>
        </div>

        <div class="col-md-3">
            ${nota.item}
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
        <div class="col-md-3">Prioridad</div>

        <div class="col-md-6">
            <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-default">
                    <input type="radio" name="prioridad" value="1AL" autocomplete="off"><i class="fa fa-flag text-danger"></i> Alta
                </label>
                <label class="btn btn-default active">
                    <input type="radio" name="prioridad" value="2MD" autocomplete="off" checked><i class="fa fa-flag text-warning"></i> Media
                </label>
                <label class="btn btn-default">
                    <input type="radio" name="prioridad" value="3BJ" autocomplete="off"><i class="fa fa-flag text-success"></i> Baja
                </label>
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