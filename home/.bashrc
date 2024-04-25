#!/usr/bin/env bash

shopt -s globstar autocd
# globstar - Enables ** for recursing into subdirectories
# autocd   - `cd path` -> `path`

# number of commands stored in memory
export HISTSIZE=-1
# number of commands stored in file
export HISTFILESIZE=-1

. "$HOME/.profile"
for f in "$XDG_CONFIG_HOME"/sh/config.d/*; do . "$f"; done

# ~~~~~~~~~~~~~~~ software initialization ~~~~~~~~~~~~~~~~ #

if command -v fzf-share >/dev/null; then
	source "$(fzf-share)/key-bindings.bash"
	source "$(fzf-share)/completion.bash"
fi
# next two lines append commands to $PROMPT_COMMAND
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash --cmd j --hook pwd)"
source <(cod init $$ bash)
eval "$(starship init bash)" # "eats" $PROMPT_COMMAND

# ~~~~~~~~~~~~~~~~~~~~~ some aliases ~~~~~~~~~~~~~~~~~~~~~ #
upload() {
	curl -F"file=@$1" https://0x0.st
}
upload2() {
	curl --upload-file "$1" "https://transfer.sh/$1"
}
cheat() {
	echo "$@" | tr " " "+" | xargs -I{} curl -m 10 "http://cheat.sh/{}" 2>/dev/null
}
alias c="clear"
alias t="tldr"
alias f="nvim"
alias d="xdg-open"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
getmd() {
	readable "$1" | pandoc -f html -s -t markdown_mmd -M source-url="$1"
}
alias pandoc-tex='pandoc -H "$XDG_CONFIG_HOME/latex/packages.tex"'
z() {
	zathura "$1" &
	disown && exit
}
