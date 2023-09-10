#!/usr/bin/env bash

# Don't let python venvs change the PS1
export VIRTUAL_ENV_DISABLE_PROMPT="1"

# Converts RGB values to 24-bit color escape code
__colorize() {
	# $1, $2, $3 - RGB
	# $4 - text
	[ "$(tput colors)" -eq 256 ] && printf "\033[38;2;%s;%s;%sm" "$1" "$2" "$3"
}

# Goes through "git status --porcelain=v1" output, searching for the letter
__grep_porce_letter() { # TODO naming (prob everywhere in this file)
	# $1 - target letter
	# $2 - output symbol (defautls to $1)
	grep -q -e "^.$1" -e "^$1." && {
		[ "$2" ] && printf "$2" && return
		printf "$1"
	}
}

__git_status() {
	# $1 - root dir
	local porcelain=$(git -C "$1" status --porcelain)
	printf "$(echo "$porcelain" | __grep_porce_letter A)" # A: addition of a file
	printf "$(echo "$porcelain" | __grep_porce_letter C)" # C: copy of a file into a new one
	printf "$(echo "$porcelain" | __grep_porce_letter D)" # D: deletion of a file
	printf "$(echo "$porcelain" | __grep_porce_letter M)" # M: modification of the contents or mode of a file
	printf "$(echo "$porcelain" | __grep_porce_letter R)" # R: renaming of a file
	printf "$(echo "$porcelain" | __grep_porce_letter T)" # T: change in the type of the file
	printf "$(echo "$porcelain" | __grep_porce_letter U)" # U: file is unmerged (you must complete the merge before it can be committed)
	printf "$(echo "$porcelain" | __grep_porce_letter X)" # X: "unknown" change type (most probably a bug, please report it)
}

__git() {
	printf "$__pink"
	local git_dir
	if git_dir="$(git rev-parse --git-dir 2>/dev/null)"; then
		git_dir="$(realpath "$git_dir")"
		local -r root_dir="$(dirname "$git_dir")"
		local -r sep=':'

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
__green=$(__colorize 80 250 123)
__purple=$(__colorize 189 147 249)
__red=$(__colorize 255 85 85)
__pink=$(__colorize 255 121 198)
__bold="\033[1m"
__norm="\033[0m"

# Draws the prompt
__python() {
	local -r sep=''
	# conda
	[ "$CONDA_DEFAULT_ENV" ] && printf "$sep${__green}conda:%s$__norm" "$CONDA_DEFAULT_ENV" && sep=' '
	# venv
	[ "$VIRTUAL_ENV" ] && printf "$sep${__green}venv:%s$__norm" "$VIRTUAL_ENV" && sep=' '
}

__status() {
	printf "$__bold__red"
	[ "$__status" -ne 0 ] && printf "$__status"
	printf "$__norm"
}

__path="$__bold$__purple\w$__norm"

PROMPT_COMMAND='__status=$?' # Capture last return code
PS1="\n $__path \$(__git) \$(__python) \$(__status)\n "
PS2='│'
