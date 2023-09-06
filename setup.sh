#!/usr/bin/env bash
set -e

. ./lib/utils.sh
. ./home/profile.sh

echo "[cfg] installing configs"

# Install $HOME dotfiles
for __dotfile in home/*; do
	install2file "$__dotfile" "$HOME/.$(remove_extension "$__dotfile")"
done

install2folder config/nvim/after "$HOME/.vim/"

# Install $XDG_CONFIG_HOME configs
for __folder in config/*; do
	install2folder "$__folder" "$XDG_CONFIG_HOME"
done

touch "$HOME/.hushlogin"
mkdir "$HOME/bin"
