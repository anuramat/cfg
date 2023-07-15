#!/usr/bin/env fish
if status is-interactive
    set default_exa "exa --group-directories-first --group --icons --header --git"
    alias f="nvim"
    alias ls="$default_exa"
    alias ll="$default_exa --long"
    alias la="$default_exa --long --all"
    alias tree="$default_exa --tree"
    alias j="z"

    export EDITOR="nvim"
    export VISUAL="$EDITOR"
    export _ZO_RESOLVE_SYMLINKS="1"
    eval "$(brew shellenv)"
    eval "$(zoxide init fish)"
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniforge/base/bin/conda
    eval /opt/homebrew/Caskroom/miniforge/base/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<
