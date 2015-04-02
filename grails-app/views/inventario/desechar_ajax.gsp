<%@ page import="arazu.parametros.TipoDesecho" %>
<imp:js src="${resource(dir: 'js', file: 'ui.js')}"/>

<div class="alert alert-info">
    <i class="fa fa-trash-o fa-2x"></i> Desechar <strong>${item}</strong>
    de la bodega <strong>${bodega}</strong>
</div>

<g:set var="desechosConPrecio" value="${TipoDesecho.findAllByRequierePrecio(1)}"/>
<g:form controller="inventario" action="hacerDesecho_ajax" name="frmDesecho">
    <g:hiddenField name="bodega" value="${bodega.id}"/>
    <g:hiddenField name="item" value="${item.id}"/>

    <div class="modal-contenido">
        <div class="row grupo">
            <div class="col-sm-2 show-label">
                <label for="precio">
                    Tipo
                </label>
            </div>

            <div class="col-sm-4">
                <elm:select name="tipoDesecho" from="${TipoDesecho.list()}" optionKey="id" optionClass="requierePrecio" class="form-control input-sm"/>
            </div>
        </div>

        <div class="row grupo">
            <div class="col-sm-2 show-label">
                <label for="donde">
                    Lugar
                </label>
            </div>

            <div class="col-sm-4">
                <g:textField name="donde" class="form-control input-sm required"/>
            </div>
        </div>

        <div class="row grupo">
            <div class="col-sm-2 show-label">
                <label for="responsable">
                    Responsable
                </label>
            </div>

            <div class="col-sm-4">
                <g:textField name="responsable" class="form-control input-sm "/>
            </div>
        </div>

        <div class="row grupo">
            <div class="col-sm-2 show-label">
                <label for="cantidad">
                    Cantidad
                </label>
            </div>

            <div class="col-sm-4">
                <div class="input-group">
                    <g:textField name="cantidad" class="form-control input-sm number required" style="text-align: right" max="${total}"/>
                    <span class="input-group-addon">${unidad.codigo}</span>
                </div>
            </div>

            <div class="col-sm-5">
                <p class="form-control-static">
                    de <strong>${total}${unidad.codigo}</strong> disponible${total == 1 ? '' : 's'}
                </p>
            </div>
        </div>

        <g:if test="${desechosConPrecio.size() > 0}">
            <div class="row grupo">
                <div class="col-sm-2 show-label">
                    <label for="precio">
                        Precio
                    </label>
                </div>

                <div class="col-sm-4">
                    <div class="input-group">
                        <g:textField name="precio" class="form-control input-sm number" style="text-align: right"/>
                        <span class="input-group-addon"><i class="fa fa-usd"></i></span>
                    </div>
                </div>

                <div class="col-sm-5">
                    <p class="form-control-static text-muted">
                        Sólo en caso de ${desechosConPrecio.join(', ')}
                    </p>
                </div>
            </div>
        </g:if>
    </div>
</g:form>

<script type="text/javascript">
    function validarTipoDesecho() {
        var desecho = $("#tipoDesecho").find("option:selected").attr("class");
        if (desecho.toString() == '1') {
            $("#precio").addClass("required");
        } else {
            $("#precio").removeClass("required");
        }
    }
    $(function () {
        validarTipoDesecho();
        $("#tipoDesecho").change(function () {
            validarTipoDesecho();
        });

        var validator = $("#frmDesecho").validate({
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
                submitFormDesecho();
                return false;
            }
            return true;
        });
    });
</script>