<%@ page import="arazu.items.Item" %>

<g:if test="${!itemInstance}">
    <elm:notFound elem="Item" genero="o"/>
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${itemInstance?.tipo}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Tipo
                </div>

                <div class="col-sm-4">
                    ${itemInstance?.tipo?.encodeAsHTML()}
                </div>

            </div>
        </g:if>

        <g:if test="${itemInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Descripción
                </div>

                <div class="col-sm-4">
                    <g:fieldValue bean="${itemInstance}" field="descripcion"/>
                </div>

            </div>
        </g:if>

        <g:if test="${maquinas.size() > 0}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Maquinarias
                </div>

                <div class="col-sm-10">
                    ${maquinas.maquinaria.join(", ")}
                </div>
            </div>
        </g:if>

    </div>
</g:else>