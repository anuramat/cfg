#!/usr/bin/env sh
# xdg paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# brew path
export HOMEBREW_PREFIX="/opt/homebrew"
# brew binaries are added to path separately, in rc

# go modules and binaries
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin${PATH:+:$PATH}"

# locale
export LC_ALL="en_US.UTF-8"

# editor
if command -v "nvim" >/dev/null 2>&1; then
  export EDITOR="nvim"
else
  export EDITOR="vi"
fi
export VISUAL="$EDITOR"

# pretty manpages
if command -v "bat" >/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi
