package;

import sys.net.Socket;
import sys.net.Host;

class Server {
    static function main() {
        var host = new Host(Host.localhost());
        var socket = new Socket();
        socket.bind(host,5000);
        socket.listen(1);
        trace('Starting server... ${host} ,${socket.host()}');
        while( true ) {
            var c : sys.net.Socket = socket.accept();
            trace('Client connected... ${c.host()}, ${c.custom}');
            c.write("hello\n");
            c.write("your IP is "+c.peer().host.toString()+"\n");
            c.write("exit");
            c.close();
        }
    }
}