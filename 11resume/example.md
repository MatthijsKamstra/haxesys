# Example resume.json

I have created [resume.json](https://github.com/MatthijsKamstra/haxesys/tree/master/11resume/code/assets/resume.json) via the npm from <https://jsonresume.org/>

```
npm install -g resume-cli
```

And created a "empty" resume.json

```
resume init
```


Check the [code folder](https://github.com/MatthijsKamstra/haxesys/tree/master/11resume/code) for more comments.

In this example we are going to read and use a `.json` file.
We will convert the json to `.md`, `.txt` and some basic `.html`


## How to start

Create a folder named **foobar** (please use a better name; any name will do) and create folders **assets** and **src**.
See example below:

```
+ foobar
	+ assets
		- resume.json
	+ bin
	+ src
		- Main.hx
	- build.hxml
```



## The Main.hx

This example is getting to big to post here, so if you want to check out the complete file go and check out [Main.hx](https://github.com/MatthijsKamstra/haxesys/tree/master/11resume/code/src/Main.hx)

So the first part of this code is loading the `json` file:

```
var path = Path.normalize(ASSETS + '/resume.json');

if (sys.FileSystem.exists(path)) {
	var str:String = sys.io.File.getContent(path);
	json = haxe.Json.parse(str);
	trace("json.basics.name: " + json.basics.name);
	writeAll();
} else {
	trace('ERROR: there is no spoon: $path');
}
```

convert data (String) to a `json` file:
<http://api.haxe.org/haxe/Json.html>

```haxe
var json:ResumeObjObj = haxe.Json.parse(str);
```

To make that easier I use [`typedef`](http://haxe.org/manual/type-system-typedef.html)

We convert the json data to `ResumeObjObj` so when we use a IDE it will use autocompletion

Check out [AST.hx](https://github.com/MatthijsKamstra/haxesys/tree/master/11resume/code/src/AST.hx), it's too big to show it all here.

But the "toplevel" you can see the basic structure of resume.json

```haxe
typedef ResumeObjObj = {
	var education:Array<Education>;
	var work:Array<Work>;
	var basics:Basics;
	var languages:Array<Languages>;
	var skills:Array<Skills>;
	var volunteer:Array<Volunteer>;
	var awards:Array<Awards>;
	var references:Array<References>;
	var publications:Array<Publications>;
	var interests:Array<Interests>;
};
```



## The Haxe build file, build.hxml

Normally you would have one `build.hxml` that would build everything you want to transpile to.
So you could build with one file many backends.

But not every feature works automaticly in all the languages and to prevent it from building I decided to have a little different structure.

Currently I use [`build.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/11resume/code/build.hxml) for vscode syntax checking:

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

To build all projects I use [`build_all.hxml`](https://github.com/MatthijsKamstra/haxesys/tree/master/11resume/code/build_all.hxml) to build all other build files.

If a specific target doesn't work, I will explain it in this file


Check out this structure in the [`code`](https://github.com/MatthijsKamstra/haxesys/tree/master/11resume/code)-folder.



## Build all targets with Haxe and start the specific target

To finish and see what we have, build the file and see the result

1. Open your terminal
2. `cd ` to the correct folder where you have saved the `build_all.hxml`
3. type `haxe build_all.hxml`
4. press enter

