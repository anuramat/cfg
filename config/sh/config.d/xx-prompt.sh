#!/usr/bin/env sh

# used in terminal options such as "new tabs inherit current working directory"
# shellcheck disable=all
__osc7_cwd() {
	# as stolen from foot term wiki
	local strlen=${#PWD}
	local encoded=""
	local pos c o
	for ((pos = 0; pos < strlen; pos++)); do
		c=${PWD:pos:1}
		case "$c" in
			[-/:_.!\'\(\)~[:alnum:]]) o="${c}" ;;
			*) printf -v o '%%%02X' "'${c}" ;;
		esac
		encoded+="${o}"
	done
	printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}

PROMPT_COMMAND+='__osc7_cwd'
