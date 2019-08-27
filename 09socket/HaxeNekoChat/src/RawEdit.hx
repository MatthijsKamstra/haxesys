package ;

/**
 * RawEdit.hx
 * A rather specific class, which enables basic text input functionality while supporting
 * "interrupting" of editing process by output from other threads.
 * Acts fairly blindly, since no information can be read from output stream.
 * @author YellowAfterlife
 */

class RawEdit {
	/** Current cursor position */
	public var pos(default, null):Int;
	/** Current text content */
	public var text(default, null):String;
	/** Input prefix */
	public var prefix(default, setPrefix):String;
	/** Response handler. Should return, whether RawEdit should continue listening to input. */
	public var onSend:String->Bool;
	/** Keypress handler */
	public var onKey:Int->Bool;
	/** Character input handler */
	public var onChar:String->Bool;
	/** Indicates whether component is active (scans for input). */
	public var active(default, null):Bool;
	/** Indicates whether component is currently visible. */
	public var visible(default, null):Bool;
	/** Indicates whether component is busy. Needed for multi-thread compatibility. */
	public var busy(default, null):Bool;
	public function new() {
		pos = 0;
		text = "";
		prefix = "";
		visible = false;
		busy = false;
	}
	/** Resets input text */
	public function reset() {
		hide();
		pos = 0;
		text = "";
		show();
	}
	/** Hides the component and terminates input loop */
	public function close() {
		active = false;
		hide();
	}
	/** Displays the component and starts input loop */
	public function open() {
		active = true;
		show();
		while (active) {
			var c = Sys.getChar(false);
			var o = Sys.stdout();
			if (onKey != null) if (!onKey(c)) continue;
			grab();
			if (c == 13 || c == 10) { // enter
				free();
				if (onSend != null) active = onSend(text);
				else active = false;
				grab();
				if (active) reset();
				else o.writeString(text.substr(pos));
			} else if (c == 224) { // control symbol
				c = Sys.getChar(false);
				if (c == 75) { // left
					if (pos > 0) {
						o.writeByte(8);
						pos--;
					}
				} else if (c == 77) { // right
					if (pos < text.length) {
						o.writeString(text.charAt(pos));
						pos++;
					}
				} else if (c == 79) { // end
					o.writeString(text.substr(pos));
					pos = text.length;
				} else if (c == 71) { // home
					for (i in 0 ... pos) o.writeByte(8);
					pos = 0;
				} 
			} else if (c == 8) { // backspace
				if (pos > 0) {
					o.writeByte(8);
					o.writeString(text.substr(pos) + " ");
					for (i in 0 ... text.length - pos + 1) o.writeByte(8);
					text = text.substr(0, pos - 1) + text.substr(pos);
					pos--;
				}
			} else { // probably a symbol
				var s = String.fromCharCode(c);
				if (onChar == null || onChar(s)) {
					text = text.substr(0, pos) + s + text.substr(pos);
					o.writeString(text.substr(pos));
					for (i in 0 ... text.length - pos - 1) o.writeByte(8);
					pos++;
				}
			}
			free();
		}
	}
	public function hide() {
		if (!visible) return;
		visible = false;
		var o = Sys.stdout();
		var tl = text.length, pl = prefix.length;
		for (i in 0 ... pos + pl) o.writeByte(8);
		for (i in 0 ... tl + pl) o.writeByte(32);
		for (i in 0 ... tl + pl) o.writeByte(8);
	}
	public function show() {
		if (visible) return;
		visible = true;
		var o = Sys.stdout();
		o.writeString(prefix);
		o.writeString(text);
		for (i in 0 ... text.length - pos) o.writeByte(8);
	}
	public function write(s:String) {
		grab(); hide();
		Sys.stdout().writeString(s);
		show(); free();
	}
	public function setPrefix(s:String):String {
		if (visible) {
			grab(); hide();
			prefix = s;
			show(); free();
			return prefix;
		}
		return (prefix = s);
	}
	inline function wait() { while (busy) { /* do nothing */ } }
	inline function grab() { wait(); busy = true; }
	inline function free() { busy = false; }
}