#!/usr/bin/env bash

function ensure_path {
  # $1 -- target path
  local -r target="$1"

  # check if path already exists
  [ -d "$target" ] && return

  # try creating
  if ! mkdir -p "$target"; then
    echo "[cfg.fail] create path \"$target\""
    return 1
  fi
  echo "[cfg.write] created path \"$1\""
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
  if ! echo "$string" >>"$target"; then
    echo "[cfg.fail] append string \"$string\" to $target"
    return 1
  fi
  echo "[cfg.write] appended \"$string\" to $target"
}

function make_symlink {
  # $1 -- source file
  # $2 -- target file/directory
  local -r original="$(realpath "$1")"
  local target="$2"

  if [ -d "$target" ]; then
    target="$target/$(basename $original)"
  fi

  # check if already exists
  if [ -e "$target" ]; then
    try_overwrite "$target" || return 1
  fi

  # try linking
  if ! ln -sf "$original" "$target"; then
    echo "[cfg.fail] make symlink @ \"$target\""
    return 1
  fi
  echo "[cfg.write] created symlink @ \"$target\""
}

function install2folder {
  # $1..n-1 -- source files
  # $n -- target directory
  local original
  local -r target_dir="${@:$#}"

  for ((i = 1; i < $#; i++)); do
    original="$(realpath "${!i}")"

    ensure_path "$target_dir" || return 1
    install2file "$original" "$target_dir"
  done
}

function install2file {
  # $1 -- source file
  # $2 -- target file
  local -r original="$(realpath "$1")"
  local -r target=$2
  local -r target_dir="$(dirname "$2")"

  if ! [ -e "$original" ]; then
    echo "[cfg.fail] file \"$original\" not found!"
    return 1
  fi

  ensure_path "$target_dir" || return 1
  make_symlink "$original" "$target" || return 1
}

function set_shell {
  shell="$1"

  [ "$SHELL" = "$shell" ] && return

  if ! [ -f "$shell" ]; then
    echo "[cfg.fail] \"$shell\" not found"
    return 1
  fi

  # add to shells
  sudo bash -c "$(declare -f ensure_path); $(declare -f ensure_string); ensure_string \"$shell\" /etc/shells"

  # make the default shell
  chsh -s "$shell"
}

function continue_prompt {
  local -r prompt="$1"
  while true; do
    read -rp "$prompt" choice
    case "$choice" in
    y | Y)
      return 0
      ;;
    *)
      return 1
      ;;
    esac
  done
}

function try_overwrite {
  # $1 -- target
  local -r target="$1"
  continue_prompt "Overwrite $target (y/n): " || return 1
  rm "$target" || return 1
}
