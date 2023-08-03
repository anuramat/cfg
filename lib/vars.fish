#!/usr/bin/env fish
# Configures fish shell (partially, the rest is in the config files)
set -Ux LC_ALL 'en_US.UTF-8'
set -Ux EDITOR "nvim"
set -Ux VISUAL "$EDITOR"
set -U fish_greeting
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Paths ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
set -Ux GOPATH "$HOME/go"
fish_add_path "$HOME/go/bin"
fish_add_path /opt/homebrew/bin/
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
set default_exa "exa --group-directories-first --group --icons --header --git"
alias -s f="nvim"
alias -s j="z"
alias -s ls="$default_exa"
alias -s ll="$default_exa --long"
alias -s la="$default_exa --long --all"
alias -s tree="$default_exa --tree"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~ External requirements ~~~~~~~~~~~~~~~~~~~~~~~~~~~#
set -Ux _ZO_RESOLVE_SYMLINKS "1"
# Preview file content using bat 
set -Ux FZF_CTRL_T_OPTS "--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# Print tree structure in the preview window
set -Ux FZF_ALT_C_OPTS "--preview 'tree {}'"
