#!/usr/bin/env bash

colorscheme_path="$XDG_CONFIG_HOME/wallust/colorschemes"

# set wallust theme, and apply post hooks
__wallust_wrapped() {
	if [ "$1" = "sex" ]; then
		wallust cs -f terminal-sexy "$colorscheme_path/$2.json" || return
	else
		wallust "$@" || return
	fi
	"$XDG_CONFIG_HOME/mako/wal.sh"
	swaymsg reload &> /dev/null || true # shits out a scary error - ignore it TODO figure out
}

# bash-completions sets up a default comp func, that lazy-loads completions if
# they exist. fzf defines another default comp func on top, that lazily wraps
# the existing completion, adding "**". note that fzf can't auto-wrap non-lazy
# completions, since it only works with defaults, thus we load everything
# manually. note that for some commands, fzf comp is explicitly defined.

__load_completion wallust
__wallust_comp_custom() {
	[ "${COMP_WORDS[1]}" = "sex" ] && {
		[ "$COMP_CWORD" = 2 ] && {
			colorscheme_path="$XDG_CONFIG_HOME/wallust/colorschemes"
			mapfile -t sexthemes < <(compgen -W "$(find "$colorscheme_path" -mindepth 1 -exec basename "{}" ';' | sed 's/\.json$//')" ${COMP_WORDS[2]})
			COMPREPLY+=("${sexthemes[@]}") && return
		}
		return
	}
	_wallust "$@"
	[ "$COMP_CWORD" = 1 ] && {
		pot=$(compgen -W sex "${COMP_WORDS[1]}")
		[ -n "$pot" ] && COMPREPLY+=("$pot")
	}
}
complete -o bashdefault -o default -o nosort -F __wallust_comp_custom wallust
_fzf_setup_completion path wallust
alias wallust=__wallust_wrapped
