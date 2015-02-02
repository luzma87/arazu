<g:if test="${bodega.observaciones && bodega.observaciones.trim() != ''}">
    <div class="alert alert-info" style="height: 150px; overflow-y: auto; overflow-x: hidden;">
        ${bodega.observaciones}
    </div>
</g:if>
Observaciones
<g:textArea name="observaciones" cols="5" rows="5" class="form-control"/>