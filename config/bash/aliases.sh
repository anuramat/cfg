#!/usr/bin/env bash

alias f="nvim"
alias d="$XDG_CONFIG_HOME/emacs/bin/doom"

if command -v exa >/dev/null 2>&1; then
	# config file is proposed:
	# https://github.com/ogham/exa/issues/511
	__exa="exa --group-directories-first --group --icons --header --git"
	alias ls="$__exa"
	alias ll="$__exa --long"
	alias la="$__exa --long --all"
	alias tree="$__exa --tree"
	unset exa
else
	alias ll="ls -lth"
	alias la="ls -alth"
fi

alias fd="fd -H"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias conda="micromamba"

alias icat="kitty +kitten icat"

alias nire="sudo nixos-rebuild switch"
alias nied="sudo -e /etc/nixos/configuration.nix"

alias open=xdg-open
