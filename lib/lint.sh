#!/usr/bin/env bash
. lib/shrun.sh

shell() {
	shrun 'shellcheck --color=always -o all'
}
