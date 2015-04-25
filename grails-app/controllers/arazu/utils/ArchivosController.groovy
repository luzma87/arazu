package arazu.utils

import arazu.seguridad.Shield

import java.util.zip.ZipOutputStream
import java.util.zip.ZipEntry
import java.nio.channels.FileChannel

class ArchivosController extends Shield {

    def typeExt = [
            pdf: "pdf",
            txt: "text",
            doc: "doc", docx: "doc", odt: "doc",
            xls: "xls", xlsx: "xls", odp: "xls",
            ppt: "ppt", pptx: "ppt", pps: "pps", ods: "pps",
            png: "image", jpg: "image", jpeg: "image", bmp: "image",
            zip: "zip",
            mp3: "audio", wav: "audio",
            mp4: "video", wmv: "video"
    ]

    def mimeType = [
            pdf: "application/pdf",
            txt: "text/plain",
            doc: "application/msword", docx: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            xls: "application/msexcel", xlsx: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            ppt: "application/mspowerpoint", pptx: "application/vnd.openxmlformats-officedocument.presentationml.presentation",
            pps: "application/mspowerpoint", ppsx: "application/vnd.openxmlformats-officedocument.presentationml.slideshow",
            png: "image/png", jpg: "image/jpeg", jpeg: "image/jpeg", bmp: "image/bmp",
            zip: "application/zip",
            mp3: "audio/x-mpeg", wav: "audio/x-wav",
            mp4: "video/mp4", wmv: "video/x-ms-wmv",
            odt: "application/vnd.oasis.opendocument.text",
            odp: "application/vnd.oasis.opendocument.presentation",
            ods: "application/vnd.oasis.opendocument.spreadsheet"
    ]

    def okContents = [
            "application/pdf"         : "pdf",
            "text/plain"              : "txt",
            "application/msword"      : "doc", "application/vnd.openxmlformats-officedocument.wordprocessingml.document": "docx",
            "application/msexcel"     : "xls", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet": "xlsx",
            "application/mspowerpoint": "ppt", "application/vnd.openxmlformats-officedocument.presentationml.presentation": "pptx",
            "image/png"               : "png", "image/jpeg": "jpg", "image/jpeg": "jpeg", "image/bmp": "bmp",
            "application/zip"         : "zip",
            "audio/x-mpeg"            : "mp3", "audio/x-wav": "wav",
            "video/mp4"               : "mp4", "video/x-ms-wmv": "wmv"
    ]
    def space = "&nbsp;&nbsp;&nbsp;&nbsp;"

    public static String humanReadableByteCount_funcion(long bytes, boolean si) {
        int unit = si ? 1000 : 1024;
        if (bytes < unit) {
            return bytes + " B"
        };
        int exp = (int) (Math.log(bytes) / Math.log(unit));
        String pre = "" + (si ? "kMGTPE" : "KMGTPE").charAt(exp - 1) + (si ? "" : "i");
        return String.format("%.1f %sB", bytes / Math.pow(unit, exp), pre);
    }

    def listRecursivly_funcion = { file, arg ->
        def dirName = file.getName()
        def dirDate = new Date(file.lastModified())
        def dirPath = file.path
        def html = ""
        html += '<li data-jstree=\'{"type":"dir"}\' data-name="' + dirName + '" data-path="' + dirPath + '" class="dir">'
        html += dirName + space + "<small>" + dirDate.format("dd-MM-YYYY HH:mm:ss") + "</small>"
        html += "<ul>"
//        println "${'|  ' * arg}`- ${file.getName()}\\"
        file.eachFile() { f ->
            if (f.directory) {
                html += listRecursivly_funcion(f, (arg + 1))
            } else {
                def fileName = f.getName()
                def fileDate = new Date(f.lastModified())
                def fileSize = f.length()
                def filePath = f.path
                def ext = fileName.split("\\.").last()
                def tipo = typeExt[ext]
                if (!tipo) {
                    tipo = "file"
                }
                html += '<li data-jstree=\'{"type":"' + tipo + '"}\' data-name="' + fileName + '" data-path="' + filePath + '" class="' + tipo + '">'
                html += fileName + space + "<small><strong>" + humanReadableByteCount_funcion(fileSize, true) + "</strong>" +
                        space + "<small>" + fileDate.format("dd-MM-YYYY HH:mm:ss") + "</small>" + "</small>"
                html += "</li>"
//                println "${'|  ' * (arg + 1)}`- ${f.getName()}"
            }
        }
        html += "</ul>"
        html += "</li>"
        return html
    }

    String replaceLast_funcion(String string, String substring, String replacement) {
        int index = string.lastIndexOf(substring);
        if (index == -1) {
            return string
        };
        return string.substring(0, index) + replacement + string.substring(index + substring.length())
    }

    private static void addDirToArchive(ZipOutputStream zos, File srcFile) {
        File[] files = srcFile.listFiles();
        System.out.println("Adding directory: " + srcFile.getName());
        for (int i = 0; i < files.length; i++) {
            // if the file is directory, use recursion
            if (files[i].isDirectory()) {
                addDirToArchive(zos, files[i]);
                continue;
            }
            try {
                System.out.println("\tAdding file: " + files[i].getName());
                // create byte buffer
                byte[] buffer = new byte[1024];
                FileInputStream fis = new FileInputStream(files[i]);
                zos.putNextEntry(new ZipEntry(files[i].getName()));
                int length;
                while ((length = fis.read(buffer)) > 0) {
                    zos.write(buffer, 0, length);
                }
                zos.closeEntry();
                // close the InputStream
                fis.close();
            } catch (IOException ioe) {
                System.out.println("IOException :" + ioe);
            }
        }
    }

    def index() {
        def path = servletContext.getRealPath("/") + "archivos" + File.separator    //web-app/archivos
        new File(path).mkdirs()

        def html = "<ul>"
        html += listRecursivly_funcion(new File(path), 0)
        html += "</ul>"
        return [html: html]
    }

    def createFolder_ajax() {
        if (params.name.toString().trim() == "") {
            params.name = "Nueva carpeta"
        }
        def path = params.parent + File.separator + params.name
        new File(path).mkdirs()
        render "SUCCESS*Carpeta creada"
    }

    def rename_ajax() {
        if (params.name.toString().trim() == "") {
            params.name = "Sin nombre"
        }
        def path = params.path
        def newName = replaceLast_funcion(path.trim(), params.text.trim(), params.name.trim())
        def file = new File(path)
        if (file.renameTo("" + newName)) {
            render "SUCCESS*Nombre cambiado"
        } else {
            render "ERROR*Ha ocurrido un error"
        }
    }

    def delete_ajax() {
        def path = params.path
        def file = new File(path)
        def str = "Archivo eliminado"
        if (file.directory) {
            str = "Carpeta eliminada"
        }
        file.delete()
        render "SUCCESS*" + str
    }

    def downloadZip_ajax() {
        def path = params.path
//        def file = new File(path)
        def p = servletContext.getRealPath("/") + "zips" + File.separator
        new File(p).mkdirs()

        String zipFile = p + params.text + ".zip"
        String srcDir = path

        def excludes = "**/*.swp, somefile.txt, somedir/**"
        def ant = new AntBuilder()
        def args = [srcDir, zipFile]
        if (args.size() > 0) {
            if (args[0].endsWith("/") || args[0].endsWith("\\")) {
                args[0] = args[0].substring(0, args[0].length() - 1)
            }
            ant.zip(baseDir: args[0], destFile: args[1], excludes: excludes, update: true)
            println "DONE"

            def file = new File(zipFile)
            if (file.exists()) {
                response.setContentType("application/zip") // or or image/JPEG or text/xml or whatever type the file is
                response.setHeader("Content-disposition", "attachment;filename=\"${file.name}\"")
                response.outputStream << file.bytes
                return
            } else {
                render "Error!"
            } // appropriate error handling
        } else {
            println "usage: ZipDir.groovy [dirName]"
        }
    }

    def downloadArchivo() {
        def file = new File(params.path)
        def ext = file.name.split("\\.").last()
        if (file.exists()) {
            response.setContentType(mimeType[ext]) // or or image/JPEG or text/xml or whatever type the file is
            response.setHeader("Content-disposition", "attachment;filename=\"${file.name}\"")
            response.setContentLength(file.size().toInteger())
            response.outputStream << file.bytes
            return
        } else {
            render "Error!"
        } // appropriate error handling
    }

    def uploadFile_ignore() {
        def path = params.path

        def f = request.getFile('file')  //archivo = name del input type file

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext
            if (okContents.containsKey(f.getContentType())) {
                ext = okContents[f.getContentType()]

                def parts = fileName.split("\\.")
                fileName = ""
                parts.eachWithIndex { obj, i ->
                    if (i < parts.size() - 1) {
                        fileName += obj
                    }
                }
                fileName = fileName.size() < 40 ? fileName : fileName[0..39]
                fileName = fileName.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç .!¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")

                def nombre = fileName + "." + ext
                def pathFile = path + File.separator + nombre
                def fn = fileName
                def src = new File(pathFile)
                def i = 1
                while (src.exists()) {
                    nombre = fn + "_" + i + "." + ext
                    pathFile = path + nombre
                    src = new File(pathFile)
                    i++
                }
                println pathFile
                try {
                    f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                } catch (e) {
                    println "????????\n" + e + "\n???????????"
                }
                render "SUCCESS*Archivo subido"
            } else {
                render "ERROR*No se permite cargar el tipo de archivo seleccionado"
            }
        } else {
            render "ERROR*Seleccione un archivo para subir al servidor"
        }
    }
}
