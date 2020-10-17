package;

import sys.io.FileOutput;
import sys.io.File;

class Main {
	public function new() {
		trace("Appending string to file example");

		var str:String = '\n- current update: ${Date.now()}';

		var output = File.append('error.txt', false);
		output.writeString(str);
		output.close();
	}

	static public function main() {
		var app = new Main();
	}
}
