#    ffffffffffffffff
#   f::::::::::::::::f
#  f::::::::::::::::::f
#  f::::::fffffff:::::f
#  f:::::f       ffffff
#  f:::::f
# f:::::::ffffff
# f::::::::::::f
# f::::::::::::f
# f:::::::ffffff
#  f:::::f
#  f:::::f            __               __                               _
# f:::::::f (_)___   / _| ___  _ __   / _| __ ___   _____  _   _ _ __(_) |_ ___
# f:::::::f | / __| | |_ / _ \| '__| | |_ / _` \ \ / / _ \| | | | '__| | __/ _ \
# f:::::::f | \__ \ |  _| (_) | |    |  _| (_| |\ V / (_) | |_| | |  | | ||  __/
# fffffffff |_|___/ |_|  \___/|_|    |_|  \__,_| \_/ \___/ \__,_|_|  |_|\__\___|
#
# Create shortcuts for your favourite directories and files.

F_ALIAS_DEFAULT_PATH=~/.f

f() {
  if [ -z "$1" ]; then
    echo "usage: f [-ahlp] [args] [alias]"
    return 1
  fi

  local f_alias_path

  # Find f alias directory to use.
  if [ -z "$F_ALIAS_PATH" ]; then
    f_alias_path="$F_ALIAS_DEFAULT_PATH"
  else
    f_alias_path="$F_ALIAS_PATH"
  fi

  # Create the directory if it doesn't exist.
  if [ ! -d "$f_alias_path" ]; then
    mkdir "$f_alias_path"
  fi

  case "$1" in
    "-h"|"--help")
      echo "f is for favourite"
      echo "usage: f [-ahlp] [args] [alias]"
      echo ""
      echo "arguments:"
      echo "  -a, --add SRC ALIAS    Add a new alias."
      echo "  -h, --help             Print this help text."
      echo "  -l, --list             List all current f aliases."
      echo "  -p, --print ALIAS      Prints an alias's value to stdout."
      ;;
    "-a"|"--add")
      if [ -z $3 ]; then
        echo "usage: f $1 SRC ALIAS"
        return 1
      fi
      ln -s $(realpath "$2") "$f_alias_path"/"$3"
      ;;
    "-p"|"--print")
      if [ -z $2 ]; then
        echo "usage: f $1 ALIAS"
      fi
      readlink "$f_alias_path"/"$2"
      ;;
    "-l"|"--list")
      ls "$f_alias_path"/
      ;;
    *)
      local entry=$(readlink "$f_alias_path"/"$1")
      if [ -d $entry ]; then
        cd $entry
      else
        "$EDITOR" $entry
      fi
      ;;
  esac

  return 0
}
