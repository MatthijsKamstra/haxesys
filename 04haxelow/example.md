# Example

Write to a simple json database...
Done in Haxe


## How to start

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


```
class Main {
	function new() {
		trace("Haxelow Example");

		// Create the database
		var db = new HaxeLow('db.json');

		// Get a collection of a class
		var persons = db.col(Person);

		// persons is now an Array<Person>
		// that can be manipulated as you like
		persons.push(new Person("Test", 50));

		// Save all collections to disk.
		// This is the only way to save, no automatic saving
		// takes place.
		db.save();

		// trace(Sys.programPath());
		// trace(Sys.getCwd());

		trace('open ${Sys.getCwd()}/db.json');
	}

	static public function main() {
		var main = new Main();
	}
}

class Person {
	public function new(name, age) {
		this.name = name;
		this.age = age;
	}

	public var name:String;
	public var age:Int;
}

```



## The Haxe build file, build.hxml

Normally you would have one `build.hxml` that would build everything you want to transpile to.
So you could build with one file many backends.

But not every feature works automaticly in all the languages and to prevent it from building I decided to have a little different structure.

Currently I use [`build.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/04haxelow/code/build.hxml) for vscode syntax checking:

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

To build all projects I use [`build_all.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/04haxelow/code/build_all.hxml) to build all other build files.

If a specific target doesn't work, I will explain it in this file


Check out this structure in the [`code`](https://github.com/MatthijsKamstra/haxesys/tree/master/04haxelow/code)-folder.



## Build all targets with Haxe and start the specific target

To finish and see what we have, build the file and see the result

1. Open your terminal
2. `cd ` to the correct folder where you have saved the `build_all.hxml`
3. type `haxe build_all.hxml`
4. press enter
