<form id="frmAprobar">
    <div class="row">
        <div class="col-md-3">${lbl}</div>

        <div class="col-md-5">
            <g:select name="para" from="${from}" class="form-control input-sm required" optionKey="id"/>
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