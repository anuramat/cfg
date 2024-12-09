#!/usr/bin/env bash
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS
--no-sort
--exit-0
--select-1
"
export _ZO_RESOLVE_SYMLINKS="1"
export _ZO_ECHO=1
export _ZO_EXCLUDE_DIRS="$XDG_CACHE_HOME/*"
