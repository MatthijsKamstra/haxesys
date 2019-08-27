package ;

import neko.Lib;

/**
 * Main.hx
 * @author YellowAfterlife
 */

class Main {
	static function main() {
		Sys.stdout().writeString('Application mode (server/client): ');
		var m = Sys.stdin().readLine().toLowerCase();
		if (m == 's' || m == 'sv' || m == 'server') {
			new Server();
		} else {
			new Client();
		}
	}
}