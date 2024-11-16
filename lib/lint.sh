#!/usr/bin/env bash
. lib/shrun.sh

shell() {
	shrun 'shellcheck --color=always -o all'
}

posix() {
	shrun 'shellcheck --color=always -s sh -o all'
}
