#!/usr/bin/env bash
# shellcheck disable=SC2086

if [ -d $1 ]; then
	if command -v "exa" >/dev/null 2>&1; then
		exa --tree --icons $1
		exit
	fi

	if command -v "tree" >/dev/null 2>&1; then
		tree -C $1
		exit
	fi

	ls -a $1
	exit
fi

if [ -f $1 ]; then
	if command -v "bat" >/dev/null 2>&1; then
		bat -n --color=always $1
		exit
	fi

	cat $1
	exit
fi
