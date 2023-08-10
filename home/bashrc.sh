#!/usr/bin/env bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Main ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~ Blesh (first part) ~~~~~~~~~~~~~~~~~~ #
blesh_path="${XDG_DATA_HOME}/blesh/ble.sh"
[ -r "${blesh_path}" ] && source "${blesh_path}" --noattach
# ~~~~~~~~~~~~~~~~~~~ Basic settings ~~~~~~~~~~~~~~~~~~~~ #
bind 'set bell-style none' # Disable annoying sound
shopt -s globstar
# ~~~~~~~~~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~ #
exa="exa --group-directories-first --group --icons --header --git --color=always"
alias f="nvim"
alias ls="${exa}"
alias ll="${exa} --long"
alias la="${exa} --long --all"
alias tree="${exa} --tree"
alias fd="fd -H"
# ~~~~~~~~~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~ #
__overprompt() {
	local -r status=$?
	# Current working directory, with tilde abbreviation
	echo -en "\n ${PWD/#${HOME}/\~}"
	# Git branch/commit hash, if any
	if git rev-parse --git-dir >/dev/null 2>&1; then
		local branch
		branch=$(git branch --show-current)
		[ -z "${branch}" ] && branch="($(git rev-parse --short HEAD))"
		echo -n " (${branch})"
	fi
	# Return code, if non-zero
	[ "${status}" -ne 0 ] && echo -en " [${status}]\n "
}
PS1='$(__overprompt) '
PS2='│'
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ E(x)ternal bloat ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~ Completions ~~~~~~~~~~~~~~~~~~~~~ #
[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ] && . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
# ~~~~~~~~~~~~~~~~~~~~~~~ Zoxide ~~~~~~~~~~~~~~~~~~~~~~~~ #
# TODO add zoxide-fzf options
export _ZO_RESOLVE_SYMLINKS="1"
eval "$(zoxide init bash --cmd j)"
# ~~~~~~~~~~~~~~~~~~~~~~~~~ Fzf ~~~~~~~~~~~~~~~~~~~~~~~~~ #
[ -f ~/.fzf.bash ] && {
	export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
	export FZF_ALT_C_OPTS="--preview 'tree {}'"
	# . "${HOME}/.fzf.bash" # uncomment if no blesh
	ble-import -d integration/fzf-completion
	ble-import -d integration/fzf-key-bindings
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~ Exa ~~~~~~~~~~~~~~~~~~~~~~~~~ #
export EXA_COLORS="uu=36:gu=37:sn=32:sb=32:da=34:ur=34:uw=35:ux=36:ue=36:gr=34:gw=35:gx=36:tr=34:tw=35:tx=36"
# ~~~~~~~~~~~~~~~~~~~~~~~~ Conda ~~~~~~~~~~~~~~~~~~~~~~~~ #
if __conda_setup="$("${HOMEBREW_PREFIX}/Caskroom/miniforge/base/bin/conda" "shell.bash" "hook" 2>/dev/null)"; then
	eval "${__conda_setup}"
else
	if [ -f "${HOMEBREW_PREFIX}/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
		. "${HOMEBREW_PREFIX}/Caskroom/miniforge/base/etc/profile.d/conda.sh"
	else
		export PATH="${HOMEBREW_PREFIX}/Caskroom/miniforge/base/bin${PATH:+:${PATH}}"
	fi
fi
unset __conda_setup
# ~~~~~~~~~~~~~~~~~ Blesh (second part) ~~~~~~~~~~~~~~~~~ #
[ "${BLE_VERSION}" ] && ble-attach
