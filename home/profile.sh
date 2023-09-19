#!/usr/bin/env sh

# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# User binaries
export PATH="$HOME/bin${PATH:+:$PATH}"

# Locale
export LC_ALL="en_US.UTF-8"

# Vim
for editor in nvim vim nvi vi; do
	if command -v "$editor" >/dev/null 2>&1; then
		VISUAL="$editor"
		break
	fi
done
export VISUAL
export EDITOR="$VISUAL"

# Emacs
PATH="$XDG_CONFIG_HOME/emacs/bin${PATH:+:$PATH}"

# Go modules and binaries
export GOPATH="$HOME/go"
export PATH="${PATH:+$PATH:}$GOPATH/bin"

# __pycache__ folder
export PYTHONPYCACHEPREFIX="/tmp/pycache"
