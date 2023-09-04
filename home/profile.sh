#!/usr/bin/env sh

# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Locale
export LC_ALL="en_US.UTF-8"

# Editor
for editor in nvim vim nvi vi; do
	if command -v "$editor" >/dev/null 2>&1; then
		VISUAL="$editor"
		break
	fi
done
export VISUAL
export EDITOR="$VISUAL"

# Go modules and binaries
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin${PATH:+:$PATH}"

# __pycache__ folder
export PYTHONPYCACHEPREFIX="/tmp/pycache"
