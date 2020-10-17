package;

import sys.net.Socket;
import sys.net.Host;

class Server {
	var TARGET:String;

	public function new() {
		#if !neko
		TARGET = Sys.getCwd().split('bin/server/')[1].split('/')[0]; // yep, that works in this folder structure
		#end

		trace('Server - ${TARGET}');
		Sys.println('Server - ${TARGET}');
		// Sys.stdout().writeString('Server - ${TARGET}');

		var port = 5000;
		var host = new Host(Host.localhost());

		var socket = new Socket();

		socket.bind(host, port);
		// socket.connect(host, port);
		// #if !java
		// // socket.setBlocking(false);
		// #end
		socket.listen(10);

		trace('Starting server... ${host}, ${socket.host()}');
		append('Starting server... ${host}, ${socket.host()}');
		while (true) {
			try {
				var c = socket.accept();
				c.output.writeString("HTTP/1.1 101 Switching Protocols\r\n" + "Upgrade: websocket\r\n" + "Connection: keep-alive, upgrade\r\n"
					+ "Sec-WebSocket-Key: ''\r\n" + "Sec-WebSocket-Version: 13" + "\r\n" + "\r\n");
				if (c != null) {
					// try {
					// 	socket.setBlocking(false);
					// } catch (e:Dynamic) {
					// 	trace(e);
					// 	append(e);
					// }
					trace('Client connected... ${c.host()}');
					append('Client connected... ${c.host()}');
					append('Client connected... ${c}');

					// Sys.println('Client connected... ${c.host()}');
					// Sys.stdout().writeString('Client connected... ${c.host()}');

					// try {
					// 	Sys.print(c.input.readString(1));
					// 	append('> ' + c.input.readString(1));
					// } catch (e:haxe.io.Error) {
					// 	switch e {
					// 		case haxe.io.Error.Blocked: // no problem
					// 		case haxe.io.Error.Custom(c) if (c == haxe.io.Error.Blocked): // no problem
					// 		default:
					// 			throw e;
					// 	}
					// } catch (e:haxe.io.Eof) {
					// 	append('Got Eof');
					// 	trace('Got Eof');
					// }
					c.write("hello !\n");
					c.write('Server - $TARGET \n');
					c.write("Current date: " + Date.now() + "\n");
					c.write("your IP is " + c.peer().host.toString() + "\n");
					c.write("your: " + c.peer() + "\n");
					c.write("exit");
					c.close();
				}
			} catch (e:Dynamic) {
				trace(e);
				append('---->  ' + e);
			}
		}
	}

	public static function append(msg:String) {
		var output:sys.io.FileOutput = sys.io.File.append('error.txt', false);
		output.writeString('\n- $msg');
		output.close();
	}

	static function main() {
		var app = new Server();
	}
}
