# Example CLI


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

This example is getting to big to post here, so if you want to check out the complete file go and check out [Main.hx](https://github.com/MatthijsKamstra/haxesys/tree/master/13terminal/code/src/Main.hx)


But I want to show you how it works in this simple example:

```haxe

class Main {
	public function new(?args:Array<String>) {
		trace(args);
		if (args.length == 0)
			return;
		for (i in 0...args.length) {
			var temp = args[i];
			trace(temp);
		}
	}

	static public function main() {
		var app = new Main(Sys.args());
	}
}
```
As you can see the static starting point of the class sends the `Sys.args` to the constructor.

This way you can add vars to the CLI (I am using Neko as example):

```bash
neko main -out -v -z
```

It will send the `args` : `-out`, '-v', '-z' that you can catch with a switch

```haxe
for (i in 0...args.length) {
	var temp = args[i];
	switch (temp) {
		case '-v', '-version': trace('version');
		case '-z', '-zoooo': trace('zooooo');
		case '-out': trace('out');
		default:
			trace("case '" + temp + "': trace ('" + temp + "');");
	}
}
```

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

