#!/usr/bin/env sh
export __custom_paths_exported=1
[ "$__custom_paths_exported" ] || {
	export PATH="${PATH:+$PATH:}$GOPATH/bin"
	export PATH="$HOME/.local/bin${PATH:+:$PATH}"
}
