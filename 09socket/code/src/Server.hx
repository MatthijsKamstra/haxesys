package;

import sys.net.Socket;
import sys.net.Host;

class Server {
	var TARGET:String;

	public function new() {
		TARGET = Sys.getCwd().split('bin/')[1].split('/')[0]; // yep, that works in this folder structure

		trace('Server - ${TARGET}');
		Sys.println('Server - ${TARGET}');
		Sys.stdout().writeString('Server - ${TARGET}');

		var host = new Host(Host.localhost());
		var socket = new Socket();
		socket.bind(host, 5000);
		socket.listen(1);

		trace('Starting server... ${host}, ${socket.host()}');
		while (true) {
			var c:sys.net.Socket = socket.accept();
			trace('Client connected... ${c.host()}');
			Sys.println('Client connected... ${c.host()}');
			Sys.stdout().writeString('Client connected... ${c.host()}');
			c.write("hello !\n");
			c.write('Server - $TARGET \n');
			c.write("Current date: " + Date.now() + "\n");
			c.write("your IP is " + c.peer().host.toString() + "\n");
			c.write("exit");
			c.close();
		}
	}

	static function main() {
		var app = new Server();
	}
}
