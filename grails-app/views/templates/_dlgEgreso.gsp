<%@ page import="arazu.seguridad.Persona" %>
<%--
  Created by IntelliJ IDEA.
  User: Luz
  Date: 3/3/2015
  Time: 12:34 AM
--%>

<imp:js src="${resource(dir: 'js', file: 'ui.js')}"/>
<form class="form-horizontal" id="frmEgreso">
    <g:if test="${ingreso}">
        <g:hiddenField name="id" value="${ingreso.id}"/>
    </g:if>
    <div class="form-group">
        <label class="col-sm-2 col-sm-offset-1 control-label">
            Item
        </label>

        <div class="col-sm-8">
            <p class="form-control-static">
                <g:if test="${ingreso}">
                    ${ingreso.item}
                </g:if>
                <g:elseif test="${pedido}">
                    ${pedido.item}
                </g:elseif>
            </p>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-2 col-sm-offset-1 control-label">
            Bodega
        </label>

        <div class="col-sm-8">
            <g:if test="${ingreso}">
                <p class="form-control-static">
                    ${ingreso.bodega}
                </p>
            </g:if>
            <g:elseif test="${pedido}">
                <g:select name="bodega" from="${bodegas}" optionKey="id" class="form-control" data-live-search="true"
                          optionValue="${{
                              it.bodega.toString() + ' (' + (it.cantidad - it.entregado) + ' ' + pedido.unidad.codigo + ')'
                          }}"/>
            </g:elseif>
        </div>
    </div>

    <div class="form-group">
        <label for="cantidad" class="col-sm-2 col-sm-offset-1 control-label">
            Cantidad
        </label>

        <g:if test="${ingreso}">
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
        </g:if>
        <g:elseif test="${pedido}">
            <p class="form-control-static">
                ${pedido.cantidadAprobada > 0 ? pedido.cantidadAprobada : pedido.cantidad}
            </p>
        </g:elseif>
    </div>

    <div class="form-group">
        <label for="persona" class="col-sm-2 col-sm-offset-1 control-label">
            Responsable
        </label>

        <div class="col-sm-8">
            <g:select name="persona" from="${Persona.list([sort: 'apellido'])}" optionKey="id" class="form-control"
                      data-live-search="true" value="${pedido?.deId}"/>
        </div>
    </div>

    <div class="checkbox col-sm-offset-1">
        <label>
            <input type="checkbox" value="ok" name="desecho" id="desecho"/>
            <strong>Ingresa igual cantidad de desecho</strong>
        </label>
    </div>

    <div class="row">
        <div class="col-sm-10 col-sm-offset-1 alert alert-danger">
            <i class="fa fa-warning"></i> Si no se realiza un ingreso con la misma cantidad de desecho que el egreso que se está realizando
        se generará un alerta y un e-mail a los usuarios de tipo gerencia.
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
            rules          : {
                observaciones : {
                    required : function () {
                        return !$("#desecho").is(":checked");
                    }
                }
            },
            messages       : {
                observaciones : {
                    required : "Debe indicar la razón por la cual no se realiza el ingreso para desecho"
                }
            },
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