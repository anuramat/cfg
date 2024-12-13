#!/usr/bin/env bash

if [ -d "$1" ]; then
	# preview the directory (tree): eza > tree > ls
	if command -v "eza" &> /dev/null; then
		# $EZACMD --tree "$1"
		$EZACMD --grid "$1"
		exit
	fi
	if command -v "tree" &> /dev/null; then
		tree -C "$1"
		exit
	fi
	ls -a "$1"
	exit

elif [ -f "$1" ]; then
	timg -p s "-g${FZF_PREVIEW_COLUMNS}x$FZF_PREVIEW_LINES" $1 && exit
	# preview file contents: bat > cat
	if command -v "bat" &> /dev/null; then
		bat --style=numbers --color=always "$1" && exit
	fi
	cat "$1" && exit
fi
