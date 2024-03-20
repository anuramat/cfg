#!/usr/bin/env bash
. ./home/.profile
set -e

ensure_path() {
	# $1 -- target path
	local -r target="$1"

	[ -d "$target" ] && return
	mkdir -p "$target" || {
		echo "[cfg.fail] create path \"$target\""
		return 1
	}
	echo "[cfg.write] created path \"$1\""
}

make_symlink() {
	# $1 -- source file
	# $2 -- target file/directory
	local -r original="$(realpath "$1")"
	local target="$2"

	[ -d "$target" ] && target="$target/$(basename "$original")"
	ln -sf "$original" "$target" || {
		echo "[cfg.fail] make symlink @ \"$target\""
		return 1
	}
	echo "[cfg.write] created symlink @ \"$target\""
}

install2folder() {
	local -r original="$(realpath "$1")"
	local -r target_dir="$2"

	[ -e "$1" ] || {
		echo "[cfg.fail] file \"$1\" not found!"
		return 1
	}

	ensure_path "$target_dir" || return 1
	install2file "$original" "$target_dir"
}

install2file() {
	# $1 -- source file
	# $2 -- target file
	local -r original="$(realpath "$1")"
	local -r target="$2"
	local -r target_dir="$(dirname "$2")"

	git check-ignore "$original" >/dev/null 2>&1 && {
		return
	}

	[ -e "$1" ] || {
		echo "[cfg.fail] file \"$1\" not found!"
		return 1
	}

	ensure_path "$target_dir" || return 1
	make_symlink "$original" "$target" || return 1
}

install_all() {
	echo '[cfg] installing $HOME'
	shopt -s dotglob
	for __dotfile in home/*; do
		install2folder "$__dotfile" "$HOME"
	done
	echo '[cfg] installing $XDG_CONFIG_HOME'
	for __folder in config/*; do
		install2folder "$__folder" "$XDG_CONFIG_HOME"
	done
	shopt -u dotglob

	echo "[cfg] creating directories"
	# TODO move all of this to configuration.nix or home manager
	touch "$HOME/.hushlogin"
	ensure_path "$HOME/screenshots"
	# TODO maybe ensure path for all xdg paths
}
