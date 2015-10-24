# Author: Adam Heins
# Last modified: 2015-10-23

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

    words=($line)
    if [[ "${words[0]}" == "$1" ]]; then
      f_path=${words[1]}
      f_path=${f_path/#\~/$HOME}
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
  else
    echo "f: alias does not point to a file or directory"
    return 1
  fi
  return 0
}
