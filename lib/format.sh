#!/usr/bin/env bash
. lib/shrun.sh

shell() {
	shrun 'shfmt -w -l -s -ci -bn -kp'
}
