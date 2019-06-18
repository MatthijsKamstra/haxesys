# Example CLI/command


Check the [code folder](https://github.com/MatthijsKamstra/haxesys/tree/master/13terminal/code) for more comments.




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

```haxe
// create a file
Sys.command('touch', ['readme.md']);
```

Creates a file with the name "readme.md"


```haxe
// print a message on the screen
Sys.println("lets see if you have ffmpeg installed");
var p:Process = new Process('ffmpeg', ['-version']);
var out = p.stdout.readAll().toString();
p.close();

if(out.indexOf('ffmpeg version') != -1){
	trace('You have ffmpeg installed!');
} else {
	trace('Visit ffmpeg.org to install!');
}

```

sort of trying to read if you have ffmpeg installed via `ffmpeg -version` asking the version of the installed programm


## The Haxe build file, build.hxml

Normally you would have one `build.hxml` that would build everything you want to transpile to.
So you could build with one file many backends.

But not every feature works automaticly in all the languages and to prevent it from building I decided to have a little different structure.

Currently I use [`build.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/13terminal/code/build.hxml) for vscode syntax checking:

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

To build all projects I use [`build_all.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/13terminal/code/build_all.hxml) to build all other build files.

If a specific target doesn't work, I will explain it in this file


Check out this structure in the [`code`](https://github.com/MatthijsKamstra/haxesys/tree/master/13terminal/code)-folder.



## Build all targets with Haxe and start the specific target

To finish and see what we have, build the file and see the result

1. Open your terminal
2. `cd ` to the correct folder where you have saved the `build_all.hxml`
3. type `haxe build_all.hxml`
4. press enter



