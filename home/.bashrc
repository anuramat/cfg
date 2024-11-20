#!/usr/bin/env bash

shopt -s globstar # enables **

export HISTSIZE=-1
export HISTFILESIZE=-1

. "$HOME/.profile"
for f in "$XDG_CONFIG_HOME"/sh/config.d/*; do . "$f"; done

# ~~~~~~~~~~~~~~~ software initialization ~~~~~~~~~~~~~~~~ #

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

# ~~~~~~~~~~~~~~~~~~~~~ aliases {{{1 ~~~~~~~~~~~~~~~~~~~~~ #

alias t="tldr"
alias f="nvim"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias sus="systemctl suspend"
alias peco="fzf --height=100 --preview=''"

# ~~~~~~~~~~~~~~~~~~~~ functions {{{1 ~~~~~~~~~~~~~~~~~~~~ #

# uploads a file, sends link to stdout AND pastebin
upload() {
	curl -F "file=@$1" https://0x0.st | tee >(wl-copy)
}
# searches on cheat.sh
cheat() {
	echo "$@" | tr " " "+" | xargs -I{} curl -m 10 "http://cheat.sh/{}" 2>/dev/null | less
}
# random 16 > o.txt
random() {
	shuf -er -n "$1" {a..z} {0..9} | tr -d '\n'
}
# pandoc-web https://example.com > o.md
pandoc-web() {
	readable "$1" | pandoc -f html -s -t markdown_mmd -M source-url="$1"
}
# pandoc-tex i.tex o.pdf
pandoc-tex() {
	pandoc -H "$XDG_CONFIG_HOME/latex/preamble.tex" "$1" -o "$2"
}
# pandoc-tex i.md o.pdf
pandoc-md() {
	__markdown=markdown+lists_without_preceding_blankline+mark+wikilinks_title_after_pipe+citations
	pandoc -H "$XDG_CONFIG_HOME/latex/preamble.tex" "$1" --citeproc -f "$__markdown" -o "$2"
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

	echo "$2" \
		| piper --speaker 0 --length_scale 1 --noise_w 0 --noise_scale 0 --sentence_silence 0.3 -m "$model_file" -c "$config_file" -q -f -
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
	echo 'JVBERi0xLgoxIDAgb2JqPDwvUGFnZXMgMiAwIFI+PmVuZG9iagoyIDAgb2JqPDwvS2lkc1szIDAgUl0vQ291bnQgMT4+ZW5kb2JqCjMgMCBvYmo8PC9QYXJlbnQgMiAwIFI+PmVuZG9iagp0cmFpbGVyIDw8L1Jvb3QgMSAwIFI+Pg==' \
		| base64 -d >"$path"

	# open zathura
	(zathura "$path" >/dev/null 2>&1) &
	local -r zathura_pid="$!"

	# start watching for changes
	export -f pandoc-md && echo "$1" | entr -cns "pandoc-md \"$1\" \"$path\"" &
	local -r entr_pid="$!"

	# kill entr if zathura is closed
	wait "$zathura_pid"
	kill "$entr_pid"

	# clean up
	rm "$path"
}
# open with zathura
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
# beep every $1 minutes
beep() {
	local -r period=$1
	[[ $period -le 60 ]] && [[ $((60 % $1)) == 0 ]] \
		|| {
			echo 'Illegal period'
			return 1
		}

	local -r offset_minutes=$((period - $(date +%M) % period))
	echo "Waiting for $offset_minutes minutes"
	sleep $((mins * 60))

	while true; do
		local hours=$(date +%H)
		local minutes=$(date +%M)
		(say "Current time: $hours $minutes" &)
		sleep $((period * 60))
	done
}
# basic pomodoro
pomo() {
	[[ $1 -gt 0 ]] && [[ $2 -gt 0 ]] || {
		echo -e 'Invalid arguments\nUsage:\n\tpomo 45 15'
		return 1
	}
	echo "Starting pomo: ${1}m on, ${2}m off"
	while true; do
		(say "Round started" &)

		echo On:
		sleep $(($1 * 60)) | pv -t
		(say "Round finished" &)
		notify-send 'pomo: off'

		echo Off:
		sleep $(($2 * 60)) | pv -t
		notify-send 'pomo: on'
	done
}
# jump to a ghq repo
g() {
	# g for git
	local -r root="$(ghq root)"
	local -r repo_relative_paths="$(fd . "$root" --exact-depth 3 | sed "s#${root}/##")"
	local -r chosen_path=$(cd "$root" && echo "$repo_relative_paths" | fzf)
	cd "$root/$chosen_path" || return
}
# send full path of a file to clipboard
c() {
	# c for copy
	realpath "$@" | tr '\n' ' ' | wl-copy -n
}
p() {
	# p for packages
	echo "$@" | tr " " "+" | xargs -I{} xdg-open "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}"
}
o() {
	# o for options
	echo "$@" | tr " " "+" | xargs -I{} xdg-open "https://search.nixos.org/options?channel=unstable&size=50&sort=relevance&type=packages&query={}"
}
r() {
	# r for rice
	wallust "$@" || return
	"$XDG_CONFIG_HOME/mako/wal.sh"
	swaymsg reload
}
# vim: fdl=0
