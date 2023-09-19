#!/usr/bin/env bash

alias f="nvim"

if command -v "$LSCMD" >/dev/null 2>&1; then
	# config file is proposed:
	__lscmd="$LSCMD --group-directories-first --group --icons --header --git"
	alias ls="$__lscmd"
	alias ll="$__lscmd --long"
	alias la="$__lscmd --long --all"
	alias tree="$__lscmd --tree"
else
	alias ll="ls -lth"
	alias la="ls -alth"
fi
unset __lscmd

alias fd="fd -H"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias conda="micromamba"

alias icat="kitty +kitten icat"

alias nire="sudo nixos-rebuild switch"
alias nied="sudo -e /etc/nixos/configuration.nix"

alias open=xdg-open

alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
