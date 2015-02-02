<imp:js src="${resource(dir: 'js', file: 'ui.js')}"/>

<g:if test="${funciones.size() > 0}">
    <table class="table table-bordered tale-condensed table-hover">
        <thead>
            <tr>
                <th>
                    Persona
                </th>
                <th>
                    Cargo
                </th>
                <th width=""></th>
            </tr>
        </thead>
        <tbody id="tb_funciones">
            <g:each in="${funciones}" var="funcion">
                <tr class="pr_${funcion.personaId} cr_${funcion.cargoId}">
                    <td>
                        ${funcion.persona}
                    </td>
                    <td>
                        ${funcion.cargo}
                    </td>
                    <td>
                        <a href="#" class="btn btn-danger btn-sm btnRemoveFuncion" data-id="${funcion.id}" title="Eliminar">
                            <i class="fa fa-trash-o"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
</g:if>
<g:else>
    <div class="alert alert-warning">
        No tiene funciones asignadas
    </div>
</g:else>

<script type="text/javascript">
    $(function () {
        $(".btnRemoveFuncion").click(function () {
            deleteFuncion($(this).data("id"), $(this));
        });
    })
</script>
