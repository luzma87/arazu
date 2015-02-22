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
            }
        }
        /*************************************************************************** */
    }

    boolean isAllowed() {
        try {
            if (session.permisos[actionName]?.toLowerCase() == controllerName?.toLowerCase())
                return true
        } catch (e) {
            println "Shield execption e: " + e
            return false
        }
        return false
//        return true
    }


}
 
