#!/usr/bin/env sh
__zo_fzf_preview='ls --color=always -Cp'
if command -v "eza" >/dev/null 2>&1; then
	__zo_fzf_preview="$EZACMD --group-directories-first --icons --grid"
fi
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS
--no-sort
--exit-0
--select-1
--preview='$__zo_fzf_preview {2..}'
"
export _ZO_RESOLVE_SYMLINKS="1"
