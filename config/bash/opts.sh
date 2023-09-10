#!/usr/bin/env bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~ fzf ~~~~~~~~~~~~~~~~~~~~~~~~~~ #
export FZF_DEFAULT_OPTS="\
--bind 'ctrl-/:change-preview-window(down|hidden|)' \
--preview '$XDG_CONFIG_HOME/bash/fzf_previewer.sh {}'
"

if command -v "fd" >/dev/null 2>&1; then
	export FZF_DEFAULT_COMMAND="fd ."
	export FZF_ALT_C_COMMAND="fd -t d ."
fi
# ~~~~~~~~~~~~~~~~~~~~~~~~ zoxide ~~~~~~~~~~~~~~~~~~~~~~~~ #
# TODO prettify
export _ZO_RESOLVE_SYMLINKS="1"
__zo_fzf_preview='ls --color=always -Cp'
if command -v "exa" >/dev/null 2>&1; then
	__zo_fzf_preview='exa --group-directories-first --icons'
fi
export _ZO_FZF_OPTS="\
--no-sort \
--bind=ctrl-z:jump,btab:up,tab:down \
--cycle \
--keep-right \
--border=sharp \
--height=45% \
--info=inline \
--layout=reverse \
--tabstop=1 \
--exit-0 \
--select-1 \
--preview-window=down,30%,sharp \
--preview='$__zo_fzf_preview {2..}' \
"
# ~~~~~~~~~~~~~~~~~~~~ read ripgreprc ~~~~~~~~~~~~~~~~~~~~ #
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgreprc"
