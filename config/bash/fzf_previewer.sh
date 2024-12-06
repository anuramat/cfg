#!/usr/bin/env bash

if [ -d "$1" ]; then
	# preview the directory tree: eza > tree > ls
	if command -v "eza" > /dev/null 2>&1; then
		$EZACMD --tree "$1"
		exit
	fi
	if command -v "tree" > /dev/null 2>&1; then
		tree -C "$1"
		exit
	fi
	ls -a "$1"
	exit

elif [ -f "$1" ]; then
	# preview file contents: bat > cat
	if command -v "bat" > /dev/null 2>&1; then
		bat -n --color=always "$1"
		exit
	fi
	cat "$1"
	exit
fi
