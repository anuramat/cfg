#!/usr/bin/env bash
. lib/utils.sh --always-overwrite

# Install $HOME dotfiles
for __dotfile in home/*; do
	install2file "${__dotfile}" "${HOME}/$(rehide_name "${__dotfile}")"
done

# Install $XDG_CONFIG_HOME configs
for __folder in config/*; do
	install2folder "${__folder}" "${XDG_CONFIG_HOME}"
done
