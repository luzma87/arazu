<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 027 27 Sep 15
  Time: 11:30
--%>

<imp:js src="${resource(dir: 'js', file: 'ui.js')}"/>

<g:select name="item_txt" from="${items}" optionKey="id" value="${id}"
          optionValue="${{ it.descripcion.decodeHTML() }}" data-width="219px"
          class="form-control input-sm required select" noSelection="['': '-- Seleccione --']"
          data-live-search="true"/>
