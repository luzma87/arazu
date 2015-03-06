package arazu.seguridad

class Shield {
    def beforeInterceptor = [action: this.&auth, except: 'login']
    /**
     * Verifica si se ha iniciado una sesión
     * Verifica si el usuario actual tiene los permisos para ejecutar una acción
     */
    def auth() {
        if (!actionName.contains("ajax")) {
            session.an = actionName
            session.cn = controllerName
            session.pr = params
        }
//        return true
        /** **************************************************************************/
        if (!session.usuario) {
            redirect(controller: 'login', action: 'login')
            session.finalize()
            return false
        } else {
            if (isAllowed()) {
                return true
            } else {
                redirect(controller: 'shield', action: 'forbidden_403')
                return false
            }
        }
        /*************************************************************************** */
    }

    boolean isAllowed() {
        try {
            println "method: " + request.method
            println "1 " + session.permisos[controllerName.toLowerCase()]
            println "2 " + actionName.toLowerCase()
            if (request.method == "POST") {
//                println "es post no audit"
                return true
            }
//            println "is allowed Accion: ${actionName.toLowerCase()} ---  Controlador: ${controllerName.toLowerCase()} --- Permisos de ese controlador: "+session.permisos[controllerName.toLowerCase()]
            if (!session.permisos[controllerName.toLowerCase()]) {
                println "??"
                return false
            } else {
                if (session.permisos[controllerName.toLowerCase()].contains(actionName.toLowerCase()))
                    return true
                else
                    return false
            }

        } catch (e) {
            println "Shield execption e: " + e
            return false
        }
    }


}
 
