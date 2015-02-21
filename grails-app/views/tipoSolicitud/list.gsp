<%@ page import="arazu.parametros.TipoSolicitud" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de TipoSolicitud</title>
    </head>

    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link class="btn btn-default" controller="inicio" action="parametros">
                    <i class="fa fa-cogs"></i> Parámetros
                </g:link>
            %{--<a href="#" class="btn btn-default btnCrear">--}%
            %{--<i class="fa fa-file-o"></i> Crear--}%
            %{--</a>--}%
            </div>

            <div class="btn-group pull-right col-md-3">
                <div class="input-group">
                    <input type="text" class="form-control input-search" placeholder="Buscar" value="${params.search}">
                    <span class="input-group-btn">
                        <g:link controller="tipoSolicitud" action="list" class="btn btn-default btn-search">
                            <i class="fa fa-search"></i>&nbsp;
                        </g:link>
                    </span>
                </div><!-- /input-group -->
            </div>
        </div>

        <table class="table table-condensed table-bordered table-striped table-hover">
            <thead>
                <tr>

                    <g:sortableColumn property="descripcion" title="Descripcion"/>

                    <g:sortableColumn property="codigo" title="Codigo"/>

                    <g:sortableColumn property="nombre" title="Nombre"/>

                </tr>
            </thead>
            <tbody>
                <g:if test="${tipoSolicitudInstanceCount > 0}">
                    <g:each in="${tipoSolicitudInstanceList}" status="i" var="tipoSolicitudInstance">
                        <tr data-id="${tipoSolicitudInstance.id}">

                            <td>${tipoSolicitudInstance.descripcion}</td>

                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${tipoSolicitudInstance}" field="codigo"/></elm:textoBusqueda></td>

                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${tipoSolicitudInstance}" field="nombre"/></elm:textoBusqueda></td>

                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr class="danger">
                        <td class="text-center" colspan="3">
                            <g:if test="${params.search && params.search != ''}">
                                No se encontraron resultados para su búsqueda
                            </g:if>
                            <g:else>
                                No se encontraron registros que mostrar
                            </g:else>
                        </td>
                    </tr>
                </g:else>
            </tbody>
        </table>

        <elm:pagination total="${tipoSolicitudInstanceCount}" params="${params}"/>

        %{--<script type="text/javascript">--}%
        %{--var id = null;--}%
        %{--function submitFormTipoSolicitud() {--}%
        %{--var $form = $("#frmTipoSolicitud");--}%
        %{--var $btn = $("#dlgCreateEditTipoSolicitud").find("#btnSave");--}%
        %{--if ($form.valid()) {--}%
        %{--$btn.replaceWith(spinner);--}%
        %{--openLoader("Guardando TipoSolicitud");--}%
        %{--$.ajax({--}%
        %{--type    : "POST",--}%
        %{--url     : $form.attr("action"),--}%
        %{--data    : $form.serialize(),--}%
        %{--success : function (msg) {--}%
        %{--var parts = msg.split("*");--}%
        %{--log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)--}%
        %{--setTimeout(function() {--}%
        %{--if (parts[0] == "SUCCESS") {--}%
        %{--location.reload(true);--}%
        %{--} else {--}%
        %{--spinner.replaceWith($btn);--}%
        %{--closeLoader();--}%
        %{--return false;--}%
        %{--}--}%
        %{--}, 1000);--}%
        %{--},--}%
        %{--error: function() {--}%
        %{--log("Ha ocurrido un error interno", "Error");--}%
        %{--closeLoader();--}%
        %{--}--}%
        %{--});--}%
        %{--} else {--}%
        %{--return false;--}%
        %{--} //else--}%
        %{--}--}%
        %{--function deleteTipoSolicitud(itemId) {--}%
        %{--bootbox.dialog({--}%
        %{--title   : "Alerta",--}%
        %{--message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +--}%
        %{--"¿Está seguro que desea eliminar el TipoSolicitud seleccionado? Esta acción no se puede deshacer.</p>",--}%
        %{--buttons : {--}%
        %{--cancelar : {--}%
        %{--label     : "Cancelar",--}%
        %{--className : "btn-primary",--}%
        %{--callback  : function () {--}%
        %{--}--}%
        %{--},--}%
        %{--eliminar : {--}%
        %{--label     : "<i class='fa fa-trash-o'></i> Eliminar",--}%
        %{--className : "btn-danger",--}%
        %{--callback  : function () {--}%
        %{--openLoader("Eliminando TipoSolicitud");--}%
        %{--$.ajax({--}%
        %{--type    : "POST",--}%
        %{--url     : '${createLink(controller:'tipoSolicitud', action:'delete_ajax')}',--}%
        %{--data    : {--}%
        %{--id : itemId--}%
        %{--},--}%
        %{--success : function (msg) {--}%
        %{--var parts = msg.split("*");--}%
        %{--log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)--}%
        %{--if (parts[0] == "SUCCESS") {--}%
        %{--setTimeout(function() {--}%
        %{--location.reload(true);--}%
        %{--}, 1000);--}%
        %{--} else {--}%
        %{--closeLoader();--}%
        %{--}--}%
        %{--},--}%
        %{--error: function() {--}%
        %{--log("Ha ocurrido un error interno", "Error");--}%
        %{--closeLoader();--}%
        %{--}--}%
        %{--});--}%
        %{--}--}%
        %{--}--}%
        %{--}--}%
        %{--});--}%
        %{--}--}%
        %{--function createEditTipoSolicitud(id) {--}%
        %{--var title = id ? "Editar" : "Crear";--}%
        %{--var data = id ? { id: id } : {};--}%
        %{--$.ajax({--}%
        %{--type    : "POST",--}%
        %{--url     : "${createLink(controller:'tipoSolicitud', action:'form_ajax')}",--}%
        %{--data    : data,--}%
        %{--success : function (msg) {--}%
        %{--var b = bootbox.dialog({--}%
        %{--id      : "dlgCreateEditTipoSolicitud",--}%
        %{--title   : title + " TipoSolicitud",--}%
        %{----}%
        %{--message : msg,--}%
        %{--buttons : {--}%
        %{--cancelar : {--}%
        %{--label     : "Cancelar",--}%
        %{--className : "btn-primary",--}%
        %{--callback  : function () {--}%
        %{--}--}%
        %{--},--}%
        %{--guardar  : {--}%
        %{--id        : "btnSave",--}%
        %{--label     : "<i class='fa fa-save'></i> Guardar",--}%
        %{--className : "btn-success",--}%
        %{--callback  : function () {--}%
        %{--return submitFormTipoSolicitud();--}%
        %{--} //callback--}%
        %{--} //guardar--}%
        %{--} //buttons--}%
        %{--}); //dialog--}%
        %{--setTimeout(function () {--}%
        %{--b.find(".form-control").first().focus()--}%
        %{--}, 500);--}%
        %{--} //success--}%
        %{--}); //ajax--}%
        %{--} //createEdit--}%

        %{--$(function () {--}%

        %{--$(".btnCrear").click(function() {--}%
        %{--createEditTipoSolicitud();--}%
        %{--return false;--}%
        %{--});--}%

        %{--$("tbody>tr").contextMenu({--}%
        %{--items  : {--}%
        %{--header   : {--}%
        %{--label  : "Acciones",--}%
        %{--header : true--}%
        %{--},--}%
        %{--ver      : {--}%
        %{--label  : "Ver",--}%
        %{--icon   : "fa fa-search",--}%
        %{--action : function ($element) {--}%
        %{--var id = $element.data("id");--}%
        %{--$.ajax({--}%
        %{--type    : "POST",--}%
        %{--url     : "${createLink(controller:'tipoSolicitud', action:'show_ajax')}",--}%
        %{--data    : {--}%
        %{--id : id--}%
        %{--},--}%
        %{--success : function (msg) {--}%
        %{--bootbox.dialog({--}%
        %{--title   : "Ver TipoSolicitud",--}%
        %{----}%
        %{--message : msg,--}%
        %{--buttons : {--}%
        %{--ok : {--}%
        %{--label     : "Aceptar",--}%
        %{--className : "btn-primary",--}%
        %{--callback  : function () {--}%
        %{--}--}%
        %{--}--}%
        %{--}--}%
        %{--});--}%
        %{--}--}%
        %{--});--}%
        %{--}--}%
        %{--},--}%
        %{--editar   : {--}%
        %{--label  : "Editar",--}%
        %{--icon   : "fa fa-pencil",--}%
        %{--action : function ($element) {--}%
        %{--var id = $element.data("id");--}%
        %{--createEditTipoSolicitud(id);--}%
        %{--}--}%
        %{--},--}%
        %{--eliminar : {--}%
        %{--label            : "Eliminar",--}%
        %{--icon             : "fa fa-trash-o",--}%
        %{--separator_before : true,--}%
        %{--action           : function ($element) {--}%
        %{--var id = $element.data("id");--}%
        %{--deleteTipoSolicitud(id);--}%
        %{--}--}%
        %{--}--}%
        %{--},--}%
        %{--onShow : function ($element) {--}%
        %{--$element.addClass("success");--}%
        %{--},--}%
        %{--onHide : function ($element) {--}%
        %{--$(".success").removeClass("success");--}%
        %{--}--}%
        %{--});--}%
        %{--});--}%
        %{--</script>--}%

    </body>
</html>
