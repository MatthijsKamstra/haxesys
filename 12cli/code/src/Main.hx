package;

import haxe.io.Path;

using StringTools;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class Main {
	/**
	 * 0.0.1 	initial release
	 */
	var VERSION:String = '0.0.1';

	// defaults
	var TARGET:String; // current target (neko, node.js, c++, c#, python, java)
	var ASSETS:String; // root folder of the website
	var EXPORT:String; // folder to generate files in (in this case `docs` folder from github )

	public function new(?args:Array<String>) {
		TARGET = Sys.getCwd().split('bin/')[1].split('/')[0]; // yep, that works in this folder structure
		EXPORT = Path.normalize(Sys.getCwd().split('bin/')[0] + '/docs/${TARGET}'); // normal situation this would we just the `www` or `docs` folder
		ASSETS = Path.normalize(Sys.getCwd().split('bin/')[0] + '/assets/');

		Sys.println('[${TARGET}] CLI "hxLoremIpsum" ');

		var args:Array<String> = args;

		if (args.length == 0)
			args.push('-h');

		for (i in 0...args.length) {
			var temp = args[i];
			switch (temp) {
				case '-v', '-version':
					Sys.println('version: ' + VERSION);
				case '-cd', '-folder': // isFolderSet = true;
				case '-help', '-h':
					showHelp();
				case '-out', '-o':
					writeOut();
				default:
					trace("case '" + temp + "': trace ('" + temp + "');");
			}
		}
	}

	function writeOut(){
		var str = '# README\n\n**Generated on:** ${Date.now()}\n**Target:** ${TARGET}';
		writeFile(Sys.getCwd(), 'README.MD', str);
	}

	/**
	 * simply write the files
	 * @param path 		folder to write the files (current assumption is `EXPORT`)
	 * @param filename	(with extension) the file name
	 * @param content	what to write to the file (in our case markdown)
	 */
	function writeFile(path:String, filename:String, content:String) {
		if (!sys.FileSystem.exists(path)) {
			sys.FileSystem.createDirectory(path);
		}
		// write the file
		sys.io.File.saveContent(path + '/${filename}', content);
		trace('written file: ${path}/${filename}');
	}

	function correctCLI(target:String):String{
		var str = '';
		switch (target) {
			case 'neko':
				str = 'neko main';
			case 'cpp':
				str = '/Main';
			case 'cs':
				str = 'mono Main.exe';
			case 'java':
				str = 'java -jar Main.jar';
			case 'lua':
				str = 'lua main.lua';
			case 'node':
				str = 'node main.js';
			case 'python':
				str = 'python3 main.py';
			default :
				str = '[xxx]';
				trace ("case '"+target+"': trace ('"+target+"');");
		}
		return str;
	}

	 function showHelp():Void {
		Sys.println('------------------------------------------------
hxLoremIpsum ($VERSION)

How to use (${TARGET}):
${correctCLI(TARGET)} -out

	-version / -v   : version number
	-help / -h      : show this help
	-folder / -cd   : path to project folder
	-out / -o       : write readme
------------------------------------------------
');

	}

	static public function main() {
		var app = new Main(Sys.args());
	}
}
