package;

import sys.net.Socket;
import sys.net.Host;

class Client {
	var TARGET:String;
    var socket:Socket;

	public function new() {
		TARGET = Sys.getCwd().split('bin/')[1].split('/')[0]; // yep, that works in this folder structure

		trace('Client - ${TARGET}');

		var host = new Host(Host.localhost());

		try {
		    socket = new Socket();
			socket.connect(host, 5000);
			while (true) {
				var _in = socket.input.readLine();
				trace(_in);
				if (_in == "exit") {
					socket.close();
					break;
				}
			}
		} catch (e:Dynamic) {
			// handle connection errors...
			trace('Error: $e');
                return;
		}

	}

    function onChatLine(text:String):Bool {
        try {
            socket.write(text + '\n');
        } catch (z:Dynamic) {
            trace('Connection lost.\n');
            return false;
        }
        return true;
    }

	static public function main() {
		var app = new Client();
	}
}
