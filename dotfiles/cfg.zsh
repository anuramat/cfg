#!/usr/bin/env zsh

# requires exa, nvim, cht.sh, git, bat

alias l="exa --group-directories-first --group --icons --header --git" 
alias v="nvim"
alias tree="exa --group-directories-first --group --icons --header --git --tree"
alias githehe="git add . && git commit -m \"hehe\" && git push"

export EDITOR="nvim"

function c ()
{
    cht.sh $@ | bat
}
