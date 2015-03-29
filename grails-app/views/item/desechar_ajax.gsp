<imp:js src="${resource(dir: 'js',file: 'ui.js')}"/>
<div class="modal-contenido">
    <div class="row">
        <div class="col-sm-2 show-label">
            Tipo
        </div>
        <div class="col-sm-4">
            <g:select name="tipos" from="${tipos}" id="tipos" optionKey="key" optionValue="value" class="form-control input-sm"></g:select>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-2 show-label">
            Lugar
        </div>
        <div class="col-sm-4">
            <input type="text" id="donde" class="form-control input-sm">
        </div>
    </div>
    <div class="row">
        <div class="col-sm-2 show-label">
            Cantidad
        </div>
        <div class="col-sm-4">
            <input type="text" id="cantidad" class="form-control input-sm number" style="text-align: right">
        </div>
    </div>
    <div class="row">
        <div class="col-sm-2 show-label">
            Precio
        </div>
        <div class="col-sm-4">
            <input type="text" id="precio" class="form-control input-sm number" style="text-align: right">
        </div>
    </div>
</div>
