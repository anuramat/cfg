#!/usr/bin/env bash

shopt -s globstar # enables **

export HISTSIZE=-1
export HISTFILESIZE=-1

source "$HOME/.profile"
for f in "$XDG_CONFIG_HOME"/sh/config.d/*; do source "$f"; done

if command -v fzf-share >/dev/null; then
	source "$(fzf-share)/key-bindings.bash"
	source "$(fzf-share)/completion.bash"
fi
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash --cmd j --hook pwd)" # appends
eval "$(direnv hook bash)"                                                         # appends
eval "$(starship init bash)"                                                       # replaces
# source "$(blesh-share)/ble.sh" # buggy, ugly, slow, but cool
# color rice:
[ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ] && [[ $TERM != foot ]] && (cat ~/.cache/wallust/sequences &)
# TODO test if foot and other terms are in sync

alias f="nvim"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias sus="systemctl suspend"
alias peco="fzf --height=100 --preview=''"
alias lab="jupyter-lab --ServerApp.iopub_msg_rate_limit 9999999999999"

# -- uploads a file, sends link to stdout AND pastebin
upload() {
	local filename="$1"
	[ -z "$1" ] && filename="-"
	curl -F "file=@$filename" https://0x0.st | tee >(wl-copy)
}
# random $n # -- random alnum string
random() {
	shuf -er -n "$1" {a..z} {0..9} | tr -d '\n'
}
# pandoc-web $link > output.md # -- saves a website to a markdown document
pandoc-web() {
	readable "$1" | pandoc -f html -s -t markdown_mmd -M source-url="$1"
}
# c i.md o.pdf
pandoc-md() {
	__markdown=markdown+lists_without_preceding_blankline+mark+wikilinks_title_after_pipe+citations
	pandoc -H "$XDG_CONFIG_HOME/latex/preamble.tex" "$1" --citeproc -f "$__markdown" -t pdf -o "$2"
}
# say_unwrapped "model" "text"
say_unwrapped() {
	[ -z "$XDG_CACHE_HOME" ] && echo 'empty $XDG_CACHE_HOME' && return 1
	local cache_dir="$XDG_CACHE_HOME/piper/"
	mkdir -p "$cache_dir"

	# https://github.com/rhasspy/piper/blob/master/VOICES.md
	# prefer medium quality, as high is too noisy
	#	robots:
	#	- ljspeech hm - 5/5, sc2 adjutant/mommy vibes, high pitch
	#	- libritts_r m - 5/5, the only natural sounding one
	#	- kristin m - 4/5, great, glados vibes, low pitch
	#	- bryce m - 4/5, jarvis vibes, male amy
	#	- amy ml - 3/5, monotone, sci-fi assistant vibes, high pitch
	local name="$1"
	local quality="medium" # low/medium/high
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

	echo "$2" |
		piper --speaker 0 --length_scale 1 --noise_w 0 --noise_scale 0 --sentence_silence 0.3 -m "$model_file" -c "$config_file" -q -f -
}
# say some stuff
say() {
	say_unwrapped "ljspeech" "$*" | play -t wav -q -
}
# renders $1.md to pdf, opens in zathura, rerenders on save
hotdoc() {
	__markdown=markdown+lists_without_preceding_blankline+mark+wikilinks_title_after_pipe+citations

	# create file
	local -r path="$(mktemp -p /tmp XXXXXX.pdf)"
	# initialize it with a basic pdf so that zathura doesn't shit itself
	echo 'JVBERi0xLgoxIDAgb2JqPDwvUGFnZXMgMiAwIFI+PmVuZG9iagoyIDAgb2JqPDwvS2lkc1szIDAgUl0vQ291bnQgMT4+ZW5kb2JqCjMgMCBvYmo8PC9QYXJlbnQgMiAwIFI+PmVuZG9iagp0cmFpbGVyIDw8L1Jvb3QgMSAwIFI+Pg==' |
		base64 -d >"$path"

	# open zathura
	zathura "$path" &>/dev/null &
	local -r zathura_pid="$!"

	# start watching for changes
	(export -f pandoc-md && echo "$1" | entr -cns "pandoc-md \"$1\" \"$path\"") &
	local -r entr_pid="$!"

	# kill entr if zathura is closed
	wait "$zathura_pid"
	kill "$entr_pid"

	# clean up
	rm "$path"
}
# open with zathura
z() {
	zathura "$1" &>/dev/null &
	disown
}
# set brightness for an external monitor
brexit() {
	ddcutil setvcp 10 "$1" --display 1
}
# beep every $1 minutes
beep() {
	local -r period=$1
	[ -n "$period" ] || {
		echo -e 'Invalid arguments\nUsage:\n\tbeep 45'
		return 1
	}

	while true; do
		local hours=$(date +%H)
		local minutes=$(date +%M)
		(say "Current time: $hours $minutes" &)
		sleep $((period * 60))
	done
}

# cd <- fzf <- ghq list
g() {
	# optional: $1 - query; then you cd to the best match
	local -r root="$(ghq root)"
	local -r repo_relative_paths="$(fd . "$root" --exact-depth 3 | sed "s#${root}/##")"
	local chosen_path
	# cd $root so that fzf preview works properly
	[ -n "$1" ] && {
		chosen_path=$(cd "$root" && echo "$repo_relative_paths" | fzf -f "$1" | head -n 1) || return
	} || chosen_path=$(cd "$root" && echo "$repo_relative_paths" | fzf) || return
	cd "$root/$chosen_path" || return
}
__ghq_fzf_base() {
	# stdin - \n separated list of repos
	# $1 - prompt question
	# stdout - \n separated list of repos
	local repos
	repos="$(fzf)" || return 1
	echo "$repos"

	echo 'selected repositories:' >&2
	printf "\t$repos" | sed -z 's/\n/\n\t/g' >&2
	echo >&2

	read -rs -n 1 -p $"$1 (y/*):"$'\n' choice <&2
	[ "$choice" = 'y' ]
}
# ghq rm <- fzf <- ghq list
grm() {
	local repos
	repos=$(ghq list | __ghq_fzf_base "delete?") || return
	echo "$repos" | xargs -I{} bash -c 'yes | ghq rm {} 2>/dev/null'
}
# ghq get <- fzf <- gh repo list
gg() {
	# optional $1 - owner
	local -r before_dirs="$(ghq list -p | sort)"
	local repos
	repos="$(gh repo list "$1" | cut -f 1 | __ghq_fzf_base "download?")" || return
	ghq get -P -p $repos
	local -r after_dirs="$(ghq list -p | sort)"
	local -r new_dirs="$(comm -13 <(echo "$before_dirs") <(echo "$after_dirs"))"
	zoxide add $new_dirs
	echo "$new_dirs" | xargs -I{} bash -c 'cd {}; gh repo set-default $(git config --get remote.origin.url | rev | cut -d "/" -f 1,2 | rev)'
}
ghsync() {
	gh repo sync "$(gh repo set-default --view)"
}

# send full path of a file to clipboard
c() {
	# c for copy
	realpath "$@" | tr '\n' ' ' | wl-copy -n
}
r() {
	# r for rice
	wallust "$@" || return
	"$XDG_CONFIG_HOME/mako/wal.sh"
	swaymsg reload
}
# vim: fdl=0
