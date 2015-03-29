package arazu.pdf

import com.lowagie.text.FontFactory
import com.lowagie.text.pdf.BaseFont
import org.xhtmlrenderer.pdf.ITextFontResolver
import org.xhtmlrenderer.pdf.ITextRenderer


class PdfService {

    boolean transactional = false
    def g = new org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib()

    /**
     * A Simple fetcher to turn a specific URL into a PDF.
     * Transforma un URL a PDF
     * @param url
     * @param pathFonts
     * @return
     */
    byte[] buildPdf(url, String pathFonts) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ITextRenderer renderer = new ITextRenderer();

        FontFactory.registerDirectories();

        def pf = pathFonts + "${g.resource(dir: 'fonts/PT/PT_Sans')}/"
        def font = pf + "PT_Sans-Web-Regular.ttf"

        def pf_narrow = pathFonts + "${g.resource(dir: 'fonts/PT/PT_Sans_Narrow')}/"
        def font_narrow = pf_narrow + "PT_Sans-Narrow-Web-Regular.ttf"

        def pf_bold = pathFonts + "${g.resource(dir: 'fonts/PT/PT_Sans')}/"
        def font_bold = pf_bold + "PT_Sans-Web-Bold.ttf"

        def pf_narrow_bold = pathFonts + "${g.resource(dir: 'fonts/PT/PT_Sans_Narrow')}/"
        def font_narrow_bold = pf_narrow_bold + "PT_Sans-Narrow-Web-Bold.ttf"

        renderer.getFontResolver().addFontDirectory(pf, true);
        renderer.getFontResolver().addFont(font, true);
        renderer.getFontResolver().addFontDirectory(pf_narrow, true);
        renderer.getFontResolver().addFont(font_narrow, true);
        renderer.getFontResolver().addFontDirectory(pf_bold, true);
        renderer.getFontResolver().addFont(font_bold, true);
        renderer.getFontResolver().addFontDirectory(pf_narrow_bold, true);
        renderer.getFontResolver().addFont(font_narrow_bold, true);

        ITextFontResolver fontResolver = renderer.getFontResolver();
        fontResolver.addFontDirectory(pf, true);
        fontResolver.addFont(font, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        fontResolver.addFontDirectory(pf_narrow, true);
        fontResolver.addFont(font_narrow, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        fontResolver.addFontDirectory(pf_bold, true);
        fontResolver.addFont(font_bold, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        try {
            renderer.setDocument(url);
            renderer.layout();
            renderer.createPDF(baos);
            byte[] b = baos.toByteArray();
            return b
        }
        catch (Throwable e) {
            println "error pdf service " + e
        }
    }
}

