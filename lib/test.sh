#!/usr/bin/env bash

heading="$(tput setaf 5 bold)"
fail="$(tput setaf 1 bold)"
ok="$(tput setaf 2 bold)"
normal="$(tput sgr0)"

check() {
	# $1 - file mimetype
	# $2 - check command
	find . ! -path '*/.git/*' -print0 | while IFS= read -r -d '' file; do
		if [ "$(file "$file" --mime-type --brief)" = "$1" ]; then
			result="$($2 "$file")" && printf "$ok%$(tput cols)s\r$normal" "OK" || printf "$fail%$(tput cols)s\r$normal" "FAIL"
			echo "Checking $file:"
			[ -n "$result" ] && echo "$result"
		fi
	done
}

autoshell() {
	echo "${heading}Checking shell scripts$normal"
	check 'text/x-shellscript' 'shellcheck --color=always -o all'
}

posix() {
	echo "${heading}Checking shell scripts for POSIX compatibility$normal"
	check 'text/x-shellscript' 'shellcheck --color=always -s sh -o all'
}
