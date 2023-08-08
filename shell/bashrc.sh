#!/usr/bin/env bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Main ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~ Blesh (first part) ~~~~~~~~~~~~~~~~~~ #
[[ $- == *i* ]] && source "$XDG_DATA_HOME/blesh/ble.sh" --noattach
# ~~~~~~~~~~~~~~~~~~~ Basic settings ~~~~~~~~~~~~~~~~~~~~ #
bind 'set bell-style none' # Disable annoying sound
# ~~~~~~~~~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~ #
default_exa="exa --group-directories-first --group --icons --header --git --color=always"
alias f="nvim"
alias ls="$default_exa"
alias ll="$default_exa --long"
alias la="$default_exa --long --all"
alias tree="$default_exa --tree"
# ~~~~~~~~~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~ #
__overprompt() {
	local -r status=$?
	echo                       # Separate command-output blocks
	echo -n " "                # Offset
	echo -n "${PWD/#$HOME/\~}" # Current working directory, with tilde abbreviation
	# Git branch/commit hash, if any
	if git rev-parse --git-dir >/dev/null 2>&1; then
		local branch
		branch=$(git branch --show-current)
		[ -z "$branch" ] && branch="($(git rev-parse --short HEAD))"
		echo -n " ($branch)"
	fi
	# Return code, if non-zero
	[ "$status" -ne 0 ] && echo -n " [$status]"
}
PS1='$(__overprompt)\n '
PS2='│'
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ E(x)ternal bloat ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~ Completions ~~~~~~~~~~~~~~~~~~~~~ #
[[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]] && . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
# ~~~~~~~~~~~~~~~~~~~~~~~ Zoxide ~~~~~~~~~~~~~~~~~~~~~~~~ #
# TODO add zoxide-fzf options
eval "$(zoxide init bash --cmd j)"
export _ZO_RESOLVE_SYMLINKS="1"
# ~~~~~~~~~~~~~~~~~~~~~~~~~ Fzf ~~~~~~~~~~~~~~~~~~~~~~~~~ #
[ -f ~/.fzf.bash ] && {
	. "$HOME/.fzf.bash"
	ble-import -d integration/fzf-completion
	ble-import -d integration/fzf-key-bindings
	export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
	export FZF_ALT_C_OPTS="--preview 'tree {}'"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~ Exa ~~~~~~~~~~~~~~~~~~~~~~~~~ #
export EXA_COLORS="uu=36:gu=37:sn=32:sb=32:da=34:ur=34:uw=35:ux=36:ue=36:gr=34:gw=35:gx=36:tr=34:tw=35:tx=36"
# ~~~~~~~~~~~~~~~~~~~~~~~~ Conda ~~~~~~~~~~~~~~~~~~~~~~~~ #
if __conda_setup="$("$HOMEBREW_PREFIX/Caskroom/miniforge/base/bin/conda" "shell.bash" "hook" 2>/dev/null)"; then
	eval "$__conda_setup"
else
	if [ -f "$HOMEBREW_PREFIX/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
		. "$HOMEBREW_PREFIX/Caskroom/miniforge/base/etc/profile.d/conda.sh"
	else
		export PATH="$HOMEBREW_PREFIX/Caskroom/miniforge/base/bin${PATH:+:$PATH}"
	fi
fi
unset __conda_setup
# ~~~~~~~~~~~~~~~~~ Blesh (second part) ~~~~~~~~~~~~~~~~~ #
[[ ${BLE_VERSION-} ]] && ble-attach
