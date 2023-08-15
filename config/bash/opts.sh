#!/usr/bin/env bash

# Exa  colors
export EXA_COLORS="\
uu=36:\
gu=37:\
sn=32:\
sb=32:\
da=34:\
ur=34:\
uw=35:\
ux=36:\
ue=36:\
gr=34:\
gw=35:\
gx=36:\
tr=34:\
tw=35:\
tx=36\
"

# Integrate bat
# TODO add fallback
# TODO ls on folders instead of bat
if command -v "bat" >/dev/null 2>&1; then
	export FZF_CTRL_T_OPTS="${FZF_CTRL_T_OPTS:+${FZF_CTRL_T_OPTS} } \
--preview 'bat -n --color=always {}' \
--bind 'ctrl-/:change-preview-window(down|hidden|)'
"
fi

# Preview directories in fzf using tree/exa
# TODO append instead of overwriting
if command -v "exa" >/dev/null 2>&1; then
	export FZF_ALT_C_OPTS="--preview 'exa --tree --icons {}'"
elif command -v "tree" >/dev/null 2>&1; then
	export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
fi

# Zoxide settings
export _ZO_RESOLVE_SYMLINKS="1"
__zo_fzf_preview='ls --color=always -Cp'
if command -v "exa" >/dev/null 2>&1; then
	__zo_fzf_preview='exa --group-directories-first --icons'
fi
export _ZO_FZF_OPTS="\
--no-sort \
--bind=ctrl-z:ignore,btab:up,tab:down \
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
--preview='${__zo_fzf_preview} {2..}' \
"

# Read ripgrep settings
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgreprc"
