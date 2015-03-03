<%@ page import="arazu.inventario.Bodega; arazu.seguridad.Persona" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 01/03/2015
  Time: 16:26
--%>
<imp:js src="${resource(dir: 'js', file: 'ui.js')}"/>
<form class="form-horizontal" id="frmEgreso">

    <div class="form-group">
        <label class="col-sm-2 col-sm-offset-1 control-label">
            Item
        </label>

        <div class="col-sm-8">
            <p class="form-control-static">
                ${pedido.item}
            </p>
        </div>
    </div>

    <div class="form-group">
        <label for="bodega" class="col-sm-2 col-sm-offset-1 control-label">
            Bodega
        </label>

        <div class="col-sm-8">
            <g:select name="bodega" from="${bodegas}" optionKey="id" class="form-control" data-live-search="true"
                      optionValue="${{
                          it.bodega.toString() + ' (' + (it.cantidad - it.entregado) + ' ' + pedido.unidad.codigo + ')'
                      }}"/>
        </div>
    </div>

    <div class="form-group">
        <label for="bodega" class="col-sm-2 col-sm-offset-1 control-label">
            Cantidad
        </label>

        <div class="col-sm-3">
            <div class="input-group">
                <g:textField name="cant" class="form-control"/>
                <span class="input-group-addon">${pedido.unidad.codigo}</span>
            </div>
        </div>

        <div class="col-md-4">
            <p class="form-control-static" id="divExist">

            </p>
        </div>
    </div>

    <div class="form-group">
        <label for="persona" class="col-sm-2 col-sm-offset-1 control-label">
            Responsable
        </label>

        <div class="col-sm-8">
            <g:select name="persona" from="${Persona.list([sort: 'apellido'])}" optionKey="id" class="form-control"
                      data-live-search="true" value="${pedido.deId}"/>
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
    function validaBodega() {
        $("#divExist").html(spinner);
        var id = $("#bodega").val();
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'inventario', action:'cargarExistenciasBodega_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                $("#divExist").html(msg + "${pedido.unidad.codigo} en existencia");
            }
        });
    }
    $(function () {
        validaBodega();
        $("#bodega").change(function () {
            validaBodega();
        });
    });
</script>