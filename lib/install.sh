#!/usr/bin/env bash
. ./home/.profile
set -e

lndir() {
	shopt -s dotglob
	mkdir -p "$2"
	ln -sft "$2" "$1"/*
	shopt -u dotglob
}

install() {
	lndir "$PWD/home" "$HOME"
	lndir "$PWD/config" "$XDG_CONFIG_HOME"

	touch "$HOME/.hushlogin"
	mkdir -p "$HOME/screenshots"
	# TODO maybe ensure path for all xdg paths
}
