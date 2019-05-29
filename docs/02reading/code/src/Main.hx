package ;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class Main {
	function new(){
		trace("Reading and writing example");

		var str:String = 'Writing and reading a simple text file.!\nWritten on: ' + Date.now().toString();

		// write the file
		sys.io.File.saveContent('hello.txt', str);

		// read the file
		var content = sys.io.File.getContent('hello.txt');
		trace (content);
	}

	static public function main() {
		var main = new Main();
	}
}