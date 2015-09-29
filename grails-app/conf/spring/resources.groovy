// Place your Spring DSL code here
beans = {
    localeResolver(org.springframework.web.servlet.i18n.FixedLocaleResolver) {
        defaultLocale = new Locale("en","US")
        java.util.Locale.setDefault(defaultLocale)
    }
}
