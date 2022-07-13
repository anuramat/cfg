# requires exa, nvim, cht.sh, git, bat

export VISUAL="nvim"
export EDITOR="$VISUAL"

alias l="exa --group-directories-first --group --icons --header --git" 
alias v="nvim"
alias t="exa --group-directories-first --group --icons --header --git --tree"
alias githehe="git add . && git commit -m \"hehe\" && git push"
alias b="bat"

function c ()
{
    cht.sh $@ | bat
}
