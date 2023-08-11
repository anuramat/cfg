#!/usr/bin/env bash

install_gobins() {
	local -r gobins=$1
	[ -f "${gobins}" ] || {
		echo "${gobins} does not exist" && return 1
	}
	while read -r package; do
		[ "${package}" ] || {
			continue
		}
		echo "[cfg] installing $(echo "${package}" | sed -e 's/.*\///g')"
		go install "${package}"
	done <"${gobins}"
}
install_gobins "gobins.txt"
