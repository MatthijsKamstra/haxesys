# Install Haxe

Before you can use there are a couple of thing you need to do.

Obviously you need to install Haxe. There are a [couple of ways to do it](../haxe/installation.md), but in this document I will send you to the [official Haxe place](#haxe).

After that you need to install `hxcs`-lib via [haxelib](#haxelib) and last but not least [.NET development framework (either Microsoft.NET or Mono)](#cs).

- Lua
- neko
- nodejs
- python
- cpp

And a [code editor](#ide) will be useful!

---

Current Haxe version is (at the time of writing):

- **Haxe** v4.1.4

But if the version numbers changed, it means I haven't updated this part of the document in some time :D

<a name="haxe"></a>

## Download Haxe

![](../img/haxe_logo.png)

- Get your version here: [http://haxe.org/download/](http://haxe.org/download/)

<a name="haxelib">
### Haxelib

After you have installed Haxe, you automatically have access to `haxelib`. Use that you install `hxcs`:

```bash
haxelib install hxcs
```

Source: <https://haxe.org/manual/target-cs-getting-started.html>

<a name="cs">
## Download .NET development framework

- Get your version here: <https://dotnet.microsoft.com/>

Press that big "Get started"-button and you will get instructions how to proceed on your platform.

<a name="mono">
## Mono

Perhaps needs to be installed as well? Could be installed with Unity?

Install the latest <a href="https://www.mono-project.com/download/stable/">Mono Compiler</a> <br/>

<a name="lua">
## Lua

I installed lua on osx with brew

```bash
brew install lua
brew install luarocks
```

And use `luarocks` to install dependency :

```bash
luarocks install lrexlib-pcre
luarocks install environ
luarocks install luasocket
luarocks install luv
```

_important to know which version you installed_

```
lua -v
```

(in my case: "Lua 5.3.5 Copyright (C) 1994-2018 Lua.org, PUC-Rio")

On Lua 5.1, install the bitops library:

```
luarocks install luabitop
```

On Lua 5.3, install the bit32 library instead:

```
luarocks install bit32
luarocks install luautf8
```

For Windows/Linux I would advice you follow the instructions:

- [Lua website](https://www.lua.org/start.html#installing)
- [Luarocks](https://github.com/luarocks/luarocks/wiki/Download)

<a name="ide"></a>

## Code Editors

You can find an extensive list on [http://haxe.org/](http://haxe.org/documentation/introduction/editors-and-ides.html).
And even a bigger list on the [old website](http://old.haxe.org/com/ide)...

(And I see no mentioning of Atom and Brackets.... even more choices)

**But to keep everything simple**

### On Windows

Install [FlashDevelop](http://www.flashdevelop.org/)

### On everything else

Install [Visual Studio Code](https://code.visualstudio.com/) with the [Haxe Extension Pack ](https://marketplace.visualstudio.com/items?itemName=vshaxe.haxe-extension-pack).

### Okay these two are also good for all platforms

Install [Sublimetext 2](http://sublimetext.com/) with the [haxe sublime2 bundle](https://github.com/clemos/haxe-sublime2-bundle).

It's freakish difficult to setup a project, but after that AWESOME!
[IntelliJ IDEA](http://www.jetbrains.com/idea/) with [Haxe support plugin](https://plugins.jetbrains.com/plugin/6873)

_Read more about code editors [here](../haxe/choosing-a-code-editor.md)_
