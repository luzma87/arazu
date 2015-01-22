/**
 * Created by luz on 31/12/14.
 */
jQuery.validator.addMethod("notEqualTo", function (value, element, param) {
    // bind to the blur event of the target in order to revalidate whenever the target field is updated
    // TODO find a way to bind the event just once, avoiding the unbind-rebind overhead
    var target = $(param);
    if (this.settings.onfocusout) {
        target.unbind(".validate-notEqualTo").bind("blur.validate-notEqualTo", function () {
            $(element).valid();
        });
    }
    return value !== target.val();
}, jQuery.validator.format("No ingrese ese valor."));

/**
 * una implementación de max que permite comparar números con formato 1,568,258.25
 */
jQuery.validator.addMethod("lzmMax", function (value, element, param) {
    value = parseFloat(str_replace(",", "", value));
    return this.optional(element) || value <= param;
}, jQuery.validator.format("Ingrese un valor inferior o igual a {0}."));
