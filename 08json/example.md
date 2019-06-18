# Example json

I have created the [user.json](https://github.com/MatthijsKamstra/haxeunity/tree/master/08json/code/bin/www/assets/users.json) with <http://jsonplaceholder.typicode.com/users>.


Check the [code folder](https://github.com/MatthijsKamstra/haxeunity/tree/master/08json/code) for more comments.

In this example we are going to read and use a `.json` file.



## How to start

Create a folder named **foobar** (please use a better name; any name will do) and create folders **assets** and **src**.
See example below:

```
+ foobar
	+ assets
		- users.json
	+ bin
	+ src
		- Main.hx
	- build.hxml
```



## The Main.hx

This example is getting to big to post here, so if you want to check out the complete file go and check out [Main.hx](https://github.com/MatthijsKamstra/haxeunity/tree/master/08json/code/src/Main.hx)

So the first part of this code is loading the `json` file:

```
var path = Path.normalize(Sys.getCwd().split('bin/')[0] + '/assets/users.json');

if(sys.FileSystem.exists(path)){
	var str : String = sys.io.File.getContent(path);
} else {
	trace ('ERROR: there is not file: $path');
}
```

convert data (String) to a `json` file:
<http://api.haxe.org/haxe/Json.html>

```haxe
	// trace('str: $str');
	json = haxe.Json.parse(str);
```

And then it's possible to convert the `json` to usable input:

```haxe
for (i in 0 ... json.length)
{
	var _user = json[i];
	trace ( "Name: " + _user.name );
}

```

To make that easier I use [`typedef`](http://haxe.org/manual/type-system-typedef.html)

We convert the json data to `User` so when we use a IDE it will use autocompletion

```haxe
typedef User =
{
	var id : Int; // 1
	var name : String; // Leanne Graham
	var username : String; // Bret
	var email : String; // Sincere@april.biz
	var address : {
	  	var street : String; // Kulas Light
	  	var suite : String; // Apt. 556
	  	var city : String; // Gwenborough
	  	var zipcode : String; // 92998-3874
	  	var geo : {
	    	var lat : String; // -37.3159
	    	var lng : String; // 81.1496
	      };
	};
	var phone : String; // 1-770-736-8031 x56442
	var website : String; // hildegard.org
	var company : {
	  	var name : String; // Romaguera-Crona
	  	var catchPhrase : String; // Multi-layered client-server neural-net
	  	var bs : String; // harness real-time e-markets
    };
}

```



## The Haxe build file, build.hxml

Normally you would have one `build.hxml` that would build everything you want to transpile to.
So you could build with one file many backends.

But not every feature works automaticly in all the languages and to prevent it from building I decided to have a little different structure.

Currently I use [`build.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/08json/code/build.hxml) for vscode syntax checking:

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

To build all projects I use [`build_all.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/08json/code/build_all.hxml) to build all other build files.

If a specific target doesn't work, I will explain it in this file


Check out this structure in the [`code`](https://github.com/MatthijsKamstra/haxesys/tree/master/08json/code)-folder.



## Build all targets with Haxe and start the specific target

To finish and see what we have, build the file and see the result

1. Open your terminal
2. `cd ` to the correct folder where you have saved the `build_all.hxml`
3. type `haxe build_all.hxml`
4. press enter



