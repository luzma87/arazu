<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 4/24/2015
  Time: 7:29 PM
--%>

<html>
    <head>
        <meta name="layout" content="main">
        <title>Foto de usuario</title>

        <!-- The Load Image plugin is included for the preview images and image resizing functionality -->
        <imp:js src="${resource(dir: 'js/plugins/jQuery-File-Upload-5.42.2/js/imgResize', file: 'load-image.min.js')}"/>
        <!-- The Canvas to Blob plugin is included for image resizing functionality -->
        <imp:js src="${resource(dir: 'js/plugins/jQuery-File-Upload-5.42.2/js/imgResize', file: 'canvas-to-blob.min.js')}"/>
        <!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
        <imp:js src="${resource(dir: 'js/plugins/jQuery-File-Upload-5.42.2/js', file: 'jquery.iframe-transport.js')}"/>
        <!-- The basic File Upload plugin -->
        <imp:js src="${resource(dir: 'js/plugins/jQuery-File-Upload-5.42.2/js', file: 'jquery.fileupload.js')}"/>
        <!-- The File Upload processing plugin -->
        <imp:js src="${resource(dir: 'js/plugins/jQuery-File-Upload-5.42.2/js', file: 'jquery.fileupload-process.js')}"/>
        <!-- The File Upload image preview & resize plugin -->
        <imp:js src="${resource(dir: 'js/plugins/jQuery-File-Upload-5.42.2/js', file: 'jquery.fileupload-image.js')}"/>

        <imp:css src="${resource(dir: 'js/plugins/jQuery-File-Upload-5.42.2/css', file: 'jquery.fileupload.css')}"/>

        <style type="text/css">
        .table {
            font-size     : 13px;
            width         : auto !important;
            margin-bottom : 0 !important;
        }

        .container-celdasAcc {
            max-height : 200px;
            width      : 804px; /*554px;*/
            overflow   : auto;
        }

        .col100 {
            width : 100px;
        }

        .col200 {
            width : 250px;
        }

        .col300 {
            width : 304px;
        }

        .col-md-1.xs {
            width : 45px;
        }

        </style>

    </head>

    <body>

        <div class="btn-toolbar" role="toolbar">
            <div class="btn-group" role="group">
                <g:link controller="tipoUsuario" action="arbolAdmin" class="btn btn-default">
                    <i class="fa flaticon-construction4"></i> Usuarios
                </g:link>
            </div>
        </div>

        <elm:container tipo="horizontal" titulo="Foto del usuario: ${usuario.nombre} ${usuario.apellido} (${usuario.login})">

            <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>
            <div class="panel panel-default" style="margin-top: 15px;">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a>
                            Cambiar foto
                        </a>
                    </h4>
                </div>

                <div id="collapseFoto" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <div class="btn btn-success fileinput-button" style="margin-bottom: 10px;">
                            <i class="fa fa-plus"></i>
                            <span>Seleccionar imagen</span>
                            <!-- The file input field used as target for the file up3 widget -->
                            <input type="file" name="file" id="file">
                        </div>

                        <div class="alert alert-warning" style="float: right; width: 600px;">
                            <i class="fa fa-warning fa-3x pull-left"></i>
                            Si la foto subida es muy grande, se mostrará un área de selección para recortar la imagen al formato requerido.
                        </div>
                        <g:if test="${usuario.foto && usuario.foto != ''}">
                            <div id="divFoto">
                            </div>
                        </g:if>
                        <g:else>
                            <div class="alert alert-info">
                                <i class="fa fa-picture-o fa-2x"></i>
                                No ha subido ninguna fotografía
                            </div>
                        </g:else>

                        <div id="progress" class="progress progress-striped active">
                            <div class="progress-bar progress-bar-success"></div>
                        </div>

                        <div id="files"></div>
                    </div>
                </div>
            </div>
        </elm:container>

        <script type="text/javascript">
            $(function () {
                var $btnPass = $("#btnPass");
                var $frmPass = $("#frmPass");
                var $btnAuth = $("#btnAuth");
                var $frmAuth = $("#frmAuth");

                $("#password_actual").val("");
                $("#auth_actual").val("");

                $('#file').fileupload({
                    url              : '${createLink(action:'uploadFileUsuario_ajax')}',
                    dataType         : 'json',
                    maxNumberOfFiles : 1,
                    formData         : {
                        id : "${usuario.id}"
                    },
                    acceptFileTypes  : /(\.|\/)(jpe?g|png)$/i,
                    maxFileSize      : 1000000 // 1 MB
                }).on('fileuploadadd', function (e, data) {
//                    console.log("fileuploadadd");
                    openLoader("Cargando");
                    data.context = $('<div/>').appendTo('#files');
                    $.each(data.files, function (index, file) {
                        var node = $('<p/>')
                                .append($('<span/>').text(file.name));
                        if (!index) {
                            node
                                    .append('<br>');
                        }
                        node.appendTo(data.context);
                    });
                }).on('fileuploadprocessalways', function (e, data) {
//                    console.log("fileuploadprocessalways");
                    var index = data.index,
                            file = data.files[index],
                            node = $(data.context.children()[index]);
                    if (file.preview) {
                        node
                                .prepend('<br>')
                                .prepend(file.preview);
                    }
                    if (file.error) {
                        node
                                .append('<br>')
                                .append($('<span class="text-danger"/>').text(file.error));
                    }
                    if (index + 1 === data.files.length) {
                        data.context.find('button')
                                .text('Upload')
                                .prop('disabled', !!data.files.error);
                    }
                }).on('fileuploadprogressall', function (e, data) {
//                    console.log("fileuploadprogressall");
                    var progress = parseInt(data.loaded / data.total * 100, 10);
                    $('#progress .progress-bar').css(
                            'width',
                            progress + '%'
                    );
                }).on('fileuploaddone', function (e, data) {
//                    closeLoader();
                    setTimeout(function () {
                        location.href = "${createLink(action: 'foto', id: usuario.id)}";
                    }, 1000);
                }).on('fileuploadfail', function (e, data) {
                    closeLoader();
                    $.each(data.files, function (index, file) {
                        var error = $('<span class="text-danger"/>').text('File upload failed.');
                        $(data.context.children()[index])
                                .append('<br>')
                                .append(error);
                    });
                });

                function loadFoto() {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action: 'loadFotoUsuario_ajax')}",
                        data    : {
                            id : "${usuario.id}"
                        },
                        success : function (msg) {
                            $("#divFoto").html(msg);
                        }
                    });
                }

                function submitPass() {
                    var url = $frmPass.attr("action");
//                    var data = $frmPass.serialize();
//                    data += "&tipo=pass";

                    var data = {
                        input2 : $("#password").val(),
                        input3 : $("#password_again").val(),
                        tipo   : "pass"
                    };

                    if ($frmPass.valid()) {
                        $btnPass.hide().after(spinner);
                        $.ajax({
                            type    : "POST",
                            url     : url,
                            data    : data,
                            success : function (msg) {
                                var parts = msg.split("*");
                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error");
                                spinner.remove();
                                $btnPass.show();
                                $frmPass.find("input").val("");
                                validatorPass.resetForm();
                            }
                        });
                    }
                }

                function submitAuth() {
                    var url = $frmAuth.attr("action");
//                    var data = $frmPass.serialize();
//                    data += "&tipo=pass";

                    var data = {
                        input3 : $("#auth_again").val(),
                        input2 : $("#auth").val(),
                        input1 : $("#auth_actual").val(),
                        tipo   : "auth"
                    };

                    if ($frmAuth.valid()) {
                        $btnAuth.hide().after(spinner);
                        $.ajax({
                            type    : "POST",
                            url     : url,
                            data    : data,
                            success : function (msg) {
                                var parts = msg.split("*");
                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error");
                                spinner.remove();
                                $btnAuth.show();
                                $frmAuth.find("input").val("");
                                validatorAuth.resetForm();
                            }
                        });
                    }
                }

                loadFoto();

            });
        </script>

    </body>
</html>