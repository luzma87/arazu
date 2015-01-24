<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title><g:layoutTitle default="Arazu"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <imp:favicon/>
        <imp:importJs/>
        <imp:plugins/>
        <imp:customJs/>

        <imp:spinners/>

        <imp:importCss/>

        <g:layoutHead/>
        <script type="text/javascript">
            var index = 1041;
            function bringToTop(element) {
                element.css({"zIndex" : index})
                index++;
            }
            function bringToTopCustom(element, zIndex) {
                element.css({"zIndex" : zIndex})
            }
        </script>
    </head>

    <body>
        %{--<mn:bannerTop/>--}%

        <mn:menu title="${g.layoutTitle(default: 'Arazu')}"/>

        <div class="container" id="mass-container" style="position: relative">
            <g:layoutBody/>
        </div>

        <mn:stickyFooter/>
    </body>
</html>
