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

F_ALIAS_DEFAULT_PATH=~/.f

_do_in_dir_and_return() {
  local cur_dir=$(pwd)
  cd "$1"
  "${@:2}"
  cd "$cur_dir"
}

f() {
  if [ -z "$1" ]; then
    echo "usage: f [-h] [-b] [-c] [alias]"
    return 1
  elif [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    echo "f is for favourite"
    echo "usage: f [-h] [-b] [-c] [alias]"
    echo ""
    echo "arguments:"
    echo "  -i, --init        Initialize the f alias directory."
    echo "  -b, --branch      Call git branch on the f alias directory."
    echo "  -c, --checkout    Call git checkout on the f alias directory."
    return 0
  fi

  local f_alias_path line words f_alias f_path alias_file

  # Find f alias directory to use.
  if [ -z "$F_ALIAS_PATH" ]; then
    f_alias_path="$F_ALIAS_DEFAULT_PATH"
  else
    f_alias_path="$F_ALIAS_PATH"
  fi

  # Check if the alias directory actually exists.
  # If it doesn't exist and --init wasn't passed, fail.
  if [ ! -d "$f_alias_path" ]; then
    if [[ "$1" == "-i" ]] || [[ "$1" == "--init" ]]; then
      mkdir -p "$f_alias_path"
      local cur_dir=$(pwd)
      cd "$f_alias_path"
      git init
      echo "f $f_alias_path" > "$f_alias_path/aliases"
      git add .
      git commit -m "Initial commit."
      cd "$cur_dir"
      return
    else
      echo "f: alias directory not found"
      return 1
    fi
  fi

  case "$1" in
    "--")
      [ -z "$2" ] && return 1
      f_alias="$2"
      ;;
    "-c"|"--checkout")
      [ ! -d "$f_alias_path" ]
      _do_in_dir_and_return "$f_alias_path" git checkout "${@:2}"
      return
      ;;
    "-b"|"--branch")
      _do_in_dir_and_return "$f_alias_path" git branch "${@:2}"
      return
      ;;
    *)
      f_alias="$1"
      ;;
  esac

  # Check if the alias directory actually exists.
  if [ ! -d "$f_alias_path" ]; then
    echo "f: alias directory not found"
    return 1
  fi

  # All files in the f alias directory are search for aliases.
  for alias_file in "$f_alias_path"/*; do
    while read line || [[ -n "$line" ]]; do
      # Skip lines that begin with a '#'.
      [[ "${line:0:1}" == "#" ]] && continue

      words=(${(@s/ /)line})
      if [[ "${words[1]}" == "$f_alias" ]]; then
        f_path=${words[2]}
        f_path=${f_path:s/~/$HOME}
        break
      fi
    done < "$alias_file"
  done

  if [ -z "$f_path" ]; then
    echo "f: no such alias '$f_alias'"
    return 1
  elif [ -d "$f_path" ]; then
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
