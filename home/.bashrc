#!/usr/bin/env bash

bind 'set bell-style none' # Disable annoying sound
shopt -s globstar autocd
# globstar - Enables ** for recursing into subdirectories
# autocd   - `cd path` -> `path`

# TODO refactor: move stuff around
. "$HOME/.profile"                # basic env vars
. "$XDG_CONFIG_HOME/bash/opts.sh" # options for external tools
. "$XDG_CONFIG_HOME/bash/xdg_compliance.sh"
. "$XDG_CONFIG_HOME/bash/aliases.sh"
. "$XDG_CONFIG_HOME/bash/prompt.sh"
[ -r "$XDG_CONFIG_HOME/bash/private.sh" ] && . "$XDG_CONFIG_HOME/bash/private.sh"

if command -v fzf-share >/dev/null; then
	source "$(fzf-share)/key-bindings.bash"
	source "$(fzf-share)/completion.bash"
fi
# next two lines append commands to $PROMPT_COMMAND
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash --cmd j --hook pwd)"
source <(cod init $$ bash)
eval "$(starship init bash)" # "eats" $PROMPT_COMMAND
