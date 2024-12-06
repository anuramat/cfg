#!/usr/bin/env bash
exit 0 # doesn't work yet
shrun() {
fail_color="$(tput setaf 1 bold)"
ok_color="$(tput setaf 2 bold)"
normal_color="$(tput sgr0)"

# pretty-runs a file linter/formatter on all sh files
local command="$1" # the command that checks the file
# find all shell files first

fd -t f -H0 . | while IFS= read -r -d '' filename; do
	head -n 1 "$filename" | grep -q "^#!.*sh" && echo "$filename"
done | while IFS= read -r -d '' filename; do
	# print the filename
	printf "$filename"
	# run the command, outputting status to the right of the filename
	result="$($command "$filename")" \
		&& printf "$ok_color%$(($(tput cols) - 2 - ${#filename}))s\r$normal_color" "OK" \
		|| printf "$fail_color%$(($(tput cols) - 1 - ${#filename}))s\r$normal_color" "FAIL"
	echo ''
	# print the results of the command (if any)
	[ -n "$result" ] && echo "$result"
done
true # to shield the outer shell from a non-zero exit code
}

shrun "$@"
