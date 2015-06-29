package arazu.utils

/**
 * Created by LUZ on 028 28-Jun-15.
 * https://gist.github.com/bdkosher/5615324
 */
import java.util.zip.*

/**
 * Makes it easier to unzip files by adding extraction methods to the entries themselves and providing Closure-based
 * methods for finding specific entries.
 *
 * For example, to extract all XML files to a certain directory:
 * <code>
 * new Unzipper(zip).findAllEntries { it.name.endsWith(".xml") }.each { it.extractTo(someDir) }* </code>
 */
class Unzipper {
    final ZipFile zipFile

    Unzipper(File file) {
        this.zipFile = new ZipFile(file) // throws NPE if file is null
    }

    Unzipper(ZipFile zipFile) {
        if (zipFile == null) {
            throw new NullPointerException("ZipFile constructor arg cannot be null")
        }
        this.zipFile = zipFile
    }

    /**
     * Wraps the ZipEntry class and provides additional functionality for interacting with the data bounded by the zip entry.
     */
    class Entry extends ZipEntry {
        final ZipEntry ze

        Entry(ZipEntry ze) {
            super(ze)
            this.ze = ze
        }

        /**
         * Returns just the file name part of the entry name. E.g. this methods returns baz.entry for when the entry
         * name is /foo/bar/baz.entry
         */
        String getFileName() {
            return getName().split('/').last()
        }

        /**
         * Returns everything up until the file name (trailing slash included). E.g. this method
         * returns /foo/bar/ for entry /foo/bar/baz.entry
         */
        String getFilePath() {
            return getName() - getFileName()
        }

        /**
         * Create a new InputStream for this zip entry and passes it into the closure. This method
         * ensures the stream is closed after the closure returns.
         */
        Object withInputStream(Closure closure) {
            InputStream input
            try {
                input = zipFile.getInputStream(ze)
                return closure.call(input)
            } finally {
                if (input != null) {
                    try {
                        input.close()
                    } catch (IOException e) {
                        // intentionally ignored
                    }
                }
            }
        }

        /**
         * If the given file is non-existent or an existing file, the entry's contents are written to that file.
         * If the given file is a directory, then
         * the entry will be written to a sub-directory of that directory as per the zip entry's name. For example,
         * uz.extractTo(new File('/') will put
         * the entry in /my/entry/contents.txt if the entry name is "/my/entry/contents.txt"
         *
         * If you wish to extract to a directory flattened, such as extracting the aforementioned example to simply
         * "/contents.txt", you can do the following:
         * <code>
         * new Unzipper(zip).eachEntry { entry ->
         *     entry.extractTo(new File(someDir, entry.getFileName()))
         *}* </code>
         *
         * A second, optional int argument can be provided to specify the buffer size.
         *
         * The file to where the entry was ultimately written to is returned.
         */
        File extractTo(File file, int bufferSize = 2048) {
            if (file.isDirectory()) {
                File entryDir = new File(file, this.getName() - this.getFileName())
                entryDir.mkdirs()
                extractTo(new File(entryDir, this.getFileName()), bufferSize)
            } else {
                this.withInputStream() { input ->
                    byte[] buffer = new byte[bufferSize]
                    file.withOutputStream() { output ->
                        int len = input.read(buffer)
                        output.write(buffer, 0, len)
                    }
                }
                return file
            }
        }
    }

    /**
     * For each entry in the zip file, exposes the Unzipper.Entry instance to the closure
     */
    void eachEntry(Closure closure) {
        zipFile.entries().each {
            closure.call(new Entry(it))
        }
    }

    /**
     * Finds all Unzipper.Entry instances matching the closure condition.
     */
    List<Entry> findAllEntries(Closure closure) {
        List<Entry> entries = []
        this.eachEntry {
            if (closure.call(it)) {
                entries.add(it)
            }
        }
        return entries
    }

    /**
     * Returns all entries in the zip file as a List of Unzipper.Entry instances
     */
    List<Entry> entries() {
        findAllEntries { true }
    }

    /**
     * Finds the first Unzipper.Entry matching the closure condition. FIXME!!!!
     */
    Entry findEntry(Closure closure) {
        for (ZipEntry ze in zipFile.entries()) {
            Entry entry = new Entry(ze)
            if (closure.call(entry)) {
                return entry
            }
        }
    }
}