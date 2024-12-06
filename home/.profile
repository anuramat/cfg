#!/usr/bin/env bash

# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Not part of the spec yet but we will use it
export XDG_BIN_HOME="$HOME/.local/bin"

# TODO recheck
# XDG user dirs
[ -f "${HOME}/.config/user-dirs.dirs" ] && . "${HOME}/.config/user-dirs.dirs"

export LC_ALL="en_US.UTF-8" # just in case, this is already defined in nix
export PAGER=less           # just in case, this is already defined somewhere in system level rc
export MANPAGER=less        # todo colorized manpager

# Editor
for editor in nvim vim nvi vi; do
	if command -v "$editor" &>/dev/null; then
		export VISUAL="$editor"
		break
	fi
done
export EDITOR="$VISUAL"
