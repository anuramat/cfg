#!/usr/bin/env bash
set -e

lndir() (
	source="$1"
	directory="$2"
	[ -z "$directory" ] && {
		echo "can't link $1: target not set"
		return 1
	}
	shopt -s dotglob
	mkdir -p "$directory"
	find "$directory" -maxdepth 1 -xtype l -delete
	ln -sft "$directory" "$source"/*
	shopt -u dotglob
)

lndir "$PWD/home" "$HOME"
lndir "$PWD/config" "$XDG_CONFIG_HOME"
lndir "$PWD/bin" "$XDG_BIN_HOME"
