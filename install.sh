#!/usr/bin/env bash
set -e

. ./lib/utils.sh
. ./home/profile.sh

# Install $HOME dotfiles
echo "[cfg] installing dotfiles"
for __dotfile in home/*; do
	install2file "$__dotfile" "$HOME/.$(remove_extension "$__dotfile")"
done

install2folder config/nvim/after "$HOME/.vim/"

# Install $XDG_CONFIG_HOME configs
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
