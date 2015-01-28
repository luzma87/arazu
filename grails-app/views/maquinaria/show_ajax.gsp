<%@ page import="arazu.items.Maquinaria" %>

<style type="text/css">
.swatch {
    width        : 15px;
    height       : 15px;
    margin-right : 5px;
}
</style>

<g:if test="${!maquinariaInstance}">
    <elm:notFound elem="Maquinaria" genero="o"/>
</g:if>
<g:else>
    <div class="modal-contenido">

        <g:if test="${maquinariaInstance?.tipo || maquinariaInstance?.color}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Tipo
                </div>

                <div class="col-sm-4">
                    ${maquinariaInstance?.tipo?.encodeAsHTML()}
                </div>

                <div class="col-sm-1 show-label">
                    Color
                </div>

                <div class="col-sm-4">
                    ${maquinariaInstance?.color?.encodeAsHTML()}
                    <div class="swatch pull-left" style="background: ${maquinariaInstance.color?.hex};"></div>
                </div>

            </div>
        </g:if>

        <g:if test="${maquinariaInstance?.marca || maquinariaInstance?.modelo}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Marca
                </div>

                <div class="col-sm-4">
                    <g:fieldValue bean="${maquinariaInstance}" field="marca"/>
                </div>

                <div class="col-sm-1 show-label">
                    Modelo
                </div>

                <div class="col-sm-4">
                    <g:fieldValue bean="${maquinariaInstance}" field="modelo"/>
                </div>

            </div>
        </g:if>

        <g:if test="${maquinariaInstance?.placa || maquinariaInstance?.anio}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Placa
                </div>

                <div class="col-sm-4">
                    <g:fieldValue bean="${maquinariaInstance}" field="placa"/>
                </div>

                <div class="col-sm-1 show-label">
                    Año
                </div>

                <div class="col-sm-4">
                    <g:fieldValue bean="${maquinariaInstance}" field="anio"/>
                </div>

            </div>
        </g:if>

        <g:if test="${maquinariaInstance?.descripcion}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Descripción
                </div>

                <div class="col-sm-10">
                    <g:fieldValue bean="${maquinariaInstance}" field="descripcion"/>
                </div>

            </div>
        </g:if>

        <g:if test="${maquinariaInstance?.observaciones}">
            <div class="row">
                <div class="col-sm-2 show-label">
                    Observaciones
                </div>

                <div class="col-sm-10">
                    <g:fieldValue bean="${maquinariaInstance}" field="observaciones"/>
                </div>

            </div>
        </g:if>

    </div>
</g:else>