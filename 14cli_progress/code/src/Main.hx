package;


/**
 * @author Matthijs Kamstra aka [mck]
 */
class Main {

	public function new() {
		var total = 50;
		var current = 0;
		for(i in 0...total){
			Sys.sleep(0.1);
			current++;
			progressBar(current,total);
		}
	}

	/**
	 * |█████████████████████████████████████████████-----| 90.0%
	 *
	 * @param  current 		progress value
	 * @param  total   		total value
	 */
	function progressBar(current:Int, total:Int){
		var _fill = '█';
		var _current = '';
		var _rest = '';
		for(i in 0...current){
			_current += _fill;
		}
		for(i in 0...(total-current)){
			_rest += '-';
		}
		var progress = '|${_current}${_rest}| ${Std.int((current/total)*100)}%';
		Sys.stdout().writeString ('\r'+progress);
		Sys.stdout().flush();
	}

	static public function main() {
		var app = new Main();
	}
}
