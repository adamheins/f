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
directories, and git branches.

## Usage
You simply type `f` and then your file, directory, or branch alias. For
example,
```bash
f t
```
will change your current working directory to the one aliased by `t`, or, if
`t` was an alias for a file, it will open that file in the program specified by
`$VISUAL`. Alternatively, if t is an alias for a git branch, f will checkout
that git branch if you are in a git repository and a branch of that name
exists.

Aliases are defined in files inside of an alias directory. By default, the
alias directory is `~/.f`, but you can change this by setting the
`$F_ALIAS_PATH` environment variable to point to another directory. f will
search for aliases in each file within the alias directory.

An alias file simply consists of lines of <alias> <value> pairs, where <alias>
and <value> are separated by a space. <value> can either be an absolute path to
a directory or file, or the name of a git branch. Alias files may contain
comments, which are lines whose first character is a `#`.

An simple alias file may look something like the following:
```
# Example directory aliases.
w    ~/work
doc  ~/Documents
brew /usr/local/Cellar

# Example file aliases.
v ~/.vimrc
z ~/.zshrc

# Example git branch aliases.
m master
```

## Installation
You simply need to arrange for the f script appropriate for your shell is
sourced, and then run `f --init`.

For quick installation, run the following in your terminal:
```bash
git clone git@github.com:adamheins/f ~/.f-source
~/.f-source/install
```

## License
MIT license. See the LICENSE file for details.
