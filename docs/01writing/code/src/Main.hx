package;

import sys.io.File;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class Main {
	function new() {
		trace('Writing example');

		var str:String = 'Hello World!\nWritten on: ' + Date.now().toString();
		sys.io.File.saveContent('hello.txt', str);
	}

	static public function main() {
		var main = new Main();
	}
}
