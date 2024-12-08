#!/usr/bin/env bash

linenr() {
  num=$1

  len=$(wc -l "$TODO_FILE" | cut -d ' ' -f 1)
  [ -z "$num" ] && num="$len"
  [[ $num =~ ^[1-9][0-9]*$ ]] || exit 1
  ((num > len)) && exit 1

  echo "$num"
}
