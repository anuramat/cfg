#!/usr/bin/env bash
set -e

# get $XDG_CONFIG_HOME
[ -z "$XDG_CONFIG_HOME" ] && {
	echo '$XDG_CONFIG_HOME unset'
	exit 1
}

lndir() {
	source="$1"
	directory="$2"
	shopt -s dotglob
	mkdir -p "$directory"
	find "$directory" -maxdepth 1 -xtype l -delete
	ln -sft "$directory" "$source"/*
	shopt -u dotglob
}

lndir "$PWD/home" "$HOME"
lndir "$PWD/config" "$XDG_CONFIG_HOME"
touch "$HOME/.hushlogin"
