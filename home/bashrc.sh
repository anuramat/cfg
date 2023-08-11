#!/usr/bin/env bash

# Basic bash specific stuff
bind 'set bell-style none' # Disable annoying sound
shopt -s globstar

# ~~~~~~~~~~~~~~~~~~~~~~~ aliases ~~~~~~~~~~~~~~~~~~~~~~~ #
exa="exa --group-directories-first --group --icons --header --git"
alias f="nvim"
alias ls="${exa}"
alias ll="${exa} --long"
alias la="${exa} --long --all"
alias tree="${exa} --tree"
alias fd="fd -H"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Colorizes a string (if possible)
__colorize() {
	# $1, $2, $3 - RGB
	# $4 - text
	[ "$(tput colors)" -eq 256 ] && printf "\033[38;2;%s;%s;%sm%s\033[0m" "$1" "$2" "$3" "$4" && return 0
	printf "%s" "$4"
}

# Draws the prompt
__print_prompt() {
	# Capture previous return code
	local -r status=$?

	# Set up colorizers
	local -r purple="__colorize 189 147 249"
	local -r red="__colorize 255 85 85"
	local -r pink="__colorize 255 121 198"

	# Block divider
	echo

	# CWD
	${purple} " ${PWD/#${HOME}/\~}"

	# Git
	if git rev-parse --git-dir >/dev/null 2>&1; then
		# Print branch
		local branch=$(git branch --show-current)
		[ -z "${branch}" ] && branch="$(git rev-parse --short HEAD)"
		${pink} " (${branch})"

		# Print git status
		local -r git_status="$(git status --porcelain | while read -r line; do
			echo "${line}" | awk '{print $1}'
		done | tr -d '\n' | sed 's/./&\n/g' | sort | uniq | tr -d '\n')"
		[ "${git_status}" ] && ${pink} " [${git_status}]"
	fi

	# Return code, if non-zero
	[ "${status}" -ne 0 ] && ${red} " [${status}]"
	printf "\n "
}
PS1='$(__print_prompt)' && PS2='│'

# ~~~~~~~~~~~~~~~~~~~~~~~~ conda ~~~~~~~~~~~~~~~~~~~~~~~~ #
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
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ] && . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
[ -r "${HOME}/.fzf.bash" ] && . "${HOME}/.fzf.bash"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash --cmd j)"
blesh_path="${XDG_DATA_HOME}/blesh/ble.sh" && [ -r "${blesh_path}" ] && source "${blesh_path}" && unset blesh_path
