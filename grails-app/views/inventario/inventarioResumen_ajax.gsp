<div class="modal-contenido">
    <table class="table table-striped table-hover table-bordered" style="margin-top: 10px">
        <thead>
            <tr>
                <th>Item</th>
                <th>Unidad</th>
                <th>Cantidad</th>
            </tr>
        </thead>
        <tbody>
            <g:if test="${ingresos.size() > 0}">
                <g:each in="${ingresos}" var="igg" status="i">
                    <g:set var="ig" value="${igg.value}"/>
                    <tr>
                        <td>
                            <elm:textoBusqueda search="${params.search_item}">
                                ${ig.item.descripcion}
                            </elm:textoBusqueda>
                        </td>
                        <td>
                            ${ig.unidad}
                        </td>
                        <td class="text-center">
                            ${ig.saldo.toInteger()}
                        </td>
                    </tr>
                </g:each>
            </g:if>
            <g:else>
                <tr class="danger">
                    <td class="text-center" colspan="3">
                        <g:if test="${(params.search_desde && params.search_desde != '') ||
                                (params.search_hasta && params.search_hasta != '') ||
                                (params.search_item && params.search_item != '')}">
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
</div>