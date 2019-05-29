package;

import haxe.Http;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class Main {
	function new() {
		trace('http api call example quote');
		// this was the first api I found without authentication and http...
		getUrl('http://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en', false);
	}

	function getUrl(url:String, ?isPost:Bool = false):Void {
		var req = new haxe.Http(url);

		req.onData = function(data:String) {
			try {
				trace(data);
				var json:ForismaticObj = haxe.Json.parse(data);
				output(json);
			} catch (e:Dynamic) {
				trace(e);
			}
		}

		req.onError = function(error:String) {
			trace('error: $error');
		}

		req.onStatus = function(status:Int) {
			trace('status: $status');
		}

		req.request(isPost); // false=GET, true=POST
	}

	function output(data:ForismaticObj) {
		trace('"${data.quoteText}" - ${data.quoteAuthor}');
	}

	static public function main():Void {
		var main = new Main();
	}
}

typedef ForismaticObj = {
	var quoteText : String; //I walk slowly, but I never walk backward.
	var quoteAuthor : String; //Abraham Lincoln
	var senderName : String; //
	var senderLink : String; //
	var quoteLink : String; //http://forismatic.com/en/a0acd17bfb/"}
}
