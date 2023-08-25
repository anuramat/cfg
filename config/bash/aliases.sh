#!/usr/bin/env bash

exa="exa --group-directories-first --group --icons --header --git"
alias f="nvim"
alias ls="$exa"
alias ll="$exa --long"
alias la="$exa --long --all"
alias tree="$exa --tree"
alias fd="fd -H"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
unset exa
