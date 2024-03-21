#!/usr/bin/env bash
. ./home/.profile
set -e

ensure_path() {
	local -r path="$1"

	[ -d "$path" ] && return
	mkdir -p "$path" || {
		echo >&2 "couldn't create path \"$path\""
		return 1
	}
}

# git check-ignore "$original" >/dev/null 2>&1 && {
# 	return
# }

install_file() {
	# $1 -- original file
	# $2 -- destination directory
	local file
	file="$(realpath -eq "$1")" || {
		echo >&2 "file \"$file\" not found"
		return 1
	}
	local -r destination="$(realpath -m "$2")"
	ensure_path "$destination" || return 1
	ln -sft "$destination" "$file" || {
		echo >&2 "can't link $file to $destination"
		return 1
	}
}

install_all() {
	echo 'linking to $HOME'
	shopt -s dotglob
	for __dotfile in home/*; do
		install_file "$__dotfile" "$HOME"
	done
	echo 'linking to $XDG_CONFIG_HOME'
	for __folder in config/*; do
		install_file "$__folder" "$XDG_CONFIG_HOME"
	done
	shopt -u dotglob

	echo "creating directories"
	# TODO move all of this to configuration.nix or home manager
	touch "$HOME/.hushlogin"
	ensure_path "$HOME/screenshots"
	# TODO maybe ensure path for all xdg paths
}
