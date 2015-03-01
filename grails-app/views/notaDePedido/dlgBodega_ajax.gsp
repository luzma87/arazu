<imp:js src="${resource(dir: 'js', file: 'ui.js')}"/>
<div class="alert alert-primary">
    <i class="fa fa-archive fa-3x pull-left text-shadow"></i>

    <p class="lead">¿Está seguro de que desea notificar que los items de esta nota de pedido están en bodega?</p>

    <p>Seleccione una o más bodegas ingresando la cantidad que desea retirar de cada una para informar a los
    responsables de bodega respectivos</p>

    <p style="font-size: larger">El pedido es de ${g.formatNumber(number: nota.cantidad, minFractionDigits: 2, maxFractionDigits: 2)}${nota.unidad.codigo}
        de ${nota.item}</p>
</div>

<form id="frmBodega">
    <div style="max-height: 200px; overflow: auto;">
        <table class="table table-striped table-hover table-bordered">
            <thead>
                <tr>
                    <th>Bodega</th>
                    <th>Cantidad</th>
                    <th style="width: 150px;">Retirar</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${existencias.values()}" var="ex">
                    <tr>
                        <td>
                            ${ex.bodega}
                        </td>
                        <td class="text-right">
                            <g:formatNumber number="${ex.total}" maxFractionDigits="2" minFractionDigits="2"/>${ex.unidad.codigo}
                        </td>
                        <td>
                            <div class="input-group">
                                <g:textField name="ret_${ex.bodega.id}" class="form-control input-sm number" max="${ex.total}"/>
                                <span class="input-group-addon">${ex.unidad.codigo}</span>
                            </div>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </div>

    <div class="row">
        <div class="col-md-1">
            <strong>TOTAL</strong>
        </div>

        <div class="col-md-2" id="divTotal">
            <g:formatNumber number="0" maxFractionDigits="2" minFractionDigits="2"/>
        </div>
    </div>

    <div class="row">
        <div class="col-md-2">Jefe de compras</div>

        <div class="col-md-3">
            <g:select name="para" from="${jefesCompras}" class="form-control input-sm required" optionKey="id"
                      noSelection="['': '']"/>
        </div>

        <div class="col-md-2">Autorizar pedido de</div>

        <div class="col-md-2">
            <div class="input-group">
                <g:textField name="cant" class="form-control input-sm number" value="${0}"/>
                <span class="input-group-addon">${nota.unidad.codigo}</span>
            </div>
        </div>

        <div class="col-md-3">
            ${nota.item}
        </div>
    </div>

    <div class="row">
        <div class="col-md-2">Clave de autorización</div>

        <div class="col-md-3">
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
        <div class="col-md-2">Observaciones</div>

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
                submitBodega();
                return false;
            }
        });

        $(".number").keyup(function () {
            var total = 0;
            $(".number").each(function () {
                var v = parseFloat($(this).val());
                if (isNaN(v)) {
                    v = 0;
                }
                total += v;
            });
            $("#divTotal").text(number_format(total, 2, ".", ""));
        });

        var validator = $("#frmBodega").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                console.log(element, error);
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
            rules          : {
                para                : {
                    required : function (element) {
                        var c = $.trim($("#cant").val());
                        console.log(c, c != "", parseFloat(c) > 0, c != "" && parseFloat(c) > 0);
                        return c != "" && parseFloat(c) > 0;
                    }
                },
                cant                : {
                    required : function (element) {
                        var p = $("#para").val();
                        console.log(p, p != "");
                        return p != "";
                    }
                },
                <g:each in="${existencias.values()}" var="ex">
                ret_${ex.bodega.id} : {
                    require_from_group : [1, ".number"]
                },
                </g:each>
            }
        });
    })
</script>