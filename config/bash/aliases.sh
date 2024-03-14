#!/usr/bin/env bash

c() {
	curl -m 10 "http://cheat.sh/${1}" 2>/dev/null || printf '%s\n' "[ERROR] Something broke"
}
alias t="tldr"
alias f="nvim"
alias v="neovide && exit"
alias d="xdg-open"

# ls
if command -v "eza" >/dev/null 2>&1; then
	# config file is proposed:
	alias ls="$EZACMD"
	alias ll="$EZACMD --long"
	alias la="$EZACMD --long --all"
	alias lt="$EZACMD --long --sort=time"
	alias tree="$EZACMD --tree"
else
	alias ls="ls --color=auto"
	alias ll="ls -lth --color=auto"
	alias la="ls -alth --color=auto"
fi

alias fd="fd -H"

# colorize basic stuff
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -c=auto'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias conda="micromamba"

alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'

upload() {
	curl --upload-file "$1" "https://transfer.sh/$1"
}
