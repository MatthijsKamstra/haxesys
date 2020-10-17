package;

import js.html.WebSocket;
import js.Browser.*;

class ClientJs {
	// static inline final WS_LOCALHOST_8080 = 'ws://localhost:5000';
	static inline final WS_LOCALHOST_8080 = 'ws://192.168.2.4:5000';

	public function new() {
		// Create WebSocket connection.
		var socket = new WebSocket(WS_LOCALHOST_8080);

		readableOut(socket.readyState);

		// Connection opened
		socket.addEventListener('open', function(event) {
			// socket.send('Hello Server!');
			readableOut(socket.readyState);
			trace('yes');
		});

		// Listen for messages
		socket.addEventListener('message', function(event) {
			console.log('Message from server ', event.data);
		});

		socket.onopen = function(event) {
			readableOut(socket.readyState);
			console.log("WebSocket is open");
		}

		socket.onclose = function(event) {
			readableOut(socket.readyState);
			console.log("WebSocket is closed now.");
		};
		socket.onerror = function(event) {
			readableOut(socket.readyState);
			console.log("WebSocket error.");
			console.log(event);
		};
		socket.onmessage = function(event) {
			readableOut(socket.readyState);
			console.log("WebSocket message");
		};
	}

	function readableOut(val) {
		switch (val) {
			case 0:
				trace('0 - CONNECTING - Socket has been created. The connection is not yet open.');
			case 1:
				trace('1 - OPEN - The connection is open and ready to communicate.');
			case 2:
				trace('2 - CLOSING - The connection is in the process of closing.');
			case 3:
				trace('3 - CLOSED - The connection is closed or couldn\'t be opened.');
			default:
				trace("case '" + 0 + "': trace ('" + 0 + "');");
		}
	}

	static public function main() {
		var app = new ClientJs();
	}
}
