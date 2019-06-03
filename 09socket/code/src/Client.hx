package;

import sys.net.Socket;
import sys.net.Host;

class Client {
    static function main() {
        var folder = Sys.getCwd();
        var target = folder.split('code/bin/')[1].split('/')[0]; // yep, that works

        trace('Client - ${target}');

        var host = new Host(Host.localhost());
        var socket = new Socket();
        socket.custom = target;
        try{
           socket.connect(host,5000);
            while( true ) {
                var l = socket.input.readLine();
                trace(l);
                if( l == "exit" ) {
                    socket.close();
                    break;
                }
            }
        } catch (e: Dynamic) {
            // handle connection errors...
            trace('Error: $e');
        }
    }
}