<form id="frmAprobar">
    <div class="row">
        <div class="col-md-3">${lbl}</div>

        <div class="col-md-5">
            <g:select name="para" from="${from}" class="form-control input-sm required" optionKey="id"/>
        </div>
    </div>

    <div class="row">
        <div class="col-md-3">Cantidad</div>

        <div class="col-md-3">
            <div class="input-group">
                <g:textField name="cant" class="form-control input-sm number"
                             value="${nota.cantidadAprobada != 0 ? nota.cantidadAprobada : nota.cantidad}"/>
                <span class="input-group-addon">${nota.unidad.codigo}</span>
            </div>
        </div>

        <div class="col-md-3">
            ${nota.item}
        </div>
    </div>

    <div class="row">
        <div class="col-md-3">Clave de autorización</div>

        <div class="col-md-5">
            <div class="grupo">
                <div class="input-group input-group-sm">
                    <g:passwordField name="auth" class="form-control input-sm required"/>
                    <span class="input-group-addon">
                        <i class="fa fa-unlock-alt"></i>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-3">Observaciones</div>

        <div class="col-md-9">
            <g:textArea name="obs" class="form-control input-sm"/>
        </div>
    </div>
</form>