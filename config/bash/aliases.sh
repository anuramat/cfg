#!/usr/bin/env bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ convenience ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

upload() {
	curl --upload-file "$1" "https://transfer.sh/$1"
}
cheat() {
	curl -m 10 "http://cheat.sh/${1}" 2>/dev/null || printf '%s\n' "[ERROR] Something broke"
}
alias c="clear"
alias t="tldr"
alias f="nvim"
alias v="neovide && exit"
alias d="xdg-open"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ configuration ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

alias info="info --vi-keys"

# ls
if command -v "eza" >/dev/null 2>&1; then
	# config file implementation is in progress:
	# https://github.com/eza-community/eza/issues/897
	alias ls="$EZACMD"
	alias ll="$EZACMD --long"
	alias la="$EZACMD --long --all"
	alias lt="$EZACMD --long --sort=time"
	alias tree="$EZACMD --tree"
	alias treedir="$EZACMD --tree --only-dirs"
else
	alias ls="ls --color=auto"
	alias ll="ls -lth --color=auto"
	alias la="ls -alth --color=auto"
fi

alias fd="fd -H" # H for show hidden, I for show ignored

# colorize some basic stuff
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -c=auto'
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ fzf ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~ default command ~~~~~~~~~~~~~~~~~~~~ #
if command -v "fd" >/dev/null 2>&1; then
	export FZF_DEFAULT_COMMAND="fd ."
	export FZF_ALT_C_COMMAND="fd . -t d --strip-cwd-prefix"
	export FZF_CTRL_T_COMMAND="fd . -t f --strip-cwd-prefix"
fi
# ~~~~~~~~~~~~~~~~~~~~~ default opts ~~~~~~~~~~~~~~~~~~~~~ #
export FZF_DEFAULT_OPTS="
--preview='$XDG_CONFIG_HOME/bash/fzf_previewer.sh {}'
--layout=reverse
--keep-right
--info=inline
--tabstop=2
--multi
--height=50%

--bind='ctrl-/:change-preview-window(down|hidden|)'
--bind='ctrl-j:accept'
--bind='tab:toggle+down'
--bind='btab:toggle+up'

--bind='ctrl-y:preview-up'
--bind='ctrl-e:preview-down'
--bind='ctrl-u:preview-half-page-up'
--bind='ctrl-d:preview-half-page-down'
--bind='ctrl-b:preview-page-up'
--bind='ctrl-f:preview-page-down'
"
# ~~~~~~~~~~~~~~~~~~~~~~~~ zoxide ~~~~~~~~~~~~~~~~~~~~~~~~ #
__zo_fzf_preview='ls --color=always -Cp'
if command -v "eza" >/dev/null 2>&1; then
	__zo_fzf_preview="$EZACMD --group-directories-first --icons --grid"
fi
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS
--no-sort
--exit-0
--select-1
--preview='$__zo_fzf_preview {2..}'
"
export _ZO_RESOLVE_SYMLINKS="1"
