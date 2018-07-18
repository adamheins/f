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
    echo "Argument required. See f --help."
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
      echo "usage:"
      echo "  f ALIAS                Navigate to ALIAS."
      echo "  f -a, --add SRC ALIAS  Add a new ALIAS point to SRC."
      echo "  f -c, --clean          Remove all broken symlinks."
      echo "  f -d, --delete ALIAS   Remove ALIAS."
      echo "  f -h, --help           Print this help text."
      echo "  f -l, --list           List all current f aliases."
      echo "  f -p, --print ALIAS    Prints ALIAS's value to stdout."
      ;;
    "-a"|"--add")
      if [ -z $3 ]; then
        echo "usage: f $1 SRC ALIAS"
        return 1
      fi
      ln -s $(realpath "$2") "$f_alias_path"/"$3"
      ;;
    "-c"|"--clean")
      find $f_alias_path -xtype l -delete
      ;;
    "-d"|"--delete")
      if [ -z $2 ]; then
        echo "usage: f $1 ALIAS"
        return 1
      fi
      rm "$f_alias_path/$2"
      ;;
    "-p"|"--print")
      if [ -z $2 ]; then
        echo "usage: f $1 ALIAS"
        return 1
      fi
      readlink "$f_alias_path/$2"
      ;;
    "-l"|"--list")
      ls "$f_alias_path"/
      ;;
    *)
      local entry="$f_alias_path/$1"
      if [ -d $entry ]; then
        cd "$entry"
      elif [ -f "$entry" ]; then
        "$EDITOR" $(readlink "$entry")
      fi
      ;;
  esac

  return 0
}
