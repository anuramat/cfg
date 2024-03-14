#!/usr/bin/env bash
set -e

. ./lib/utils.sh
. ./home/.profile

echo "[cfg] installing dotfiles"
shopt -s dotglob
for __dotfile in home/*; do
	install2folder "$__dotfile" "$HOME"
done
shopt -u dotglob

echo "[cfg] installing configs"
for __folder in config/*; do
	install2folder "$__folder" "$XDG_CONFIG_HOME"
done

echo "[cfg] creating directories"
# TODO move all of this to configuration.nix or home manager
touch "$HOME/.hushlogin"
ensure_path "$HOME/bin"
ensure_path "$HOME/Screenshots"
# TODO maybe ensure path for all xdg paths
