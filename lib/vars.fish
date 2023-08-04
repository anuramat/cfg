#!/usr/bin/env fish
# Sets permanent fish variables (other are set from config.fish)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ XDG ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_STATE_HOME "$HOME/.local/state"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Misc common stuff ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
set -Ux LC_ALL 'en_US.UTF-8'
set -Ux EDITOR "nvim"
set -Ux VISUAL "$EDITOR"
set -U fish_greeting
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Paths ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
fish_add_path /opt/homebrew/bin/
set -Ux GOPATH "$HOME/go"
fish_add_path "$HOME/go/bin"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
set -l default_exa "exa --group-directories-first --group --icons --header --git"
alias -s f "nvim"
alias -s ls "$default_exa"
alias -s ll "$default_exa --long"
alias -s la "$default_exa --long --all"
alias -s tree "$default_exa --tree"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~ External requirements ~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Read ripgrep settings
set -Ux RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgreprc"
# Resolve symlinks to get true paths for database
set -Ux _ZO_RESOLVE_SYMLINKS "1"
# Preview file content using bat 
set -Ux FZF_CTRL_T_OPTS "--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# Print tree structure in the preview window
set -Ux FZF_ALT_C_OPTS "--preview 'tree {}'"
