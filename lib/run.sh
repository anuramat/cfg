#!/usr/bin/env bash

fail="$(tput setaf 1 bold)"
ok="$(tput setaf 2 bold)"
normal="$(tput sgr0)"

run() {
	# $1: file mimetype
	# $2: check command
	# $3: if not empty:
	#	  - output colorized OK/FAIl at the EOL
	#	  - `printf "$3" "filename"\n` for every file
	find . ! -path '*/.git/*' -print0 | while IFS= read -r -d '' filename; do
		if [ "$(file "$filename" --mime-type --brief)" = "$1" ]; then
			result="$($2 "$filename")" \
				&& [ -n "$3" ] \
				&& { printf "$ok%$(tput cols)s\r$normal" "OK" || printf "$fail%$(tput cols)s\r$normal" "FAIL"; }
			[ -n "$3" ] && printf "$3\n" "$filename"
			[ -n "$result" ] && echo "$result"
		fi
	done
}
