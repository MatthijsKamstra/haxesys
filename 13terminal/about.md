# About Terminal

Nice thing about the system targets is that it's connected to the computer and so you can do stuff that the computer does as well.

You can start [ffmpeg](https://ffmpeg.org/) if it's installed on your computer.

Example code:

```bash
ffmpeg -i input.mp4 output.avi
```


So your program could generate a sequence images, that you could convert to a `.mp4` and convert that to a `.avi`.

## CLI

CLI = Command Line Interface

Old skool way to access your computer.
Usually via terminal.

Because you need to have access to the computer it will only work on the system targets

Just a short reminder:

- cpp (C++)
- cs (C#)
- node.js (without installing npm packages)
- python
- java
- neko
- lua




## haxe documentation



> Run the given command. The command output will be printed on the same output as the current process. The current process will block until the command terminates and it will return the command result (0 if there was no error).
>
> Command arguments can be passed in two ways: 1. using args, 2. appending to cmd and leaving args as null.
>
> When using args to pass command arguments, each argument will be automatically quoted, and shell meta-characters will be escaped if needed. cmd should be an executable name that can be located in the PATH environment variable, or a path to an executable.
>
> When args is not given or is null, command arguments can be appended to cmd. No automatic quoting/escaping will be performed. cmd should be formatted exactly as it would be when typed at the command line. It can run executables, as well as shell commands that are not executables (e.g. on Windows: dir, cd, echo etc).
>
> Read the [sys.io.Process](https://api.haxe.org/sys/io/Process.html) api for a more complete way to start background processes.

- <https://api.haxe.org/sys/io/Process.html>
- <https://api.haxe.org/Sys.html#command>
- <https://guide.freecodecamp.org/bash>




