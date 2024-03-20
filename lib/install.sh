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

# git check-ignore "$original" >/dev/null 2>&1 && {
# 	return
# }

install_file() {
	# $1 -- original file
	# $2 -- destination directory
	local -r file="$(realpath "$1")"
	local -r destination="$(realpath "$2")"
	# check if file exists
	[ -e "$file" ] || {
		echo "[cfg.fail] file \"$destination\" not found!"
		return 1
	}
	# make sure destination exists
	ensure_path "$destination" || return 1
	# make a symlink
	ln -sft "$destination" "$file" || {
		echo "[cfg.fail] make symlink @ \"$destination\""
		return 1
	}
}

install_all() {
	echo '[cfg] installing $HOME'
	shopt -s dotglob
	for __dotfile in home/*; do
		install_file "$__dotfile" "$HOME"
	done
	echo '[cfg] installing $XDG_CONFIG_HOME'
	for __folder in config/*; do
		install_file "$__folder" "$XDG_CONFIG_HOME"
	done
	shopt -u dotglob

	echo "[cfg] creating directories"
	# TODO move all of this to configuration.nix or home manager
	touch "$HOME/.hushlogin"
	ensure_path "$HOME/screenshots"
	# TODO maybe ensure path for all xdg paths
}
