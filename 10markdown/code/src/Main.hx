package;

import haxe.io.Path;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class Main {
	private static var TARGET:String;
	private static var ASSETS:String;
	private static var WWW:String;

	function new() {
		trace("Creating a static site generator");

		var startTime = Date.now().getTime();

		TARGET = Sys.getCwd().split('code/bin/')[1].split('/')[0]; // yep, that works in this folder structure
		WWW = Path.normalize(Sys.getCwd().split('bin/')[0] + '/www/${TARGET}'); // normal situation this would we just the `www` folder
		ASSETS = Path.normalize(Sys.getCwd().split('bin/')[0] + '/assets/');

		trace('Current target: $TARGET');

		writeIndex();
		writePosts();
		writePages();

		trace('[${TARGET}] done in ${Date.now().getTime() - startTime}ms');
	}

	function writeIndex() {
		var path = Path.normalize(ASSETS + '/home.md');
		if (sys.FileSystem.exists(path)) {
			var md:String = sys.io.File.getContent(path);
			writeHtml(WWW, 'index', Markdown.markdownToHtml(md));
		} else {
			trace('ERROR: there is not file: $path');
		}
	}

	function writePosts() {
		var folder = Path.normalize(ASSETS + '/posts');
		var filesOrFoldersArray = sys.FileSystem.readDirectory(folder);
		for (i in 0...filesOrFoldersArray.length) {
			// lets assume everyting is a file
			var file = filesOrFoldersArray[i];
			// get the name of the file
			var filename = Path.withoutExtension(file);
			// get content of the file
			var content:String = sys.io.File.getContent(folder + "/" + file);
			// get path to www folder
			var path = Path.normalize(WWW + '/posts');
			// write
			writeHtml(path, filename, Markdown.markdownToHtml(content));
		}
	}

	/**
	 * simpley write the files
	 * @param path 		folder to write the files (current assumption is `www`)
	 * @param filename	the file name (without extension)
	 * @param content	what to write to the file (in our case markdown)
	 */
	function writeHtml(path:String, filename:String, content:String) {
		if (!sys.FileSystem.exists(path)) {
			sys.FileSystem.createDirectory(path);
		}
		// we need to wrap the content
		var html = '<!-- navigation -->\n${content}\n<!-- footer -->';
		// write the file
		sys.io.File.saveContent(path + '/${filename}.html', html);
		trace('written file: ${path}/${filename}.html');
	}

	function writePages() {
		// create the pages
	}

	function writeNavigation() {
		// create the navigation
	}

	static public function main() {
		var main = new Main();
	}
}
