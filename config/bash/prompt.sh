#!/usr/bin/env bash

# Don't let python venvs change the PS1
export VIRTUAL_ENV_DISABLE_PROMPT="1"

# Converts RGB values to 24-bit color escape code
__colorize() {
	# $1, $2, $3 - RGB
	# $4 - text
	[ "$(tput colors)" -eq 256 ] && printf "\033[38;2;%s;%s;%sm" "$1" "$2" "$3"
}

__git_prompt() {
	local git_dir
	if git_dir="$(git rev-parse --git-dir 2>/dev/null)"; then
		git_dir="$(realpath "$git_dir")"

		# Bare repository
		if [ "$(git rev-parse --is-bare-repository 2>/dev/null)" = "true" ]; then
			printf "$(basename -s .git "$git_dir")"
			return
		fi

		local -r root_dir="$(realpath "$git_dir"/..)"

		# Repository name
		local -r url="$(git config --get remote.origin.url)"
		local -r path="$(dirname "$git_dir")"
		local -r repo_name="$(basename -s .git "${url:-$path}")"
		printf "$repo_name"

		# Branch
		local branch="$(git branch --show-current)"
		[ -z "$branch" ] && branch="$(git -C "$root_dir" rev-parse --short HEAD)"
		printf ":$branch"

		# Status
		local -r porcelain="$(git -C "$root_dir" status --porcelain)"
		[ "$git_status" ] && printf ":$git_status"

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
__python() {
	local -r sep=" "
	local need_sep

	printf " "

	# conda
	[ "$CONDA_DEFAULT_ENV" ] && printf "${__green}conda:%s$__norm" "$CONDA_DEFAULT_ENV" && need_sep="true"

	[ "$need_sep" = "true" ] && printf "$sep"

	# venv
	[ "$VIRTUAL_ENV" ] && printf "${__green}venv:%s$__norm" "$VIRTUAL_ENV" && need_sep="true"
}

__status() {
	[ "$__status" -ne 0 ] && printf "$__bold$__red%s$__norm" "$__status"
}

__path="$__bold$__purple\w$__norm"

PROMPT_COMMAND='__status=$?' # Capture last return code
PS1="\n $__path\$(__git_prompt) \$(__status)\n "
PS2='│'
