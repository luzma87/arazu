<link href="${g.resource(dir: 'css/custom/', file: 'pdfViewer.css')}" rel="stylesheet" type="text/css">
<imp:js src="${resource(dir: 'js/plugins/pdfObject', file: 'pdfobject.min.js')}"/>
<div class="pdf-viewer">
    <div class="pdf-content" >
        <iframe class="pdf-container" id="doc"></iframe>
        <div class="pdf-handler" >
            <i class="fa fa-arrow-right"></i>
        </div>
        <div class="pdf-header" id="data">
            Documento: <span id="referencia-pdf" class="data"></span>



        </div>
        <div id="msgNoPDF">
            <img src="${resource(dir: 'images/spinners',file: 'download.GIF')}">
        </div>
    </div>
</div>
<script type="text/javascript">
    function showPdf(div){
        $("#msgNoPDF").show();
        $("#doc").html("")
        var pathFile = div.data("file")
        $("#referencia-pdf").html(div.data("ref"))
        var path = "${url}"+pathFile;
        $("#doc").attr("src",path)
        $(".pdf-viewer").show("slide",{direction:'right'})
        $("#data").show()
    }
    $(".ver-doc").click(function(){
        showPdf($(this))
        return false
    })
    $(".pdf-handler").click(function(){
        $(".pdf-viewer").hide("slide",{direction:'right'})
        $("#data").hide()
    })

    $(".pdf-viewer").resizable();
</script>