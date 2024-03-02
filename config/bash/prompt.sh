#!/usr/bin/env bash

# Don't let python venvs change the PS1
export VIRTUAL_ENV_DISABLE_PROMPT="1"

# Converts RGB values to 24-bit color escape code
__colorcode_from_rgb() {
	# $1, $2, $3 - RGB
	[ "$(tput colors)" -eq 256 ] && printf "\033[38;2;%s;%s;%sm" "$1" "$2" "$3"
}

# Goes through "git status --porcelain=v1" output, searching for the letter
__git_status_attr() {
	# $1 - target letter
	# $2 - output symbol (defautls to $1)
	grep -q -e "^.$1" -e "^$1." && {
		[ "$2" ] && printf "$2" && return
		printf "$1"
	}
}

# Returns git status string of the form '[A-Z]+'
__git_status() {
	# $1 - root dir
	local porcelain=$(git -C "$1" status --porcelain)
	printf "$(echo "$porcelain" | __git_status_attr A)" # A: addition of a file
	printf "$(echo "$porcelain" | __git_status_attr C)" # C: copy of a file into a new one
	printf "$(echo "$porcelain" | __git_status_attr D)" # D: deletion of a file
	printf "$(echo "$porcelain" | __git_status_attr M)" # M: modification of the contents or mode of a file
	printf "$(echo "$porcelain" | __git_status_attr R)" # R: renaming of a file
	printf "$(echo "$porcelain" | __git_status_attr T)" # T: change in the type of the file
	printf "$(echo "$porcelain" | __git_status_attr U)" # U: file is unmerged (you must complete the merge before it can be committed)
	printf "$(echo "$porcelain" | __git_status_attr X)" # X: "unknown" change type (most probably a bug, please report it)
}

__git_prompt() {
	printf "$__pink"
	local git_dir
	if git_dir="$(git rev-parse --git-dir 2>/dev/null)"; then
		git_dir="$(realpath "$git_dir")"
		local -r root_dir="${git_dir/%"/.git"/}"
		local -r sep=':'
		printf ' '

		# Bare repository case
		if [ "$(git rev-parse --is-bare-repository 2>/dev/null)" = "true" ]; then
			printf "$(basename -s .git "$git_dir")"
			return
		fi

		# Repository name
		local -r url="$(git config --get remote.origin.url)"
		local -r repo_name="$(basename -s .git "${url:-$root_dir}")"
		printf "$repo_name"

		# Branch
		local branch="$(git branch --show-current)"
		[ -z "$branch" ] && branch="$(git -C "$root_dir" rev-parse --short HEAD)"
		printf "$sep$branch"

		# Status
		local -r git_status="$(__git_status "$root_dir")"
		[ "$git_status" ] && printf "$sep$git_status"

		# TODO Unpushed commits
	fi
	printf "$__norm"
}

# Set up colors
# https://spec.draculatheme.com/
__green=$(__colorcode_from_rgb 80 250 123)
__purple=$(__colorcode_from_rgb 189 147 249)
__red=$(__colorcode_from_rgb 255 85 85)
__pink=$(__colorcode_from_rgb 255 121 198)
__bold="\033[1m"
__norm="\033[0m"

# Draws the prompt
__python_prompt() {
	local sep=' '
	# conda
	[ "$CONDA_DEFAULT_ENV" ] && printf "$sep${__green}conda:%s$__norm" "$CONDA_DEFAULT_ENV" && sep=' '
	# venv
	[ "$VIRTUAL_ENV" ] && printf "$sep${__green}venv:%s$__norm" "$VIRTUAL_ENV" && sep=' '
}

__return_code_prompt() {
	[ "$__last_return_code" -ne 0 ] && printf " $__bold$__red$__last_return_code$__norm"
	printf "$__norm"
}

__path="$__bold$__purple\w$__norm"

# used in terminal options such as "new tabs inherit current working directory"
# shellcheck disable=all
osc7_cwd() {
	# as stolen from foot term wiki
	local strlen=${#PWD}
	local encoded=""
	local pos c o
	for ((pos = 0; pos < strlen; pos++)); do
		c=${PWD:pos:1}
		case "$c" in
			[-/:_.!\'\(\)~[:alnum:]]) o="${c}" ;;
			*) printf -v o '%%%02X' "'${c}" ;;
		esac
		encoded+="${o}"
	done
	printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}

# Capture last return code
# Make new terminal instances use CWD
PROMPT_COMMAND='__last_return_code=$?;'osc7_cwd

PS1="\n $__path\$(__git_prompt)\$(__python_prompt)\$(__return_code_prompt)\n "
PS2='│'
