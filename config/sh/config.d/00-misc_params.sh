#!/usr/bin/env sh

export SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# ls
export EZACMD="eza --group-directories-first --group --header --git --color=always --icons=always --color-scale=all"
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

# colorize some basic stuff
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -c=auto'

# etc
alias fd="fd -H" # H for show hidden, I for show ignored
alias info="info --vi-keys"
alias swayimg='swayimg -e '\''rm -- "%"'\'
export GRIM_DEFAULT_DIR="$SCREENSHOT_DIR"
export TERMCMD="alacritty"            # used by rifle (ranger file opener)
export VIRTUAL_ENV_DISABLE_PROMPT="1" # Don't let python venvs change the PS1
export VIMTEX_OUTPUT_DIRECTORY="/tmp/"
export NO_AT_BRIDGE=1 # hides gnomeWARNING **: Couldn't connect to accessibility bus:
