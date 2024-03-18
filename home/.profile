#!/usr/bin/env sh

# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_PICTURES_DIR="$HOME/Pictures"

export GRIM_DEFAULT_DIR="$HOME/screenshots"

# XDG Compliance
export GOPATH="$XDG_DATA_HOME/go"
export STACK_ROOT="$XDG_DATA_HOME"/stack # Haskell stack
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg # ??? I didn't install this...
export HISTFILE="${XDG_STATE_HOME}"/bash/history
# mkdir -p "$(dirname "$HISTFILE")" || true # TODO manually create some of these
export XCOMPOSECACHE="${XDG_CACHE_HOME}"/X11/xcompose
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss # VLC dependency
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

export HISTFILESIZE=9999

# Go modules and binaries
export PATH="${PATH:+$PATH:}$GOPATH/bin"
# Ghcup
export PATH="$HOME/.ghcup/bin${PATH:+:$PATH}"
# User binaries
export PATH="$HOME/.local/bin${PATH:+:$PATH}"

# Don't let python venvs change the PS1
export VIRTUAL_ENV_DISABLE_PROMPT="1"

# Locale
export LC_ALL="en_US.UTF-8"
# just in case, this is already defined in *.nix

export PAGER=less # just in case, this is already defined somewhere in system level rc
export MANPAGER='nvim +Man!'
# export MANPAGER="sh -c 'col -bx | bat -l man -p'" # I don't know how this works
# docs: It might also be necessary to set MANROFFOPT="-c" if you experience formatting problems.

export TERMCMD="alacritty" # used by rifle

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
