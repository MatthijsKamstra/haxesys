package;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class Main {
	// defaults
	var TARGET:String = ''; // current target (neko, node.js, c++, c#, python, java)

	public function new() {
		TARGET = Sys.getCwd().split('bin/')[1].split('/')[0]; // yep, that works in this folder structure

		trace('[${TARGET}] untyped');

		var myMessage = "Haxe is great!";

		#if js
		Sys.println('[${TARGET}]');
		// untyped __js__('// [js] comment');
		js.Syntax.code('// [js] comment');
		js.Node.console.log('js.Node.console.log');
		// untyped __js__('console.log({0})', myMessage);
		js.Syntax.code('console.log({0})', myMessage);
		untyped ('// [${TARGET}] simple untyped');
		#elseif php
		Sys.println('[${TARGET}]');
		untyped __php__('// [php] comment');
		php.Syntax.code('// [php] comment');
		untyped __php__("echo '<pre>'; print_r($myMessage); echo '</pre>';");
		untyped ('// [${TARGET}] simple untyped');
		#elseif java
		Sys.println('[${TARGET}]');
		// untyped __java__('// [java] comment');
		untyped ('// [${TARGET}] simple untyped');
		#elseif cs
		Sys.println('[${TARGET}]');
		untyped __cs__('// [cs] comment');
		untyped __cs__("// {0} is bool", myMessage);
		untyped ('// [${TARGET}] simple untyped');
		#elseif cpp
		Sys.println('[${TARGET}]');
		untyped __cpp__('// [cpp] comment');
		untyped ('// [${TARGET}] simple untyped');
		#elseif nodejs
		Sys.println('[${TARGET}]');
		untyped __js__('// [nodejs] comment');
		js.Node.console.log('js.Node.console.log');
		untyped ('// [${TARGET}] simple untyped');
		#elseif python
		// untyped __python__('# [python] comment');
		python.Syntax.code('# [python] comment');
		untyped ('# [python] comment');
		#elseif lua
		Sys.println('[${TARGET}]');
		untyped __lua__('-- [lua] comment');
		untyped ('// [${TARGET}] simple untyped');
		#elseif neko
		Sys.println('[${TARGET}]');
		// untyped __neko__('// [neko] comment');
		untyped ('// [${TARGET}] simple untyped');
		#elseif jvm
		Sys.println('[${TARGET}]');
		untyped __jvm__('// [jvm] comment');
		untyped ('// [${TARGET}] simple untyped');
		#else
		untyped ('// haxe lsss');
		#end
	}

	static public function main() {
		var app = new Main();
	}
}
