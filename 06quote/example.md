# Example Quote

I run into some problems here.
For most sys targets a `https` call works, but not for the C# target.

When I was looking for a solution closer to C# I ran into problems that had to do with the .NET lib you need to install.
Hmmm, and that was the moment that I was no longer looking

There is a solution, but I am not the person to fix it.

To make this example working, I choose a api that doesn't need Authentication and `http`... (again `https` doesn't work)

In this case we will use: <http://forismatic.com/en/api/> an api that hands out quotes.

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
Check the complete [Main.hx](https://github.com/MatthijsKamstra/haxeunity/tree/master/06quote_haxe/code/src/Main.hx).

This is the most interesting part:

```
var req = new haxe.Http('http://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en');

req.onData = function(data:String) {
	try {
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

```





## The Haxe build file, build.hxml

Normally you would have one `build.hxml` that would build everything you want to transpile to.
So you could build with one file many backends.

But not every feature works automaticly in all the languages and to prevent it from building I decided to have a little different structure.

Currently I use [`build.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/06quote/code/build.hxml) for vscode syntax checking:

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

To build all projects I use [`build_all.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/06quote/code/build_all.hxml) to build all other build files.

If a specific target doesn't work, I will explain it in this file


Check out this structure in the [`code`](https://github.com/MatthijsKamstra/haxesys/tree/master/06quote/code)-folder.



## Build all targets with Haxe and start the specific target

To finish and see what we have, build the file and see the result

1. Open your terminal
2. `cd ` to the correct folder where you have saved the `build_all.hxml`
3. type `haxe build_all.hxml`
4. press enter



