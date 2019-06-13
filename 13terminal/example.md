# Example CLI/command


Check the [code folder](/code) for more comments.




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

I use one [`build.hxml`](/code/build.hxml) to build all other build files:

- build_cpp.hxml
- build_cs.hxml
- build_java.hxml
- build_node.hxml
- build_python.hxml

Check out the files in the [`/code`](/code)-folder.



## Build all targets with Haxe and start the specific target

To finish and see what we have, build the file and see the result

1. Open your terminal
2. `cd ` to the correct folder where you have saved the `build.hxml`
3. type `haxe build.hxml`
4. press enter



