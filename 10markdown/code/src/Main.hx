package;

import haxe.io.Path;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class Main {
	private static var TARGET:String; // current target (neko, node.js, c++, c#, python, java)
	private static var ASSETS:String; // root folder of the website
	private static var WWW:String; // folder to generate files in (in this case `docs` folder from github )

	function new() {
		var startTime = Date.now().getTime(); // lets see how fast target really are

		TARGET = Sys.getCwd().split('code/bin/')[1].split('/')[0]; // yep, that works in this folder structure
		WWW = Path.normalize(Sys.getCwd().split('bin/')[0] + '/docs/${TARGET}'); // normal situation this would we just the `www` or `docs` folder
		ASSETS = Path.normalize(Sys.getCwd().split('bin/')[0] + '/assets/');

		trace('[${TARGET}] Creating a static site generator');

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
	 * simply write the files
	 * @param path 		folder to write the files (current assumption is `www`)
	 * @param filename	the file name (without extension)
	 * @param content	what to write to the file (in our case markdown)
	 */
	function writeHtml(path:String, filename:String, content:String) {
		if (!sys.FileSystem.exists(path)) {
			sys.FileSystem.createDirectory(path);
		}
		// we need to wrap the content
		var html = '<!doctype html>\n<html lang="en">\n${createHead()}\n<body>\n${createNavigation()}\n<main rol="main">\n${content}\n</main>\n${createFooter()}\n</body>\n</html>';
		// write the file
		sys.io.File.saveContent(path + '/${filename}.html', html);
		trace('written file: ${path}/${filename}.html');
	}

	function writePages() {
		// create the pages
	}

	function createHead():String {
		var head = '
		<head>
			<!-- Required meta tags -->
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
			<!-- Bootstrap CSS -->
			<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
			<title>Hello, world!</title>
		</head>';
		return head;
	}

	function createNavigation():String {
		var str = '<header>\n<!-- navigation -->\n</header>';
		return str;
	}

	function createFooter():String {
		var str = '<footer>\n<!-- footer -->\n</footer>
		<!-- Optional JavaScript -->
		<!-- jQuery first, then Popper.js, then Bootstrap JS -->
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		';
		return str;
	}

	static public function main() {
		var main = new Main();
	}
}
