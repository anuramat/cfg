#!/usr/bin/env bash
__ALWAYS_OVERWRITE="true"
. lib/utils.sh

# Install $HOME dotfiles
for __dotfile in home/*; do
	install2file "${__dotfile}" "${HOME}/$(rehide_name "${__dotfile}")"
done

install2file "./config/nvim/init.vim" "${HOME}/.vimrc"

# Install $XDG_CONFIG_HOME configs
for __folder in config/*; do
	install2folder "${__folder}" "${XDG_CONFIG_HOME}"
done
