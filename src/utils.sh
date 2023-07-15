#!/usr/bin/env bash

function ensure_path {
  # $1 -- target path
  local -r target="$1"

  # check if path already exists
  [ -d "$target" ] && return

  # try creating
  if ! mkdir -p "$target"; then
    echo "cfg.fail: create path $target"
    return 1
  fi
  echo "cfg.write: created path $1"
}

function ensure_string {
  # $1 -- string
  # $2 -- target file
  local -r string="$1"
  local -r target="$2"

  # check if already there
  grep -Fq "$string" "$target" && return

  # try appending
  ensure_path "$(dirname "$target")" || return 1
  echo "$target"
  if ! echo "$string" >>"$target"; then
    echo "cfg.fail: append string {{{$string}}} to $target"
    return 1
  fi
  echo "cfg.write: appended {{{$string}}} to $target"
}

function make_symlink {
  # $1 -- source file
  # $2 -- target directory
  local -r original="$(realpath "$1")"
  local -r target="$2/$(basename "$1")"

  # check if already linked
  test -L "$target" && return

  # or already exists
  if test -e "$target"; then
    echo "cfg.fail: non-symlink file already exists @ $target"
    return 1
  fi

  # try linking
  if ! ln -s "$original" "$target"; then
    echo "cfg.fail: make symlink @ $target"
    return 1
  fi
  echo "cfg.write: created symlink @ $target"
}

function install_files {
  # $1..n-1 -- source files
  # $n -- target directory
  local original
  local -r target_dir="${@:$#}"

  for ((i = 1; i < $#; i++)); do
    original="$(realpath "${!i}")"

    if ! test -e "$original"; then
      echo "cfg.fail: file \"$original\" not found!"
      return 1
    fi

    ensure_path "$target_dir" || return 1
    make_symlink "$original" "$target_dir" || return 1
  done
}

function set_shell {
  shell="$1"

  [ "$SHELL" = "$shell" ] && return

  if ! [ -f "$shell" ]; then
    echo "cfg.fail: $shell not found"
    return 1
  fi

  # add to shells
  sudo bash -c "$(declare -f ensure_path); $(declare -f ensure_string); ensure_string \"$shell\" /etc/shells"

  # make the default shell
  chsh -s "$shell"
}
