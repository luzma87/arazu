<%@ page import="arazu.proyectos.Proyecto" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Proyecto</title>
    </head>

    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link action="form" class="btn btn-default">
                    <i class="fa fa-file-o"></i> Crear
                </g:link>
            </div>

            <div class="btn-group pull-right col-md-3">
                <div class="input-group">
                    <input type="text" class="form-control input-search" placeholder="Buscar" value="${params.search}">
                    <span class="input-group-btn">
                        <g:link controller="proyecto" action="list" class="btn btn-default btn-search">
                            <i class="fa fa-search"></i>&nbsp;
                        </g:link>
                    </span>
                </div><!-- /input-group -->
            </div>
        </div>

        <table class="table table-condensed table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <g:sortableColumn property="nombre" title="Nombre"/>
                    <g:sortableColumn property="descripcion" title="Descripción"/>
                    <g:sortableColumn property="entidad" title="Entidad"/>
                    <g:sortableColumn property="fechaInicio" title="Fecha Inicio"/>
                    <g:sortableColumn property="fechaFin" title="Fecha Fin"/>
                </tr>
            </thead>
            <tbody>
                <g:if test="${proyectoInstanceCount > 0}">
                    <g:each in="${proyectoInstanceList}" status="i" var="proyectoInstance">
                        <tr data-id="${proyectoInstance.id}">
                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${proyectoInstance}" field="nombre"/></elm:textoBusqueda></td>
                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${proyectoInstance}" field="descripcion"/></elm:textoBusqueda></td>
                            <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${proyectoInstance}" field="entidad"/></elm:textoBusqueda></td>
                            <td><g:formatDate date="${proyectoInstance.fechaInicio}" format="dd-MM-yyyy"/></td>
                            <td><g:formatDate date="${proyectoInstance.fechaFin}" format="dd-MM-yyyy"/></td>
                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr class="danger">
                        <td class="text-center" colspan="8">
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

        <elm:pagination total="${proyectoInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            function deleteProyecto(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                              "¿Está seguro que desea eliminar el Proyecto seleccionado? Esta acción no se puede deshacer.</p>",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        eliminar : {
                            label     : "<i class='fa fa-trash-o'></i> Eliminar",
                            className : "btn-danger",
                            callback  : function () {
                                openLoader("Eliminando Proyecto");
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(controller:'proyecto', action:'delete_ajax')}',
                                    data    : {
                                        id : itemId
                                    },
                                    success : function (msg) {
                                        var parts = msg.split("*");
                                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                        if (parts[0] == "SUCCESS") {
                                            setTimeout(function () {
                                                location.reload(true);
                                            }, 1000);
                                        } else {
                                            closeLoader();
                                        }
                                    },
                                    error   : function () {
                                        log("Ha ocurrido un error interno", "Error");
                                        closeLoader();
                                    }
                                });
                            }
                        }
                    }
                });
            }

            $(function () {

                $("tbody>tr").contextMenu({
                    items  : {
                        header : {
                            label  : "Acciones",
                            header : true
                        },
                        ver    : {
                            label  : "Ver",
                            icon   : "fa fa-search",
                            action : function ($element) {
                                var id = $element.data("id");
                                location.href = "${createLink(controller: 'proyecto', action:'show')}/" + id;
                            }
                        },
                        editar : {
                            label  : "Editar",
                            icon   : "fa fa-pencil",
                            action : function ($element) {
                                var id = $element.data("id");
                                location.href = "${createLink(controller: 'proyecto', action:'form')}/" + id;
                            }
                        }/*,
                         eliminar : {
                         label            : "Eliminar",
                         icon             : "fa fa-trash-o",
                         separator_before : true,
                         action           : function ($element) {
                         var id = $element.data("id");
                         deleteProyecto(id);
                         }
                         }*/
                    },
                    onShow : function ($element) {
                        $element.addClass("success");
                    },
                    onHide : function ($element) {
                        $(".success").removeClass("success");
                    }
                });
            });
        </script>

    </body>
</html>
