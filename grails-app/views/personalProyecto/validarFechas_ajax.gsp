<%--
  Created by IntelliJ IDEA.
  User: LUZ
  Date: 10-May-15
  Time: 21:09
--%>
<g:each in="${datos}" var="dd">
    <g:set var="d" value="${dd.value}"/>
    <a href="#" class="list-group-item" data-id="${d.persona.id}">
        <h4 class="list-group-item-heading"
            data-toggle="collapse"
            data-target="#collapse${d.persona.id}" aria-expanded="false" aria-controls="collapseExample">
            ${d.persona}
        </h4>

        <div class="list-group-item-text" id="collapse${d.persona.id}">
            <div class="row" style="margin-top: 2px;">
                <div class="col-md-2">Desde</div>

                <div class="col-md-10">
                    <elm:datepicker class="form-control input-sm" name="desde"/>
                </div>
            </div>

            <div class="row" style="margin-top: 2px;">
                <div class="col-md-2">Hasta</div>

                <div class="col-md-10">
                    <elm:datepicker class="form-control input-sm" name="hasta"/>
                </div>
            </div>
        </div>
    </a>
</g:each>
