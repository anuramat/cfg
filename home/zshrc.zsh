#!/usr/bin/env zsh
# best effort support

setopt PROMPT_SUBST                    # so that the bash PS1 works

. "${HOME}/.profile"                   # basic env vars
. "${XDG_CONFIG_HOME}/bash/utils.sh"   # helper functions
. "${XDG_CONFIG_HOME}/bash/opts.sh"    # options for external tools
. "${XDG_CONFIG_HOME}/bash/aliases.sh"
. "${XDG_CONFIG_HOME}/bash/prompt.sh"
[ -r "$XDG_CONFIG_HOME/bash/private.sh" ] && . "$XDG_CONFIG_HOME/bash/private.sh"

# TODO conda
[ -f ~/.fzf.zsh ] && . ~/.fzf.zsh
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh --cmd j --hook pwd)"
