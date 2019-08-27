package ;
import neko.vm.Thread;
import sys.net.Host;
import sys.net.Socket;

/**
 * Server.hx
 * Server side of chat.
 * @author YellowAfterlife
 */

class ClientInfo {
	public var socket:Socket;
	public var name:String;
	public var server:Server;
	public var active:Bool;
	public function new(sv:Server, skt:Socket) {
		server = sv;
		socket = skt;
		name = '';
		active = true;
	}
	public function toString():String {
		var peer = socket.peer();
		var pstr = Std.string(peer.host) + ':' + peer.port;
		return (name == null || name == '') ? pstr : (name + '(' + pstr + ')');
	}
	public function send(text:String) {
		try {
			socket.output.writeString(text);
		} catch (z:Dynamic) {
			active = false;
		}
	}
}
class ServerInfo extends ClientInfo {
	public function new(sv:Server) {
		super(sv, null);
		name = 'Server';
	}
	override public function toString():String {
		return name + '(console)';
	}
	override public function send(text:String):Dynamic {
		server.console.write(text);
	}
}
class Server {
	public var socket:Socket;
	public var clients:Array<ClientInfo>;
	public var console:RawEdit;
	public var info:ServerInfo;
	/** Sends given text to all active clients */
	public function broadcast(text:String) {
		for (cl in clients) {
			cl.send(text);
		}
	}
	/** Finds client(s) that match given name */
	public function findClients(name:String) {
		var r:Array<ClientInfo> = [];
		name = name.toLowerCase();
		for (cl in clients) {
			if (cl.name.toLowerCase().indexOf(name) != -1) r.push(cl);
		}
		return r;
	}
	/** Chat message handler */
	public function onChat(text:String, cl:ClientInfo) {
		if (text == '') return;
		if (text.charAt(0) == '/') {
			console.write(Std.string(cl) + ' issued command: ' + text + '\n');
			text = text.substr(1);
			var rx = ~/^(\w+) *(.*)/g;
			if (!rx.match(text)) { cl.send('Not a valid command format.'); return; }
			var cmd = rx.matched(1);
			var par = rx.matched(2);
			switch (cmd) {
				case 'list', 'online': // lists online users
					var r = '', c = 0;
					for (cl in clients) {
						if (c++ != 0) r += ', ';
						r += cl.name;
					}
					r = 'Users online (' + c + '): ' + r + '\n';
					cl.send(r);
				case 'name', 'nick': // changes username
					rx = ~/^(\w+)/;
					if (!rx.match(par)) { cl.send('Not a valid name.\n'); return; }
					var name = rx.matched(1);
					// check if new name does not match with existing one:
					var overlap = false;
					for (cl in clients) { if (name == cl.name) { overlap = true; break; } }
					if (overlap) { cl.send('Such name already exists.'); return; }
					// inform participants:
					console.write(Std.string(cl) + ' is now known as ' + name + '.\n');
					if (cl.name == '') {
						broadcast(name + ' connected.\n');
					} else broadcast(cl.name + ' is now known as ' + name + '.\n');
					cl.name = name;
					return;
				case 'msg', 'm': // sends private message
					rx = ~/^(\w+) *(.+)/;
					if (!rx.match(par)) { cl.send('Invalid format.\n'); return; }
					var rcs = findClients(rx.matched(1));
					if (rcs.length == 0) { cl.send('User not found.\n'); return; }
					var msg = rx.matched(2);
					for (rc in rcs) {
						cl.send('[me > ' + rc.name + '] ' + msg + '\n');
						rc.send('[' + cl.name + ' > me] ' + msg + '\n');
					}
			}
		} else {
			console.write(Std.string(cl) + ': ' + text + '\n');
			broadcast((cl != null ? cl.name + ': ' : '') + text + '\n');
		}
	}
	/** Accepts new sockets and spawns new threads for them */
	function threadAccept() {
		while (true) {
			var sk = socket.accept();
			if (sk != null) {
				var cl = new ClientInfo(this, sk);
				Thread.create(getThreadListen(cl));
			}
		}
	}
	/** Creates a new thread function to handle given ClientInfo */
	function getThreadListen(cl:ClientInfo) {
		return function() {
			clients.push(cl);
			console.write(Std.string(cl) + ' connected.\n');
			while (cl.active) {
				try {
					var text = cl.socket.input.readLine();
					if (cl.active) onChat(text, cl);
				} catch (z:Dynamic) {
					break;
				}
			}
			console.write(Std.string(cl) + ' timed out.\n');
			broadcast(cl.name + ' disconnected.\n');
			clients.remove(cl);
			try {
				cl.socket.shutdown(true, true);
				cl.socket.close();
			} catch (e:Dynamic) {
				
			}
		}
	}
	public function new() {
		var cout = Sys.stdout();
		var cin = Sys.stdin();
		// Read port:
		cout.writeString('Port: ');
		var port = Std.parseInt(cin.readLine());
		if (port == null) port = 17051;
		// Bind server to port and start listening:
		cout.writeString('Binding...\n');
		try {
			socket = new Socket();
			socket.bind(new Host('127.0.0.1'), port);
			socket.listen(3);
		} catch (z:Dynamic) {
			cout.writeString('Could not bind to port.\n');
			cout.writeString('Ensure that no server is running on port ' + port + '.\n');
			return;
		}
		cout.writeString('Done.\n');
		// Initialize some values
		info = new ServerInfo(this);
		clients = [];
		console = new RawEdit();
		console.prefix = '> ';
		console.onSend = function(t:String) { onChat(t, info); return true; };
		//
		Thread.create(threadAccept);
		console.open();
	}
}