#!/usr/bin/env bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ fzf ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~ default command ~~~~~~~~~~~~~~~~~~~~ #
if command -v "fd" >/dev/null 2>&1; then
	export FZF_DEFAULT_COMMAND="fd ."
	export FZF_ALT_C_COMMAND="fd . -t d --strip-cwd-prefix"
	export FZF_CTRL_T_COMMAND="fd . -t f --strip-cwd-prefix"
fi
# ~~~~~~~~~~~~~~~~~~~~~ default opts ~~~~~~~~~~~~~~~~~~~~~ #
export FZF_DEFAULT_OPTS="
--preview='$XDG_CONFIG_HOME/bash/fzf_previewer.sh {}'
--layout=reverse
--keep-right
--info=inline
--tabstop=2
--multi
--height=50%

--bind='ctrl-/:change-preview-window(down|hidden|)'
--bind='ctrl-j:accept'
--bind='ctrl-s:jump-accept'
--bind='tab:toggle+down'
--bind='btab:toggle+up'

--bind='ctrl-y:preview-up'
--bind='ctrl-e:preview-down'
--bind='ctrl-u:preview-half-page-up'
--bind='ctrl-d:preview-half-page-down'
--bind='ctrl-b:preview-page-up'
--bind='ctrl-f:preview-page-down'
"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ zoxide ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
export _ZO_RESOLVE_SYMLINKS="1"
# ~~~~~~~~~~~~~~~~~~~ fzf integration ~~~~~~~~~~~~~~~~~~~~ #
__zo_fzf_preview='ls --color=always -Cp'
if command -v "exa" >/dev/null 2>&1; then
	__zo_fzf_preview='exa --group-directories-first --icons --grid'
fi
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS
--no-sort
--exit-0
--select-1
--preview='$__zo_fzf_preview {2..}'
"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ripgrep ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgreprc"
