package;

import haxe.io.Path;
import sys.io.Process;

using StringTools;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class Main {
	// defaults
	var TARGET:String; // current target (neko, node.js, c++, c#, python, java)

	public function new(?args:Array<String>) {
		TARGET = Sys.getCwd().split('bin/')[1].split('/')[0]; // yep, that works in this folder structure

		trace('[${TARGET}] Sys.command() ');

		// simple echo
		Sys.command('echo', ['[${TARGET}] Sys.command()']);
		// create a file
		Sys.command('touch', ['readme.md']);
		// put echo into file
		Sys.command('echo "Generated on ${Date.now()} / ${TARGET}" >> readme.md');
		// https://guide.freecodecamp.org/bash/bash-ls/
		Sys.command('ls', ['-a', '-l', '-G']);
		// https://guide.freecodecamp.org/bash/bash-man
		// Sys.command('man', ['ls', '-f', '-a']);
		// read whole file
		Sys.command('cat', ['readme.md']);

		// check if ffmpeg is installed
		Sys.command('ffmpeg', ['-version']);

		// print a message on the screen
		Sys.println("lets see if you have ffmpeg installed");
		var p:Process = new Process('ffmpeg', ['-version']);
		var out = p.stdout.readAll().toString();
		p.close();

		if(out.indexOf('ffmpeg version') != -1){
			trace('You have ffmpeg installed!');
		} else {
			trace('Visit ffmpeg.org to install!');
		}

	}

	static public function main() {
		var app = new Main(Sys.args());
	}
}
