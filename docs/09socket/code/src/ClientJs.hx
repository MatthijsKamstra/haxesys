package;

import js.html.WebSocket;
import js.Browser.*;

class ClientJs {
	// static inline final WS_LOCALHOST_8080 = 'ws://localhost:5000';
	static inline final WS_LOCALHOST_8080 = 'ws://192.168.2.4:5000';

	public function new() {
		// Create WebSocket connection.
		var socket = new WebSocket(WS_LOCALHOST_8080);

		// Connection opened
		socket.addEventListener('open', function(event) {
			socket.send('Hello Server!');
		});

		// Listen for messages
		socket.addEventListener('message', function(event) {
			console.log('Message from server ', event.data);
		});
	}

	static public function main() {
		var app = new ClientJs();
	}
}
