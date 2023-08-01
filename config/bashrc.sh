#!/usr/bin/env bash
# shellcheck disable=SC2139
default_exa="exa --group-directories-first --group --icons --header --git"
alias f="nvim"
alias ls="$default_exa"
alias ll="$default_exa --long"
alias la="$default_exa --long --all"
alias tree="$default_exa --tree"
alias j="z"
export LC_ALL="en_US.UTF-8"
export PATH="$HOME/go/bin${PATH:+:$PATH}"
export PATH="/opt/homebrew/bin${PATH:+:$PATH}"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export _ZO_RESOLVE_SYMLINKS="1"
eval "$(brew shellenv)"
eval "$(zoxide init bash)"

gitprompt() {
	# Check if we're in a Git repository
	if [ -d .git ] || git rev-parse --git-dir >/dev/null 2>&1; then
		repo_name=$(basename "$(git rev-parse --show-toplevel)")
		branch=$(git symbolic-ref --short HEAD 2>/dev/null)
		if [ -z "$branch" ]; then
			branch=$(git rev-parse --short HEAD 2>/dev/null)
		fi
		echo "  ~  $repo_name/$branch"
	else
		# Not in a Git repository
		echo ""
	fi
}

PS1='\n$PWD$(gitprompt)\n➜ '
PS2='│'

[ -f ~/.fzf.bash ] && source "$HOME/.fzf.bash"
