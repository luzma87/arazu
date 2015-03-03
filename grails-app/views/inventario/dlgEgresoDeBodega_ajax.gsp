<%@ page import="arazu.seguridad.Persona" %>
<%--
  Created by IntelliJ IDEA.
  User: Luz
  Date: 3/3/2015
  Time: 12:34 AM
--%>

<imp:js src="${resource(dir: 'js', file: 'ui.js')}"/>
<form class="form-horizontal" id="frmEgreso">
    <g:hiddenField name="id" value="${ingreso.id}"/>
    <div class="form-group">
        <label class="col-sm-2 col-sm-offset-1 control-label">
            Item
        </label>

        <div class="col-sm-8">
            <p class="form-control-static">
                ${ingreso.item}
            </p>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-2 col-sm-offset-1 control-label">
            Bodega
        </label>

        <div class="col-sm-8">
            <p class="form-control-static">
                ${ingreso.bodega}
            </p>
        </div>
    </div>

    <div class="form-group">
        <label for="cantidad" class="col-sm-2 col-sm-offset-1 control-label">
            Cantidad
        </label>

        <div class="col-sm-4">
            <div class="input-group">
                <g:textField name="cantidad" class="form-control number required" max="${ingreso.saldo}"/>
                <span class="input-group-addon">${ingreso.unidad.codigo}</span>
            </div>
        </div>

        <div class="col-sm-4">
            <p class="form-control-static">
                <small>Máximo ${ingreso.saldo}</small>
            </p>
        </div>
    </div>

    <div class="form-group">
        <label for="persona" class="col-sm-2 col-sm-offset-1 control-label">
            Responsable
        </label>

        <div class="col-sm-8">
            <g:select name="persona" from="${Persona.list([sort: 'apellido'])}" optionKey="id" class="form-control"
                      data-live-search="true"/>
        </div>
    </div>

    <div class="form-group">
        <label for="observaciones" class="col-sm-2 col-sm-offset-1 control-label">
            Observaciones
        </label>

        <div class="col-sm-8">
            <g:textArea name="observaciones" class="form-control"/>
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
                submitEgreso();
                return false;
            }
        });
        var validator = $("#frmEgreso").validate({
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