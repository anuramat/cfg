#!/usr/bin/env sh
# __pycache__ folder
export PYTHONPYCACHEPREFIX=/tmp/pycache

# XDG paths
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Homebrew path
export HOMEBREW_PREFIX="/opt/homebrew"
eval "$("${HOMEBREW_PREFIX}/bin/brew" shellenv)" # brew env variables

# Go modules and binaries
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin${PATH:+:${PATH}}"

# Locale
export LC_ALL="en_US.UTF-8"

# Editor
if command -v "nvim" >/dev/null 2>&1; then
	export EDITOR="nvim"
else
	export EDITOR="vi"
fi
export VISUAL="${EDITOR}"

# Integrate bat
if command -v "bat" >/dev/null 2>&1; then
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
fi

# Preview directories in fzf using tree/exa
if command -v "exa" >/dev/null 2>&1; then
	export FZF_ALT_C_OPTS="--preview 'exa --tree --icons {}'"
elif command -v "tree" >/dev/null 2>&1; then
	export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
fi

# Exa  colors
export EXA_COLORS="uu=36:gu=37:sn=32:sb=32:da=34:ur=34:uw=35:ux=36:ue=36:gr=34:gw=35:gx=36:tr=34:tw=35:tx=36"

# Zoxide settings
export _ZO_RESOLVE_SYMLINKS="1"

# Read ripgrep settings
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgreprc"
