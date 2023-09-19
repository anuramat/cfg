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

# ls replacement
export LSCMD="eza"

# Vim
for editor in nvim vim nvi vi; do
	if command -v "$editor" >/dev/null 2>&1; then
		export VISUAL="$editor"
		break
	fi
done
export EDITOR="$VISUAL"

# Emacs
export PATH="$XDG_CONFIG_HOME/emacs/bin${PATH:+:$PATH}"

# Go modules and binaries
export GOPATH="$HOME/go"
export PATH="${PATH:+$PATH:}$GOPATH/bin"

# Node
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

# __pycache__ folder
export PYTHONPYCACHEPREFIX="/tmp/pycache"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
# NOTE .pyhistory is still hardcoded: https://github.com/python/cpython/pull/13208
