# Example CLI - ProgressBar


This is really silly, but a lot of fun to figure out.

I wanted to have a progressBar in my cli, and you can for most languages.


I say most, but not everything works like I would expect and I haven't fixed it for the languages.

You want to know more about the languages that currently don't work (or don't work properly) check out the [`build_all.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/14cli_progress/code/build_all.hxml)


For now node.js fails: ` Error: ENOTSUP: operation not supported on socket, fsync` which is weird... why do I need a socket (need to investigate)
Python works, but not like the other targets: the string is prepent to the cli and thus becomes really long (and doesn't work anymore) + the fill is not known in Python (might be fixed in Haxe4)
Lua works, but never shows an update. It waits and only shows the 100% bar.


Check the [code folder](https://github.com/MatthijsKamstra/haxesys/tree/master/14cli_progress/code) for more comments.






## How to start

Create a folder named **foobar** (please use a better name; any name will do) and create folders **assets** and **src**.
See example below:

```
+ foobar
	+ bin
	+ src
		- Main.hx
	- build.hxml
```



## The Main.hx

You probably can figure out how it would work so check out [Main.hx](https://github.com/MatthijsKamstra/haxesys/tree/master/14cli_progress/code/src/Main.hx)

The progressBar expects two values: the current value (an `Int`) and the total (also an `Int`)

```haxe

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
```

To start showing this progessBar I use this code, which has not value besides showing how the progressbar looks.

```haxe
	var total = 50;
	var current = 0;
	for(i in 0...total){
		Sys.sleep(0.1);
		current++;
		progressBar(current,total);
	}

```




## The Haxe build file, build.hxml

Normally you would have one `build.hxml` that would build everything you want to transpile to.
So you could build with one file many backends.

But not every feature works automaticly in all the languages and to prevent it from building I decided to have a little different structure.

Currently I use [`build.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/14cli_progress/code/build.hxml) for vscode syntax checking:

```bash
-lib markdown
-cp src
-D analyzer-optimize
-main Main
--interp
```

And have individual build files for the different targets:

- build_cpp.hxml
- build_cs.hxml
- build_java.hxml
- build_lua.hxml
- build_neko.hxml
- build_node.hxml
- build_python.hxml

To build all projects I use [`build_all.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/14cli_progress/code/build_all.hxml) to build all other build files.

If a specific target doesn't work, I will explain it in this file


Check out this structure in the [`/code`](https://github.com/MatthijsKamstra/haxesys/tree/master/14cli_progress/code)-folder.



## Build all targets with Haxe and start the specific target

To finish and see what we have, build the file and see the result

1. Open your terminal
2. `cd ` to the correct folder where you have saved the `build_all.hxml`
3. type `haxe build_all.hxml`
4. press enter



