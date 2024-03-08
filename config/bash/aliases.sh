#!/usr/bin/env bash

alias c="clear"
alias v="nvim"
alias f="neovide"
alias d="xdg-open"

if command -v "eza" >/dev/null 2>&1; then
	# config file is proposed:
	alias ls="$EZACMD"
	alias ll="$EZACMD --long"
	alias la="$EZACMD --long --all"
	alias lt="$EZACMD --long --sort=time"
	alias tree="$EZACMD --tree"
else
	alias ll="ls -lth"
	alias la="ls -alth"
fi

alias fd="fd -H"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias conda="micromamba"

alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'

upload() {
	curl --upload-file "$1" "https://transfer.sh/$1"
}
