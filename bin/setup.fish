#!/usr/bin/env fish
# Sets permanent fish variables (other are set from config.fish)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ XDG ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
set -Ux XDG_CONFIG_HOME "$XDG_CONFIG_HOME"
set -Ux XDG_CACHE_HOME "$XDG_CACHE_HOME"
set -Ux XDG_DATA_HOME "$XDG_DATA_HOME"
set -Ux XDG_STATE_HOME "$XDG_STATE_HOME"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ The usual ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
set -Ux LC_ALL "en_US.UTF-8"
set -Ux EDITOR nvim
set -Ux VISUAL "$EDITOR"
set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -U fish_greeting
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Paths ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
fish_add_path "$HOMEBREW_PREFIX/bin/"
set -Ux GOPATH "$GOPATH"
fish_add_path "$GOPATH/bin"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
set -l default_exa "exa --group-directories-first --icons -h --git --color=always"
alias -s f nvim
alias -s ls "$default_exa"
alias -s ll "$default_exa -l"
alias -s la "$default_exa -alg"
alias -s tree "$default_exa -T"
alias -s bathelp "bat --plain --language=help"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ E(x)ternal bloat ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Exa Dracula colorscheme
set -Ux EXA_COLORS "uu=36:gu=37:sn=32:sb=32:da=34:ur=34:uw=35:ux=36:ue=36:gr=34:gw=35:gx=36:tr=34:tw=35:tx=36"
# Read ripgrep settings
set -Ux RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgreprc"
# Resolve symlinks to get true paths for database
set -Ux _ZO_RESOLVE_SYMLINKS 1
# Preview file content using bat 
set -Ux FZF_CTRL_T_OPTS "--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# Print tree structure in the preview window
set -Ux FZF_ALT_C_OPTS "--preview 'tree {}'"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Fish Dracula colorscheme ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
set -U fish_color_normal normal
set -U fish_color_command F8F8F2
set -U fish_color_quote F1FA8C
set -U fish_color_redirection 8BE9FD
set -U fish_color_end 50FA7B
set -U fish_color_error FFB86C
set -U fish_color_param FF79C6
set -U fish_color_comment 6272A4
set -U fish_color_match --background=brblue
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 00a6b2
set -U fish_color_escape 00a6b2
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion BD93F9
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel --reverse
set -U fish_pager_color_prefix normal --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D
set -U fish_pager_color_selected_background --background=brblack
set -U fish_color_option
set -U fish_pager_color_secondary_prefix
set -U fish_color_keyword
set -U fish_pager_color_secondary_background
set -U fish_pager_color_selected_prefix
set -U fish_pager_color_secondary_completion
set -U fish_pager_color_secondary_description
set -U fish_pager_color_background
set -U fish_color_host_remote
set -U fish_pager_color_selected_description
set -U fish_pager_color_selected_completion
