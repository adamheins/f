```
   ffffffffffffffff
  f::::::::::::::::f
 f::::::::::::::::::f
 f::::::fffffff:::::f
 f:::::f       ffffff
 f:::::f
f:::::::ffffff
f::::::::::::f
f::::::::::::f
f:::::::ffffff
 f:::::f
 f:::::f            __               __                               _
f:::::::f (_)___   / _| ___  _ __   / _| __ ___   _____  _   _ _ __(_) |_ ___
f:::::::f | / __| | |_ / _ \| '__| | |_ / _` \ \ / / _ \| | | | '__| | __/ _ \
f:::::::f | \__ \ |  _| (_) | |    |  _| (_| |\ V / (_) | |_| | |  | | ||  __/
fffffffff |_|___/ |_|  \___/|_|    |_|  \__,_| \_/ \___/ \__,_|_|  |_|\__\___|
```
f is a simple command line utility for aliasing your favourite files,
and directories.

## Usage
You simply type `f` and then your file, directory, or branch alias. For
example,
```bash
f t
```
will change your current working directory to the one aliased by `t`, or, if
`t` was an alias for a file, it will open that file in the program specified by
`$EDITOR`.

Aliases are simply symlinks inside of an alias directory. By default, the
alias directory is `~/.f`, but you can change this by setting the
`$F_ALIAS_PATH` environment variable to point to another directory.

Full usage:
```
f ALIAS                Navigate to ALIAS.
f -a, --add SRC ALIAS  Add a new alias.
f -h, --help           Print this help text.
f -l, --list           List all current f aliases.
f -p, --print ALIAS    Prints an alias's value to stdout.
```

## Installation
Clone this repo and arrange for `f.sh` to be sourced. For tab completion in
zsh, put `_f` on your `$fpath`. Bash completion is not supported at this time.

## Advantages over plain shell aliases
Why not just alias all of your common directories, files, and git branches
directly in shell? Well, you could do that, but here are a few advantages of
using f instead:
1. f is effectively a namespace. f aliases won't conflict with other aliases,
   shell functions, or binaries on your `$PATH`.
2. f automatically knows what to do with each alias, be it a file or directory.
   This allows you to just specify a name/path, rather than the command as
   well.

## License
MIT license. See the LICENSE file for details.
