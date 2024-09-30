#!/usr/bin/env bash

shopt -s globstar
# globstar - Enables ** for recursing into subdirectories

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
# zoxide, cod, direnv append hooks to $PROMPT_COMMAND
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash --cmd j --hook pwd)"
# source <(cod init $$ bash) # off, popup on every help is really annoying
eval "$(direnv hook bash)"
eval "$(starship init bash)" # "eats" $PROMPT_COMMAND

# ~~~~~~~~~~~~~~~~~~~~~ some aliases ~~~~~~~~~~~~~~~~~~~~~ #

# uploads a file, sends link to stdout AND pastebin
upload() {
	curl -F "file=@$1" https://0x0.st | tee >(wl-copy)
}
# searches on cheat.sh
cheat() {
	echo "$@" | tr " " "+" | xargs -I{} curl -m 10 "http://cheat.sh/{}" 2>/dev/null | less
}
alias t="tgpt"
alias f="nvim"
alias d="xdg-open"
alias open="xdg-open"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias sus="systemctl suspend"
pandoc-web() {
	readable "$1" | pandoc -f html -s -t markdown_mmd -M source-url="$1"
}
pandoc-tex() {
	pandoc -H "$XDG_CONFIG_HOME/latex/preamble.tex" "$1" -o "$2"
}
pandoc-md() {
	__markdown=markdown+lists_without_preceding_blankline+mark+wikilinks_title_after_pipe+citations
	pandoc -H "$XDG_CONFIG_HOME/latex/preamble.tex" "$1" --citeproc -f "$__markdown" -o "$2"
}
# renders a markdown file to pdf, opens in zathura, rerenders on save
hot-doc() {
	__markdown=markdown+lists_without_preceding_blankline+mark+wikilinks_title_after_pipe+citations
	# $1 - markdown file path

	local -r dir='/tmp/hotmd'
	mkdir -p "$dir"
	# generate random filename
	# TODO maybe use mktemp
	local -r path="$dir/$(shuf -er -n16 {a..z} {0..9} | tr -d '\n')".pdf
	# put in the basic pdf so that zathura doesn't shit itself
	local -r pdf_minimal='JVBERi0xLgoxIDAgb2JqPDwvUGFnZXMgMiAwIFI+PmVuZG9iagoyIDAgb2JqPDwvS2lkc1szIDAgUl0vQ291bnQgMT4+ZW5kb2JqCjMgMCBvYmo8PC9QYXJlbnQgMiAwIFI+PmVuZG9iagp0cmFpbGVyIDw8L1Jvb3QgMSAwIFI+Pg=='
	echo "$pdf_minimal" | base64 -d >"$path"

	# open zathura
	(zathura "$path" >/dev/null 2>&1) &
	local -r zathura_pid="$!"

	# start entr
	echo "$1" | entr -n pandoc-md "$1" "$path" &
	local -r entr_pid="$!"

	# kill entr if zathura is closed
	wait "$zathura_pid"
	kill "$entr_pid"

	# clean up
	rm "$path"
}
# opens with zathura in a new window
Z() {
	zathura "$1" &>/dev/null &
	disown
}
# open with zathura "in this window"
z() {
	Z "$1" && exit
}
# set brightness for an external monitor
brexit() {
	ddcutil setvcp 10 "$1" --display 1
}
# tts
say_unwrapped() {
	[ -z "$XDG_CACHE_HOME" ] && echo 'empty $XDG_CACHE_HOME' && return 1
	local cache_dir="$XDG_CACHE_HOME/piper/"
	mkdir -p "$cache_dir"

	# https://github.com/rhasspy/piper/blob/master/VOICES.md
	# prefer m, h are too noisy
	#	robots:
	#	- ljspeech hm - 5/5, sc2 adjutant/mommy vibes, high pitch
	#	- libritts_r m - 5/5, the only natural sounding one
	#	- kristin m - 4/5, great, glados vibes, low pitch
	#	- bryce m - 4/5, jarvis vibes, male amy
	#	- amy ml - 3/5, monotone, sci-fi assistant vibes, high pitch
	local name="$1"
	local quality="medium" # in low, medium, high
	local locale="en_US"

	local model_url="https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/${locale:0:2}/$locale/$name/$quality/$locale-$name-$quality.onnx?download=true"
	local config_url="https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/${locale:0:2}/$locale/$name/$quality/$locale-$name-$quality.onnx.json?download=true.json"

	local model_file="$cache_dir/$locale-$name-$quality.onnx"
	local config_file="$cache_dir/$locale-$name-$quality.json"

	[ -s "$model_file" ] || {
		printf '\n\tdownloading the model\n\n' && wget -q --show-progress -O "$model_file" "$model_url"
	} || {
		\printf '\terror, check the model name\n'
		rm "$model_file" && return 1
	}

	[ -s "$config_file" ] || {
		printf '\n\tdownloading the config\n\n' && wget -q --show-progress -O "$config_file" "$config_url"
	} || {
		\printf '\terror, check the model name\n'
		rm "$config_file" && return 1
	}

	echo "$2" \
		| piper --speaker 0 --length_scale 1 --noise_w 0 --noise_scale 0 --sentence_silence 0.3 -m "$model_file" -c "$config_file" -q -f -
}
say() {
	say_unwrapped "ljspeech" "$*" | play -t wav -q -
}
# vim: fdl=0
