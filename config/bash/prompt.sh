#!/usr/bin/env bash

# Don't let python venvs change the PS1
export VIRTUAL_ENV_DISABLE_PROMPT="1"

# Colorizes a string (if possible)
__colorize() {
	# $1, $2, $3 - RGB
	# $4 - text
	[ "$(tput colors)" -eq 256 ] && printf "\033[38;2;%s;%s;%sm" "$1" "$2" "$3"
}

__git_prompt() {
	local git_dir
	if git_dir="$(git rev-parse --git-dir 2>/dev/null)"; then
		git_dir="$(realpath "${git_dir}")"

		# Bare repository
		if [ "$(git rev-parse --is-bare-repository 2>/dev/null)" = "true" ]; then
			printf "$(basename -s .git "${git_dir}")"
			return
		fi

		local -r root_dir="$(realpath "${git_dir}"/..)"

		# Repository name
		local -r url="$(git config --get remote.origin.url)"
		local -r __path="$(dirname "${git_dir}")"
		local -r repo_name="$(basename -s .git "${url:-${__path}}")"
		printf "${repo_name}"

		# Branch
		local branch="$(git branch --show-current)"
		[ -z "${branch}" ] && branch="$(git -C "${root_dir}" rev-parse --short HEAD)"
		printf ":${branch}"

		# Status
		local git_status="$(git -C "${root_dir}" status --porcelain | while read -r line; do
			echo "${line}" | awk '{print $1}'
		done | tr -d '\n' | sed 's/./&\n/g' | sort | uniq | tr -d '\n')"
		[ "${git_status}" ] && printf ":${git_status}"

		# TODO Unpushed commits
	fi
}

# Set up colors
# https://spec.draculatheme.com/
__green=$(__colorize 80 250 123)
__purple=$(__colorize 189 147 249)
__red=$(__colorize 255 85 85)
__pink=$(__colorize 255 121 198)
__bold="\033[1m"
__norm="\033[0m"

# Draws the prompt
__prompt() {
	# Capture previous return code
	local -r __status=$?

	# Block divider
	echo

	# CWD
	printf " ${__bold}${__purple}%s${__norm}" "${PWD/#${HOME}/"~"}"

	# Git
	printf "${__pink} "
	__git_prompt
	printf "${__norm}"

	# Conda
	[ "${CONDA_DEFAULT_ENV}" ] && printf " ${__green}conda:%s${__norm}" "${CONDA_DEFAULT_ENV}"
	# Python venv
	# TODO do I really need the parent dir name here? Maybe just keep the "venv"?
	[ "${VIRTUAL_ENV}" ] && printf " ${__green}venv:%s${__norm}" "$(basename "$(dirname "${VIRTUAL_ENV}")")"

	# Return code
	[ "${__status}" -ne 0 ] && printf " ${__bold}${__red}%s${__norm}" "${__status}"

	printf "\n "
}
PS1='$(__prompt)'
PS2='│'
