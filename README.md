# f is for favourite
f is a simple command line utility for aliasing your favourite directories.

## Usage
You simply type `f` and then your directory alias. For example,
```bash
f t
```
will change your directory to the one aliased by `t`.

Directory aliases are defined in an alias file. By default, this is `~/.f`, but
you can change this by setting the `$F_PATH` environment variable to point to
another file. The alias file simply consists of lines of <alias> <path> pairs,
where <alias> and <path> are separated by a space. Alias files may contain
comments, which are lines whose first character is a `#`.

An simple alias file may look something like the following:
```
# My example alias commands:
w    ~/work
doc  ~/Documents
brew /usr/local/Cellar
```

## Installation
You simply need to arrange for the f script appropriate for your shell is
sourced, and that a `~/.f` or another alias file pointed to by `$F_PATH` exists.

For quick installation, do the following:
```bash
git clone git@github.com:adamheins/f ~/.fav
./fav/setup
```

## License
MIT license. See the LICENSE file for details.
