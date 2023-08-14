#!/usr/bin/env bash

# Basic bash specific stuff
# bind 'set bell-style none' # Disable annoying sound
shopt -s globstar

# ~~~~~~~~~~~~~~~~~~~~~~~ aliases ~~~~~~~~~~~~~~~~~~~~~~~ #
exa="exa --group-directories-first --group --icons --header --git"
alias f="nvim"
alias ls="${exa}"
alias ll="${exa} --long"
alias la="${exa} --long --all"
alias tree="${exa} --tree"
alias fd="fd -H"
unset exa
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# Colorizes a string (if possible)
__colorize() {
	# $1, $2, $3 - RGB
	# $4 - text
	[ "$(tput colors)" -eq 256 ] && printf "\033[38;2;%s;%s;%sm" "$1" "$2" "$3"
}

# Draws the prompt
__print_prompt() {
	# Capture previous return code
	local -r status=$?

	local -r green=$(__colorize 80 250 123)
	local -r purple=$(__colorize 189 147 249)
	local -r red=$(__colorize 255 85 85)
	local -r pink=$(__colorize 255 121 198)

	local -r bold="\033[1m"
	local -r norm="\033[0m"

	# Set up colorizers
	# Take colors from
	# https://spec.draculatheme.com/

	# Block divider
	echo

	# CWD
	printf " ${bold}${purple}%s${norm}" "${PWD/#${HOME}/\~}"

	# Git
	if git rev-parse --git-dir >/dev/null 2>&1; then
		printf " ${pink}"

		# Branch
		local branch=$(git branch --show-current)
		[ -z "${branch}" ] && branch="$(git rev-parse --short HEAD)"
		printf "${branch}"

		# Status
		local -r git_status="$(git status --porcelain | while read -r line; do
			echo "${line}" | awk '{print $1}'
		done | tr -d '\n' | sed 's/./&\n/g' | sort | uniq | tr -d '\n')"
		[ "${git_status}" ] && printf ":${git_status}"

		printf "${norm}"
	fi

	# Conda environment
	[ "${CONDA_DEFAULT_ENV}" ] && printf " ${green}conda:%s${norm}" "${CONDA_DEFAULT_ENV}"
	# Venv environment
	# TODO do I really need the parent dir name here? Maybe just keep the "venv"?
	[ "${VIRTUAL_ENV}" ] && printf " ${green}venv:%s${norm}" "$(basename "$(dirname "${VIRTUAL_ENV}")")"

	# Return code, if non-zero
	[ "${status}" -ne 0 ] && printf " ${bold}${red}%s${norm}" "${status}"

	printf "\n "
}
PS1='$(__print_prompt)' && PS2='│'

# ~~~~~~~~~~~~~~~~~~~~~~~~ conda ~~~~~~~~~~~~~~~~~~~~~~~~ #
__base="${HOMEBREW_PREFIX}/Caskroom/miniforge/base"
if __conda_setup="$("${__base}/bin/conda" "shell.bash" "hook" 2>/dev/null)"; then
	eval "${__conda_setup}"
elif [ -r "${__base}/etc/profile.d/conda.sh" ]; then
	. "${__base}/etc/profile.d/conda.sh"
else
	export PATH="${__base}/bin${PATH:+:${PATH}}"
fi
unset __base
unset __conda_setup
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
cmp="${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" && [ -r "${cmp}" ] && . "${cmp}" && unset cmp
fzfpath="${HOME}/.fzf.bash" && [ -r "${fzfpath}" ] && . "${fzfpath}" && unset fzfpath
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash --cmd j)"
# blesh_path="${XDG_DATA_HOME}/blesh/ble.sh" && [ -r "${blesh_path}" ] && . "${blesh_path}" && unset blesh_path
