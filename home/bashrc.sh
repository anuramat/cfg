#!/usr/bin/env bash

bind 'set bell-style none' # Disable annoying sound
shopt -s globstar          # Enables ** for recursing into subdirectories

. "$HOME/.profile"                 # basic env vars
. "$XDG_CONFIG_HOME/bash/utils.sh" # helper functions
. "$XDG_CONFIG_HOME/bash/opts.sh"  # options for external tools
. "$XDG_CONFIG_HOME/bash/aliases.sh"
. "$XDG_CONFIG_HOME/bash/prompt.sh"
[ -r "$XDG_CONFIG_HOME/bash/private.sh" ] && . "$XDG_CONFIG_HOME/bash/private.sh"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Hooks ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# conda_path="$HOMEBREW_PREFIX/Caskroom/miniforge/base"
# if conda_hook="$("$conda_path/bin/conda" "shell.bash" "hook" 2>/dev/null)"; then
# 	eval "$conda_hook"
# elif [ -r "$conda_path/etc/profile.d/conda.sh" ]; then
# 	. "$conda_path/etc/profile.d/conda.sh"
# else
# 	export PATH="$conda_path/bin${PATH:+:$PATH}"
# fi
# unset conda_path conda_hook

if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
fi

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash --cmd j --hook pwd)"
