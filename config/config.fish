#!/usr/bin/env fish
if status is-interactive
    set default_exa "exa --group-directories-first --group --icons --header --git"
    alias f="nvim"
    alias ls="$default_exa"
    alias ll="$default_exa --long"
    alias la="$default_exa --long --all"
    alias tree="$default_exa --tree"
    alias j="z"

    # temporary
    alias hehe='fd ".*\\.go" . | rg -v "test|e2e|\\.pb.*\\.go" | xargs rg -M=200 -i "\".*[а-я].*\""' 
    alias hoho='fd ".*\\.go" . | rg -v "test|e2e|\\.pb.*\\.go" | xargs rg -M=200 -i "transl|i18n|l10n"' 

    # Preview file content using bat 
    export FZF_CTRL_T_OPTS="
      --preview 'bat -n --color=always {}'
      --bind 'ctrl-/:change-preview-window(down|hidden|)'"
    # Print tree structure in the preview window
    export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

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
