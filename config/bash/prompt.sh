#!/usr/bin/env bash

# Don't let python venvs change the PS1
export VIRTUAL_ENV_DISABLE_PROMPT="1"

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

	# Set up colors
	# https://spec.draculatheme.com/
	local -r green=$(__colorize 80 250 123)
	local -r purple=$(__colorize 189 147 249)
	local -r red=$(__colorize 255 85 85)
	local -r pink=$(__colorize 255 121 198)
	local -r bold="\033[1m"
	local -r norm="\033[0m"

	# Block divider
	echo

	# CWD
	printf " ${bold}${purple}%s${norm}" "${PWD/#${HOME}/\~}" # \w doesn't work here

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
PS1='$(__print_prompt)'
PS2='│'
