#!/usr/bin/env sh
# __pycache__ folder
export PYTHONPYCACHEPREFIX=/tmp/pycache

# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Homebrew path
export HOMEBREW_PREFIX="/opt/homebrew"
eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)" # brew env variables

# Go modules and binaries
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin${PATH:+:$PATH}"

# Locale
export LC_ALL="en_US.UTF-8"

# Editor
if command -v "nvim" >/dev/null 2>&1; then
	export EDITOR="nvim"
else
	export EDITOR="vi"
fi
export VISUAL="$EDITOR"

# Pretty manpages
if command -v "bat" >/dev/null 2>&1; then
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# Read ripgrep settings
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgreprc"
