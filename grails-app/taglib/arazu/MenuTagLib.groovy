package arazu

import arazu.alertas.Alerta
import arazu.seguridad.Permiso

class MenuTagLib {
//    static defaultEncodeAs = 'html'
    //static encodeAsForTags = [tagName: 'raw']

    static namespace = 'mn'

    def stickyFooter = { attrs ->
        def html = ""
        html += "<footer class='footer'>"
        html += "<div class='container text-center'>"
        html += "<strong>HIDALGO NARANJO INGENIEROS & ARQUITECTOS S.A.</strong>&nbsp;&nbsp;&nbsp;&nbsp;2015 Todos los derechos reservados - VERSION 1.0"
        html += "</div>"
        html += "</footer>"
        out << html
    }

    def bannerTop = { attrs ->

        def large = attrs.large ? "banner-top-lg" : ""

        def html = ""
        html += "<div class='banner-top ${large}'>"
        html += "<div class='banner-esquina hidden-xs hidden-sm'>"
        html += "</div>"
        html += "<div class='banner-title'>HIDALGO NARANJO INGENIEROS & ARQUITECTOS S.A.</div>"
        if (large != "") {
            html += "<div class='banner-logo'>"
            html += "</div>"
            html += "<div class='banner-esquina der'>"
            html += "</div>"
        } else {
//            html += "<div class='banner-search'>"
//            html += "<div class='input-group input-group-sm'>"
//            html += "<input type='text' class='form-control' placeholder='Buscador'>"
//            html += "<span class='input-group-btn'>"
//            html += "<a href='#' class='btn btn-default' style='margin-top:-4px;'><i class='fa fa-search'></i>&nbsp;</a>"
//            html += "</span>"
//            html += "</div><!-- /input-group -->"
//            html += "</div>"
        }
        html += "</div>"

        out << html
    }

    def menu = { attrs ->

        def items = [:]
        def usuario, perfil, dpto
        if (session.usuario) {
            usuario = session.usuario
            perfil = session.perfil
            dpto = session.tipoUsuario
        }
        def strItems = ""
        if (!attrs.title) {
            attrs.title = "Arazu"
        }
//        attrs.title = attrs.title.toUpperCase()
        if (usuario) {
            def acciones = Permiso.findAllByPerfil(perfil).accion.sort { it.modulo.orden }

            acciones.each { ac ->
                if (ac.tipo.codigo == 'M' && ac.modulo.nombre != 'noAsignado') {
                    if (!items[ac.modulo.nombre]) {
                        items.put(ac.modulo.nombre, [ac.descripcion, g.createLink(controller: ac.control.nombre, action: ac.nombre)])
                    } else {
                        items[ac.modulo.nombre].add(ac.descripcion)
                        items[ac.modulo.nombre].add(g.createLink(controller: ac.control.nombre, action: ac.nombre))
                    }
                }
            }
            items.each { item ->
                for (int i = 0; i < item.value.size(); i += 2) {
                    for (int j = 2; j < item.value.size() - 1; j += 2) {
                        def val = item.value[i].trim().compareTo(item.value[j].trim())
                        if (val > 0 && i < j) {
                            def tmp = [item.value[j], item.value[j + 1]]
                            item.value[j] = item.value[i]
                            item.value[j + 1] = item.value[i + 1]
                            item.value[i] = tmp[0]
                            item.value[i + 1] = tmp[1]
                        }

                    }
                }
            }
        } else {
            items = ["Inicio": ["Prueba", "linkPrueba", "Test", "linkTest"]]
        }

        items.each { item ->
            strItems += '<li class="dropdown">'
            strItems += '<a href="#" class="dropdown-toggle" data-toggle="dropdown">' + item.key + '<b class="caret"></b></a>'
            strItems += '<ul class="dropdown-menu">'

            (item.value.size() / 2).toInteger().times {
                strItems += '<li><a href="' + item.value[it * 2 + 1] + '">' + item.value[it * 2] + '</a></li>'
            }
            strItems += '</ul>'
            strItems += '</li>'
        }

        def alertas = "("
        def count = Alerta.cantAlertasPersona(usuario)
//        def count = 0
        alertas += count
        alertas += ")"

        def html = "<nav class=\"navbar navbar-default navbar-fixed-top\" role=\"navigation\">"

        html += "<div class=\"container-fluid\">"

        // Brand and toggle get grouped for better mobile display
        html += '<div class="navbar-header">'
        html += '<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">'
        html += '<span class="sr-only">Toggle navigation</span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '</button>'
        html += '<a class="navbar-brand navbar-logo" href="#">'
        html += '<img src="' + resource(dir: 'images/barras', file: 'logo-menu.png') + '" />'
        html += '</a>'
        html += '</div>'

        // Collect the nav links, forms, and other content for toggling
        html += '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">'
        html += '<ul class="nav navbar-nav">'
        html += strItems
        html += '</ul>'

        html += '<ul class="nav navbar-nav navbar-right">'
        html += '<li><a href="' + g.createLink(controller: 'alerta', action: 'list') + '" ' + ((count > 0) ? ' style="color:#ab623a" class="annoying"' : "") + '><i class="fa fa-exclamation-triangle"></i> Alertas ' + alertas + '</a></li>'
        html += '<li class="dropdown">'
        html += '<a href="#" class="dropdown-toggle" data-toggle="dropdown">' + session.usuario.nombre + " " + session.usuario.apellido + ' (' + session.perfil + ')' + ' <b class="caret"></b></a>'
        html += '<ul class="dropdown-menu">'
        html += '<li><a href="' + g.createLink(controller: 'persona', action: 'personal') + '"><i class="fa fa-cogs"></i> Configuración</a></li>'
        html += '<li class="divider"></li>'
        html += '<li><a href="' + g.createLink(controller: 'login', action: 'logout') + '"><i class="fa fa-power-off"></i> Salir</a></li>'
        html += '</ul>'
        html += '</li>'
        html += '</ul>'

        html += '</div><!-- /.navbar-collapse -->'

        html += "</div>"

        html += "</nav>"

        out << html
    }

}
