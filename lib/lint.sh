#!/usr/bin/env bash
. lib/run.sh

shell() {
	run 'text/x-shellscript' 'shellcheck --color=always -o all' 'Checking file %s'
}

posix() {
	run 'text/x-shellscript' 'shellcheck --color=always -s sh -o all' 'Checking file %s'
}
