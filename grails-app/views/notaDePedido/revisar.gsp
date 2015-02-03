<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Nota de pedido #${nota.numero}</title>
    <style type="text/css">

    .numero{
        text-align: right;
    }
    .unidad{
        text-align: center;
        width: 80px;
    }
    .cantidad{
        text-align: center;
        width: 80px;
    }
    </style>
</head>
<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

<elm:container tipo="horizontal" titulo="Revisión de nota de pedido">
    <g:form class="enviarNota" action="enviarAprobacion">
        <input type="hidden" name="id" value="${nota.id}">
    </g:form>
    <input type="hidden" name="data" id="data">
    <div class="row">
        <div class="col-md-1">
            <label class=" control-label">
                Motivo
            </label>
        </div>
        <div class="col-md-2">
            ${nota.tipoSolicitud.descripcion}
        </div>
        <div class="col-md-1">
            <label class=" control-label">
                Número
            </label>
        </div>
        <div class="col-md-2">
            ${nota.numero}
        </div>
        <div class="col-md-1">
            <label class=" control-label">
                Fecha
            </label>
        </div>
        <div class="col-md-3">
            ${nota.fecha?.format("dd-MM-yyyy HH:mm:ss")}
        </div>
    </div>
    <div class="row">
        <div class="col-md-1">
            <label class=" control-label">
                De
            </label>
        </div>
        <div class="col-md-2">
            ${nota.de}
        </div>

    </div>


    <div class="row">
        <div class="col-md-1">
            <label class=" control-label">
                Proyecto
            </label>
        </div>
        <div class="col-md-2">
            ${nota.proyecto}
        </div>
        <div class="col-md-1">
            <label class=" control-label">
                Equipo
            </label>
        </div>
        <div class="col-md-2">
            ${nota.maquinaria}
        </div>
    </div>

    <table class="table table-striped table-hover table-bordered" style="margin-top: 10px">
        <thead>
        <tr>
            <th style="width: 80px">Cantidad</th>
            <th style="width: 150px">Unidad</th>
            <th>Descripción</th>
        </tr>
        </thead>
        <tbody id="tabla-items">
        <tr>
            <td class="cantidad">
                ${nota.cantidad.toInteger()}
            </td>
            <td style="text-align: center">
                ${nota.unidad}
            </td>
            <td>
                ${nota.item}
            </td>

        </tr>
        </tbody>

    </table>
</elm:container>
<elm:container tipo="horizontal" titulo="Cotizaciones" >
    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true" style="margin-top: 20px">
        <g:if test="${cots.size()>0}">
            <g:each in="${cots}" var="c" status="i">
                <g:form class="frmCotizacion" action="savaCotizacion">
                    <input type="hidden" value="${nota.id}" name="pedido.id">
                    <input type="hidden" value="${c.id}" name="id">
                    <div class="panel panel-info">
                        <div class="panel-heading" role="tab" id="heading_${i}">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse_${i}" aria-expanded="false" aria-controls="collapse_${i}">
                                    Cotización #${i+1}
                                </a>
                            </h4>
                        </div>
                        <div id="collapse_${i}" class="panel-collapse collapse ${i==0?'in':''}" role="tabpanel" aria-labelledby="heading_${i}">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-1">
                                        <label>Proveedor</label>
                                    </div>
                                    <div class="col-md-5">
                                        <input type="text" class="form-control input-sm" name="proveedor" value="${c.proveedor}" maxlength="254">
                                    </div>
                                    <div class="col-md-1">
                                        <label>Entrega</label>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="input-group">
                                            <input type="text" class="form-control input-sm number" name="diasEntrega" style="text-align: right" value="${c.diasEntrega}">
                                            <span class="input-group-addon svt-bg-warning">Días</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1">
                                        <label>P. Unitario</label>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="input-group">
                                            <input type="text" class="form-control input-sm number money nueva_unitario unitario required" total="p_total_${i}" name="valor"  cantidad="${nota.cantidad}" value="${g.formatNumber(number: c.valor,type: 'currency')}" >

                                            <span class="input-group-addon svt-bg-warning">$</span>
                                        </div>
                                    </div>
                                    <div class="col-md-1">
                                        <label>P. Total</label>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="input-group">
                                            <input type="text" class="form-control input-sm number money " disabled
                                                   id="p_total_${i}" cantidad="${nota.cantidad}"
                                                   value="${g.formatNumber(number: c.valor*nota.cantidad,type: 'currency')}">
                                            <span class="input-group-addon svt-bg-warning">$</span>
                                        </div>
                                    </div>
                                    <div class="col-md-3" style="text-align: right">
                                        <a href="#" class="btn btn-info guardar_nueva" number="${i}" iden="${c.id}">
                                           <i class="fa fa-save"></i> Guadar
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </g:form>
            </g:each>
            <g:if test="${cots.size()<3}">
                <g:form class="frmCotizacion" action="savaCotizacion">
                    <input type="hidden" value="${nota.id}" name="pedido.id">
                    <div class="panel panel-info">
                        <div class="panel-heading" role="tab" id="headingOne_n">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne_n" aria-expanded="true" aria-controls="collapseOne_n">
                                    Registrar nueva
                                </a>
                            </h4>
                        </div>
                        <div id="collapseOne_n" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne_n">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-1">
                                        <label>Proveedor</label>
                                    </div>
                                    <div class="col-md-5">
                                        <input type="text" class="form-control input-sm nueva_proveedor required"  name="proveedor" maxlength="254">
                                    </div>
                                    <div class="col-md-1">
                                        <label>Entrega</label>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="input-group">
                                            <input type="text" name="diasEntrega" class="form-control input-sm number nueva_dias required" style="text-align: right">
                                            <span class="input-group-addon svt-bg-warning">Días</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1">
                                        <label>P. Unitario</label>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="input-group">
                                            <input type="text" class="form-control input-sm number money nueva_unitario unitario required" total="total_n" name="valor"  cantidad="${nota.cantidad}" >
                                            <span class="input-group-addon svt-bg-warning">$</span>
                                        </div>
                                    </div>
                                    <div class="col-md-1">
                                        <label>P. Total</label>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="input-group">
                                            <input type="text" id="total_n" class="form-control input-sm number money nueva_total " disabled >
                                            <span class="input-group-addon svt-bg-warning">$</span>
                                        </div>
                                    </div>
                                    <div class="col-md-3" style="text-align: right">
                                        <a href="#" class="btn btn-info guardar_nueva" >
                                            <i class="fa fa-save"></i> Guadar</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </g:form>
            </g:if>
        </g:if>
        <g:else>
            <g:form class="frmCotizacion" action="savaCotizacion">
                <input type="hidden" value="${nota.id}" name="pedido.id">
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="headingOne_n">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne_n" aria-expanded="true" aria-controls="collapseOne_n">
                                Registrar nueva
                            </a>
                        </h4>
                    </div>
                    <div id="collapseOne_n" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne_n">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-1">
                                    <label>Proveedor</label>
                                </div>
                                <div class="col-md-5">
                                    <input type="text" class="form-control input-sm nueva_proveedor required"  name="proveedor" maxlength="254">
                                </div>
                                <div class="col-md-1">
                                    <label>Entrega</label>
                                </div>
                                <div class="col-md-2">
                                    <div class="input-group">
                                        <input type="text" name="diasEntrega" class="form-control input-sm number nueva_dias required" style="text-align: right">
                                        <span class="input-group-addon svt-bg-warning">Días</span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-1">
                                    <label>P. Unitario</label>
                                </div>
                                <div class="col-md-2">
                                    <div class="input-group">
                                        <input type="text" class="form-control input-sm number money nueva_unitario unitario required" total="total_n" name="valor"  cantidad="${nota.cantidad}" >
                                        <span class="input-group-addon svt-bg-warning">$</span>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <label>P. Total</label>
                                </div>
                                <div class="col-md-2">
                                    <div class="input-group">
                                        <input type="text" id="total_n" class="form-control input-sm number money nueva_total " disabled >
                                        <span class="input-group-addon svt-bg-warning">$</span>
                                    </div>
                                </div>
                                <div class="col-md-3" style="text-align: right">
                                    <a href="#" class="btn btn-info guardar_nueva" >
                                        <i class="fa fa-save"></i> Guadar</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </g:form>
        </g:else>
    </div>
</elm:container>
<div class="row" style="margin-top: 20px">
    <div class="col-md-1">
        <a href="#" class="btn btn-primary" id="guardar"><i class="fa fa-save"></i> Guardar y solicitar aprobación</a>
    </div>
</div>
<script type="text/javascript">
    var validator = $(".frmCotizacion").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
            label.remove();
        }

        , rules          : {

            codigo: {
                remote: {
                    url: "${createLink(controller:'estadosolicitud', action: 'validar_unique_codigo_ajax')}",
                    type: "post",
                    data: {
                        id: "${estadoSolicitudInstance?.id}"
                    }
                }
            }

        },
        messages : {

            codigo: {
                remote: "Ya existe Codigo"
            }

        }

    });
    $("#guardar").click(function(){
        var  cots = ${cots.size()}
        if(cots*1>2){
            bootbox.confirm("Está seguro? Una vez enviada la nota de pedido no podrá realizar cambios a las cotizaciones",function(res){
               if(res) {
                   $(".enviarNota").submit()
               }
            });
        }else{
            bootbox.alert({
                        message : "Primero ingrese una o más cotizaciones",
                        title   : "Error",
                        class   : "modal-error"
                    }
            );
        }

    });
    $(".unitario").blur(function(){
        var valor = $(this).val()
        valor = str_replace(",","",valor)
        $("#"+$(this).attr("total")).val(valor*1*$(this).attr("cantidad")*1)
    });
    $(".guardar_nueva").click(function(){

        var form =  $(this).parents("form")
        if(form.valid()){
            form.submit()
        }
    });
</script>
</body>
</html>