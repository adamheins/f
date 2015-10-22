#!/bin/zsh

# Author: Adam Heins
# Date: 2015-10-21

f() {
  if [ -z "$1" ]; then
    echo "usage: f <alias>"
    return 1
  fi

  local file line words dir
  if [ -z "$F_PATH" ]; then
    file=~/.f
  else
    file=$F_PATH
  fi

  while read line || [[ -n "$line" ]]; do
    # Skip lines that begin with a '#'.
    if [[ "${line:0:1}" == "#" ]]; then
      continue
    fi

    words=(${(@s/ /)line})
    if [[ "${words[1]}" == "$1" ]]; then
      dir=${words[2]}
      cd ${dir:s/~/$HOME}
      return
    fi
  done < $file
  return 1
}
