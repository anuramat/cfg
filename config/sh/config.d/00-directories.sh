#!/usr/bin/env sh

# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# keep this posix compatible
export XDG_PICTURES_DIR="$HOME/Pictures" # TODO are you sure about that

export SCREENSHOT_DIR="$HOME/screenshots"
export GRIM_DEFAULT_DIR="$SCREENSHOT_DIR"

export PATH="${PATH:+$PATH:}$GOPATH/bin"
export PATH="$HOME/.ghcup/bin${PATH:+:$PATH}"
export PATH="$HOME/.local/bin${PATH:+:$PATH}"
