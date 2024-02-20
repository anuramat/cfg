#!/usr/bin/env sh

# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_PICTURES_DIR="$HOME/Pictures"

export GRIM_DEFAULT_DIR="$HOME/Screenshots"

# Homebrew path
export HOMEBREW_PREFIX="/opt/homebrew"
_brewshellenv="$("$HOMEBREW_PREFIX/bin/brew" shellenv 2>/dev/null)"
eval "$_brewshellenv"

# Go modules and binaries
export GOPATH="$HOME/go"
export PATH="${PATH:+$PATH:}$GOPATH/bin"

# User binaries
export PATH="$HOME/bin${PATH:+:$PATH}"

# Ghcup
export PATH="$HOME/.ghcup/bin${PATH:+:$PATH}"

# Locale
export LC_ALL="en_US.UTF-8"

# ls replacement
export EZACMD="eza --group-directories-first --group --header --git --color=always --icons=always"

# Vim
for editor in nvim vim nvi vi; do
	if command -v "$editor" >/dev/null 2>&1; then
		export VISUAL="$editor"
		break
	fi
done
export EDITOR="$VISUAL"

# Node
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

# __pycache__ folder
export PYTHONPYCACHEPREFIX="/tmp/pycache"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
# NOTE .pyhistory is still hardcoded: https://github.com/python/cpython/pull/13208

# Homebrew
export HOMEBREW_NO_ANALYTICS="true"
export HOMEBREW_BUNDLE_NO_LOCK="true"
