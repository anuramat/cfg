#!/usr/bin/env bash

alias f="nvim"

exa="exa --group-directories-first --group --icons --header --git"
alias ls="$exa"
alias ll="$exa --long"
alias la="$exa --long --all"
alias tree="$exa --tree"
unset exa

alias fd="fd -H"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias nire="sudo nixos-rebuild switch"
alias nied="sudo -e /etc/nixos/configuration.nix"
