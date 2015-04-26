<!DOCTYPE html>
<%@page import="arazu.nomina.Asistencia"%>
<html>
<head>
<meta name="layout" content="main">
<title>Registro de asistencia</title>
<style type="text/css">
.empleado {
	background: #3A5DAA;
	color: white;
	font-weight: bold;
}

.actual {
	background: none;
}

.NAST {
	background: #FFA324 !important;
	color:white;
}

.ASTE {
	background: #82A640 !important;
	color:white;
}
td{
	width: 80px !important;
}
</style>
</head>
<body>
	<elm:container tipo="horizontal" titulo="Registro de asistencia">
		<div class="row">
			<div class="col-md-12">
				<table class="table table-condensed table-bordered table-hover">
					<thead>
						<tr>
							<th colspan="${max-min+2 }">
								${now.format("MMMM-yyyy").toUpperCase()}
							</th>
						</tr>
						<tr>
							<th>Empleado</th>
							<g:each in="${min..max}" var="i" status="j">
								<th>
									${i}
								</th>
							</g:each>

						</tr>
					</thead>
					<tbody>
						<g:each in="${empleados}" var="empleado">
							<tr>
								<td class="empleado">
									${empleado.nombre}
								</td>
								<g:each in="${min..max}" var="i" status="j">
									<g:set var="fecha"
										value="${(i<dia)?now.minus(dia-i):now.plus(i-dia)}"></g:set>
									<g:set var="asistencia"
										value="${ Asistencia.findByEmpleadoAndFecha(empleado,now)}"></g:set>
									<td class="${i==dia?'actual':'disabled'}"
										iden="${asistencia?.id}" empleado="${empleado.id}"
										fecha="${fecha.format('dd-MM-yyyy')}"></td>
								</g:each>

							</tr>

						</g:each>
					</tbody>
				</table>
			</div>
		</div>
	<div class="row">
	<div class="col-md-1">
	<a href="#" id="guardar" class="btn btn-info btn-sm">
	<i class="fa fa-save"></i> Guardar
	</a>
	</div>
	</div>
	</elm:container>

	<script type="text/javascript">
var id = null;
var empleado = null
var fecha = null
function submitFormAsistencia() {
    var $form = $("#frmAsistencia");
    var $btn = $("#dlgCreateEditAsistencia").find("#btnSave");
    if ($form.valid()) {
        $btn.replaceWith(spinner);
        openLoader("Guardando Asistencia");
        $.ajax({
            type    : "POST",
            url     : $form.attr("action"),
            data    : $form.serialize(),
            success : function (msg) {
                var parts = msg.split("*");
                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                setTimeout(function() {
                    if (parts[0] == "SUCCESS") {
                        location.reload(true);
                    } else {
                        spinner.replaceWith($btn);
                        closeLoader();
                        return false;
                    }
                }, 1000);
            },
            error: function() {
                log("Ha ocurrido un error interno", "Error");
                closeLoader();
            }
        });
} else {
    return false;
} //else
}
function createEditAsistencia(id) {
    var title = id ? "Editar" : "Crear";
    var data = id ? { id: id,empleado:empleado,fecha:fecha } : {empleado:empleado,fecha:fecha};
    $.ajax({
        type    : "POST",
        url     : "${createLink(controller:'asistencia', action:'form_ajax')}",
						data : data,
						success : function(msg) {
							closeLoader();
							var b = bootbox
									.dialog({
										id : "dlgCreateEditAsistencia",
										title : title + " Asistencia",

										class : "modal-lg",

										message : msg,
										buttons : {
											cancelar : {
												label : "Cancelar",
												className : "btn-primary",
												callback : function() {
												}
											},
											guardar : {
												id : "btnSave",
												label : "<i class='fa fa-save'></i> Guardar",
												className : "btn-success",
												callback : function() {
													return submitFormAsistencia();
												} //callback
											}
										//guardar
										}
									//buttons
									}); //dialog
							setTimeout(function() {
								b.find(".form-control").first().focus()
							}, 500);
						} //success
					}); //ajax
		} //createEdit
		(function($){
		    $.fn.disableSelection = function() {
		        return this
		                 .attr('unselectable', 'on')
		                 .css('user-select', 'none')
		                 .on('selectstart', false);
		    };
		})(jQuery);
		$(".actual").disableSelection().click(function() {
			var celda = $(this)
			if (!celda.hasClass("ASTE")) {
				celda.addClass("ASTE")
				celda.html("<i class='fa fa-check'></i> Asiste")
				celda.removeClass("NAST")
				
			} else {
				celda.addClass("NAST")
				celda.html("<i  style='color:red' class='fa fa-times'></i> No asiste")
				celda.removeClass("ASTE")
			}
		});
		$("#guardar").click(function(){
			bootbox.confirm("Está seguro?",function(result){
				if(result){

					openLoader();
					var data = ""
					$(".actual").each(function(){
						if($(this).hasClass("ASTE")){
							data+=$(this).attr("empleado")+";"+$(this).attr("fecha")+";1|"
						}
						if($(this).hasClass("NAST")){
							data+=$(this).attr("empleado")+";"+$(this).attr("fecha")+";0|"
						}
				    });
				    console.log(data)
				    if(data!=""){
				    	$.ajax({
				            type    : "POST",
				            url     : "${g.createLink(controller:'asistencia',action:'guardarDatos')}",
				            data    : "data="+data,
				            success : function (msg) {
				                bootbox.alert("Datos guardados")
				            },
				            error: function() {
				                log("Ha ocurrido un error interno", "Error");
				                closeLoader();
				            }
				        });
					}else{
						closeLoader();
					}
					}
				});
		
		
		});
	</script>
</body>
</html>