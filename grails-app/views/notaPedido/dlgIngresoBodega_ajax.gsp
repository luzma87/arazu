<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 28/02/2015
  Time: 16:18
--%>
<div class="alert alert-info">
    Realizar el ingreso de <strong>${nota.cantidad}${nota.unidad.codigo} ${nota.item}</strong> a la bodega seleccionada
</div>

<g:select name="bodega" from="${bodegas}" class="form-control" optionKey="id"/>
