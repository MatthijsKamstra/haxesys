class Main {
	public function new() {
		trace("Appending string to file example");

		var str:String = '\ncurrent update: ${Date.now()}';

		var output:sys.io.FileOutput = sys.io.File.append('error.txt', false);
		output.writeString(str);
		output.close();
	}

	static public function main() {
		var app = new Main();
	}
}
