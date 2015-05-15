<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 13-May-15
  Time: 21:36
--%>

<g:each in="${personal}" var="p">
    <a href="#" class="list-group-item seleccionado" data-id="${p.id}">
        ${p.persona}
    </a>
</g:each>