#!/usr/bin/env bash

shopt -s globstar autocd
# globstar - Enables ** for recursing into subdirectories
# autocd   - `cd path` -> `path`

# ~~~~~~~~~~~~ import the bulk of the config ~~~~~~~~~~~~~ #

. "$HOME/.profile"
. "$XDG_CONFIG_HOME/sh/config.d/00-ls_colors.sh"
. "$XDG_CONFIG_HOME/sh/config.d/00-prompt.sh"
. "$XDG_CONFIG_HOME/sh/config.d/01-fzf_config.sh"
. "$XDG_CONFIG_HOME/sh/config.d/01-misc_params.sh"
. "$XDG_CONFIG_HOME/sh/config.d/01-xdg_compliance.sh"
. "$XDG_CONFIG_HOME/sh/config.d/02-zoxide_config.sh"

# ~~~~~~~~~~~~~~~ software initialization ~~~~~~~~~~~~~~~~ #

if command -v fzf-share >/dev/null; then
	source "$(fzf-share)/key-bindings.bash"
	source "$(fzf-share)/completion.bash"
fi
# next two lines append commands to $PROMPT_COMMAND
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash --cmd j --hook pwd)"
source <(cod init $$ bash)
eval "$(starship init bash)" # "eats" $PROMPT_COMMAND

# ~~~~~~~~~~~~~~~~~~~~~ some aliases ~~~~~~~~~~~~~~~~~~~~~ #
upload() {
	curl --upload-file "$1" "https://transfer.sh/$1"
}
cheat() {
	curl -m 10 "http://cheat.sh/${1}" 2>/dev/null || printf '%s\n' "[ERROR] Something broke"
}
alias c="clear"
alias t="tldr"
alias f="nvim"
alias v="neovide && exit"
alias d="xdg-open"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
