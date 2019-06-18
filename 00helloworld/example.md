# Hello World Example

Create a folder named **foobar** (please use a better name; any name will do) and create folders **bin** and **src**.
See example below:

```
+ foobar
	+ bin
	+ src
		- Main.hx
	- build.hxml
```


## The Main.hx

Open your favorite editor, copy/paste the code and save it in the `src` folder.

```haxe
package;

class Main
{
	// constructor
	function new() {
		trace("Hello world");
	}

	// run code automatically
	static public function main() {
		var main = new Main();
	}
}
```

Below you can see and try the same example code at [try.haxe.org](https://try.haxe.org/) without installing Haxe.

<iframe src="https://try.haxe.org/embed/80cf4" width="100%" height="300" frameborder="no" allowfullscreen>
	<a href="https://try.haxe.org/#80cf4">Try Haxe !</a>
</iframe>

You could create an even shorter "hello world" example:

<iframe src="https://try.haxe.org/embed/197E1" width="100%" height="300" frameborder="no" allowfullscreen>
	<a href="https://try.haxe.org/#197E1">Try Haxe !</a>
</iframe>

But I think it's a good idea to use the static main function only to start the constructor
```haxe
static public function main() {var main = new Main(); }
```

> If you want certain code to run automatically, you need to put it in a static main function, and specify the class in the compiler arguments.



## The Haxe build file, build.hxml

Normally you would have one `build.hxml` that would build everything you want to transpile to.
So you could build with one file many backends.

But not every feature works automaticly in all the languages and to prevent it from building I decided to have a little different structure.

Currently I use [`build.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/00helloworld/code/build.hxml) for vscode syntax checking:

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

To build all projects I use [`build_all.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/00helloworld/code/build_all.hxml) to build all other build files.

If a specific target doesn't work, I will explain it in this file


Check out this structure in the [`code`](https://github.com/MatthijsKamstra/haxesys/tree/master/00helloworld/code)-folder.



## Build all targets with Haxe and start the specific target

To finish and see what we have, build the file and see the result

1. Open your terminal
2. `cd ` to the correct folder where you have saved the `build_all.hxml`
3. type `haxe build_all.hxml`
4. press enter
