<imp:js src="${resource(dir: 'js/plugins/Jcrop-0.9.12/js', file: 'jquery.Jcrop.min.js')}"/>
<imp:css src="${resource(dir: 'js/plugins/Jcrop-0.9.12/css', file: 'jquery.Jcrop.min.css')}"/>

<g:if test="${w > 210 || h > 280}">
    <div>
        <a href="#" class="btn btn-success" id="btnSave"><i class="fa fa-save"></i> Guardar</a>
    </div>
</g:if>
<div style="height: ${Math.max(h, 280) + 85}px; ">
    <div style="height: ${Math.max(h, 280) + 30}px;">
        <div class="thumbnail" style="float: left;">
            <img id="foto" src="${resource(dir: 'images/perfiles/', file: usuario.foto)}"/>
        </div>

        <g:if test="${w > 210 || h > 280}">
            <div style="width:210px;height:280px;overflow:hidden;margin-left:5px; float: left; border: 1px solid cornflowerblue;">
                <img id="preview" src="${resource(dir: 'images/perfiles/', file: usuario.foto)}"/>
            </div>
        </g:if>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        function showPreview(coords) {
            var rx = 210 / coords.w;
            var ry = 280 / coords.h;

            $('#preview').css({
                width      : Math.round(rx * ${w}) + 'px',
                height     : Math.round(ry * ${h}) + 'px',
                marginLeft : '-' + Math.round(rx * coords.x) + 'px',
                marginTop  : '-' + Math.round(ry * coords.y) + 'px'
            }).data({
                x  : coords.x,
                y  : coords.y,
                w  : coords.w,
                h  : coords.h,
                id : "${usuario.id}"
            });
        }

        <g:if test="${w > 210 || h > 280}">
        $('#foto').Jcrop({
            onChange    : showPreview,
            onSelect    : showPreview,
            aspectRatio : 3 / 4
        });

        $("#btnSave").click(function () {
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'resizeCropImageUsuario_ajax')}",
                data    : $("#preview").data(),
                success : function (msg) {
                    openLoader("Cargando...");
                    setTimeout(function () {
                        location.href = "${createLink(action: 'foto', id: usuario.id)}";
                    }, 1000);
                }
            });
        });
        </g:if>
    });
</script>