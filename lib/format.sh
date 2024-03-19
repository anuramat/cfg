#!/usr/bin/env bash
. lib/run.sh

shell() {
	run 'text/x-shellscript' 'shfmt -w -l -s -ci -bn -kp'
}
