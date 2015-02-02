<%@ page import="arazu.inventario.Bodega" %>

<g:if test="${!bodegaInstance}">
    <elm:notFound elem="Bodega" genero="o"/>
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${bodegaInstance?.proyecto}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Proyecto
                </div>

                <div class="col-sm-10">
                    ${bodegaInstance?.proyecto?.encodeAsHTML()}
                </div>

            </div>
        </g:if>

        <g:if test="${bodegaInstance?.persona}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Responsable
                </div>

                <div class="col-sm-10">
                    ${bodegaInstance?.persona?.encodeAsHTML()}
                </div>

            </div>
        </g:if>

        <div class="row">
            <div class="col-sm-2 show-label">
                Activa
            </div>

            <div class="col-sm-4">
                <g:formatBoolean boolean="${bodegaInstance.activo == 1}" true="Sí" false="No"/>
            </div>

        </div>

        <g:if test="${bodegaInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Descripción
                </div>

                <div class="col-sm-10">
                    <g:fieldValue bean="${bodegaInstance}" field="descripcion"/>
                </div>

            </div>
        </g:if>

        <g:if test="${bodegaInstance?.observaciones}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Observaciones
                </div>

                <div class="col-sm-9" style="max-height: 100px; overflow-y: auto;">
                    ${bodegaInstance.observaciones}
                </div>

            </div>
        </g:if>

    </div>
</g:else>