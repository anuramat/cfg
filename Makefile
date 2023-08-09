.PHONY: check lua shell

check: lua shell

lua:
	# ~~~~~~~~~~~~~~~~~~~~~ Luacheck ~~~~~~~~~~~~~~~~~~~~~~ #
	luacheck . --globals=vim

width=35
GRN=\033[1;32m%s\033[0m # green bold text
RED=\033[1;31m%s\033[0m # red bold text
shell:
	# ~~~~~~~~~~~~~~~~~~~~ Shellcheck ~~~~~~~~~~~~~~~~~~~~~ #
	fd -0ug "**.sh" | xargs -0I{} sh -c 'printf "%-$(width)s" "Checking {}: " && shellcheck -o all "{}" && printf "$(GRN)\n" OK || printf "$(RED)\n" FAIL'
