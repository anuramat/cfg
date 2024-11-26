#!/usr/bin/env bash
. ./home/.profile
set -e

lndir() {
	shopt -s dotglob
	mkdir -p "$2"
	ln -sft "$2" "$1"/*
	shopt -u dotglob
}

lndir "$PWD/home" "$HOME"
lndir "$PWD/config" "$XDG_CONFIG_HOME"

touch "$HOME/.hushlogin"
xdg-user-dirs-update --force
# TODO maybe ensure path for xdg basedir spec too
