#!/usr/bin/env bash
__zo_fzf_preview='ls --color=always -Cp'
if command -v "eza" &> /dev/null; then
	__zo_fzf_preview="$EZACMD --group-directories-first --icons --grid --color=always"
fi
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS
--no-sort
--exit-0
--select-1
--preview='$__zo_fzf_preview {2..}'
"
export _ZO_RESOLVE_SYMLINKS="1"
export _ZO_ECHO=1
export _ZO_EXCLUDE_DIRS="$XDG_CACHE_HOME/*"
