#!/usr/bin/env sh

# XDG paths
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Locale
export LC_ALL="en_US.UTF-8"

# Homebrew path
export HOMEBREW_PREFIX="/opt/homebrew"
eval "$("${HOMEBREW_PREFIX}/bin/brew" shellenv)" # brew env variables

# Editor
for editor in nvim vim nvi vi; do
	if command -v "${editor}" >/dev/null 2>&1; then
		VISUAL="${editor}"
		break
	fi
done
export VISUAL
export EDITOR="${VISUAL}"

# Go modules and binaries
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin${PATH:+:${PATH}}"

# __pycache__ folder
export PYTHONPYCACHEPREFIX="/tmp/pycache"

# Homebrew
export HOMEBREW_NO_ANALYTICS="true"
export HOMEBREW_BUNDLE_NO_LOCK="true"
