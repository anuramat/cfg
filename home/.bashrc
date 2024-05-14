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
__markdown=markdown+lists_without_preceding_blankline+mark+wikilinks_title_after_pipe
hotmd-unwrapped() {
	# $1 - markdown file path

	local -r dir='/tmp/hotmd'
	mkdir -p "$dir"
	# generate random filename
	local -r path="$dir/$(shuf -er -n16 {a..z} {0..9} | tr -d '\n')".pdf
	# put in the basic pdf so that zathura doesn't shit itself
	local -r pdf_minimal='JVBERi0xLgoxIDAgb2JqPDwvUGFnZXMgMiAwIFI+PmVuZG9iagoyIDAgb2JqPDwvS2lkc1szIDAgUl0vQ291bnQgMT4+ZW5kb2JqCjMgMCBvYmo8PC9QYXJlbnQgMiAwIFI+PmVuZG9iagp0cmFpbGVyIDw8L1Jvb3QgMSAwIFI+Pg=='
	echo "$pdf_minimal" | base64 -d >"$path"

	# open zathura
	(zathura "$path" >/dev/null 2>&1) &
	local -r zathura_pid="$!"

	# start entr
	echo "$1" | entr -n pandoc -H "$XDG_CONFIG_HOME/latex/packages.tex" "$1" -f "$__markdown" -t pdf -o "$path" &
	local -r entr_pid="$!"

	# kill entr if zathura is closed
	wait "$zathura_pid"
	kill "$entr_pid"

	# clean up
	rm "$path"
}
hotmd() {
	# $1 - markdown file path
	hotmd-unwrapped "$1" &
	disown
}
z() {
	zathura "$1" &>/dev/null &
	disown && exit
}
