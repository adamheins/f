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
# Create shortcuts for your favourite directories, files, and git branches.
#
# Author: Adam Heins
# Last modified: 2015-10-26

f() {
  if [ -z "$1" ]; then
    echo "usage: f [-h] [alias]"
    return 1
  fi

  local f_alias_file line words f_alias f_path

  # Parse arguments.
  case "$1" in
    "--")
      [ -z "$2" ] && return 1
      f_alias="$2"
      ;;
    "-h"|"--help")
      echo -e "f is for favourite\nusage: f [-h] [alias]"
      return 0
      ;;
    *)
      f_alias="$1"
      ;;
  esac

  # Find f alias file to use.
  if [ -z "$F_ALIAS_FILE_PATH" ]; then
    if [ ! -f ~/.f ]; then
      echo "f: alias file not found"
      return 1
    fi
    f_alias_file=~/.f
  else
    if [ ! -f "$F_ALIAS_FILE_PATH" ]; then
      echo "f: \$F_ALIAS_FILE_PATH does not point to a file"
      return 1
    fi
    f_alias_file="$F_ALIAS_FILE_PATH"
  fi

  while read line || [[ -n "$line" ]]; do
    # Skip lines that begin with a '#'.
    [[ "${line:0:1}" == "#" ]] && continue

    words=(${(@s/ /)line})
    if [[ "${words[1]}" == "$f_alias" ]]; then
      f_path=${words[2]}
      f_path=${f_path:s/~/$HOME}
      break
    fi
  done < $f_alias_file

  if [ -z "$f_path" ]; then
    echo "f: no such alias '$f_alias'"
    return 1
  fi

  if [ -d "$f_path" ]; then
    cd $f_path
  elif [ -f "$f_path" ]; then
    if [ ! -z "$VISUAL" ]; then
      "$VISUAL" "$f_path"
    elif [ ! -z "$EDITOR" ]; then
      "$EDITOR" $f_path
    else
      echo "f: no editor set"
      return 1
    fi
  elif [ "$(git branch --list $f_path 2>/dev/null)" ]; then
    git checkout "$f_path"
  else
    echo "f: alias does not point to a file, directory, or git branch"
    return 1
  fi
  return 0
}
