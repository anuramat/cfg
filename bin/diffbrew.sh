#!/usr/bin/env bash
echo "Wait for it..."
new_packages="$(comm -13 <(sort Brewfile) <(sort <(brew bundle dump --file - --no-lock)))"
count="$(echo "${new_packages}" | grep -vc '^$')"
[ -z "${new_packages}" ] && printf "Nothing new" && exit 0
printf "%s new line" "${count}"
[ "${count}" -ne 1 ] && printf "s"
printf " in the right diff:\n"
echo "${new_packages}"
