<%@ page import="arazu.inventario.Bodega" %>
<g:each in="${bodegas}" var="bodega">
    <h4>${bodega.descripcion}
        <small>
            ${bodega.persona}
            <a href="#" class="btn btn-link btnInventario" data-id="${bodega.id}" data-nombre="${bodega.descripcion}">
                Ver inventario
            </a>
        </small>
    </h4>

    <form class="form-horizontal">
        <elm:fieldRapido claseLabel="col-sm-3" label="Enviar inventario a" claseField="col-sm-9">
            <g:select name="bodegaNew_${bodega.id}" from="${Bodega.findAllByIdNotEqual(bodega.id)}" optionKey="id" class="form-control bdNew"/>
        </elm:fieldRapido>
    </form>

</g:each>

<script type="text/javascript">
    $(function () {
        $(".btnInventario").click(function () {
            var id = $(this).data("id");
            var nombre = $(this).data("nombre");
            openLoader();
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:'inventario', action:'inventarioResumen_ajax')}",
                data    : {
                    id : id
                },
                success : function (msg) {
                    closeLoader();
                    bootbox.dialog({
                        id      : "dlgInventarioBodega",
                        title   : "Inventario de " + nombre,
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cerrar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            }
                        } //buttons
                    }); //dialog
                } //success
            }); //ajax
            return false;
        });
    });
</script>