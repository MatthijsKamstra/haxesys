package;

import haxe.io.Path;
import AST;

using StringTools;

class Main {
	// resume data
	var json:Resume;
	// defaults
	var TARGET:String; // current target (neko, node.js, c++, c#, python, java)
	var ASSETS:String; // root folder of the website
	var EXPORT:String; // folder to generate files in (in this case `docs` folder from github )
	// wip
	var __txt:String = '';
	var __md:String = '';
	var __arr:Array<String> = [];

	public function new() {
		TARGET = Sys.getCwd().split('bin/')[1].split('/')[0]; // yep, that works in this folder structure
		EXPORT = Path.normalize(Sys.getCwd().split('bin/')[0] + '/docs/${TARGET}'); // normal situation this would we just the `www` or `docs` folder
		ASSETS = Path.normalize(Sys.getCwd().split('bin/')[0] + '/assets/');

		trace('[${TARGET}] Working with resume.json');

		var path = Path.normalize(ASSETS + '/resume.json');

		if (sys.FileSystem.exists(path)) {
			var str:String = sys.io.File.getContent(path);
			json = haxe.Json.parse(str);
			trace("json.basics.name: " + json.basics.name);
			writeAll();
		} else {
			trace('ERROR: there is no spoon: $path');
		}
	}

	// ____________________________________ write tools ____________________________________

	function writeAll() {
		writeOut();
		writeTxt(); // first txt, because markdown modifice __txt (need to fix that)
		writeMarkdown();
		writeHtml();
	}

	function writeOut() {
		__arr = [];
		for (varName in Reflect.fields(json)) {
			__arr.push(capitalizeFirstLetter(varName));
		}

		__txt = '';
		unwrapJson(json, '');
	}

	function writeMarkdown() {
		var str = '# ${json.basics.name}\n';
		str += '## ${json.basics.label}\n';
		str += '\n';

		// [mck] here some quick and dirty string manipulation
		__txt = __txt.replace('\t\t', '**- '); // convert the dubble tab
		__txt = __txt.replace('\t', '- '); // convert tab to list
		__txt = __txt.replace('**- ', '\t- '); // convert the dubble tab to dubble tab list

		for (i in 0...__arr.length) {
			var r = __arr[i];
			__txt = __txt.replace(r, '\n### ${r}\n'); // convert the dubble tab to dubble tab list
		}

		str += __txt;

		__md = Markdown.markdownToHtml(__txt);

		writeFile(EXPORT, 'resume.md', str);
	}

	function writeTxt():Void {
		var str = '${json.basics.name}\n';
		str += '${json.basics.label}\n';
		str += '\n';

		str += __txt;

		writeFile(EXPORT, 'resume.txt', str);
	}

	function writeHtml():Void {
		var str = '<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <title>${json.basics.name}</title>
  </head>
  <body>
    <main class="container">

		${__md}

	</main>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
</html>';

		writeFile(EXPORT, 'resume.html', str);
	}

	// ____________________________________ tools ____________________________________

	function unwrapJson(json:Dynamic, ?tab:String = '\t') {
		for (varName in Reflect.fields(json)) {
			// __txt += '${capitalizeFirstLetter(varName)}\n';
			// trace(varName, haxe.Json.stringify(Reflect.field(json, varName)));

			switch (Type.typeof(Reflect.field(json, varName))) {
				case TObject:
					__txt += '${tab}${capitalizeFirstLetter(varName)}\n';
					// deeper into the rabit hole
					// trace('object : ${varName}');
					unwrapJson(Reflect.field(json, varName), tab + '\t');

				case TClass(String):
					// trace('${tab}string : ${varName} : ${Reflect.field(json, varName)}');
					__txt += '${tab}${capitalizeFirstLetter(varName)}: ${Reflect.field(json, varName)}\n';

				case TClass(Array):
					__txt += '${tab}${capitalizeFirstLetter(varName)}\n';
					// trace('array : ${varName}');
					// trace('array : ${varName} : ${Reflect.field(json, varName)}');
					var arr:Array<Dynamic> = Reflect.field(json, varName);
					// trace('array: ${varName} :  ${arr.length}');
					for (i in 0...arr.length) {
						var _json = haxe.Json.parse(haxe.Json.stringify(arr[i]));
						unwrapJson(_json, tab + '\t');
						// trace('--------> ${i}, ${haxe.Json.stringify(_json)}');
					}

				default:
					// trace(">>>>>> " + Type.typeof(pjson));
					// trace(">>>>>> " + (Reflect.field(pjson,i)));
					trace("[FIXME] type: " + Type.typeof(Reflect.field(json, varName)) + ' / ${varName}: ' + Reflect.field(json, varName));
			}
		}
	}

	/**
	 * does what it says
	 * @param string 	convert this to a word that starts with a capital (word -> Word)
	 * @return String
	 */
	function capitalizeFirstLetter(string:String):String {
		return string.charAt(0).toUpperCase() + string.substring(1);
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

	// ____________________________________ starting point ____________________________________

	static public function main():Void {
		var main = new Main();
	}
}
