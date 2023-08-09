.PHONY: check lua shell

check: lua shell

lua:
	luacheck . --globals=vim

maxdepth=30# max path length in chars, starting from "./"
fmtstr="Checking %$(maxdepth)s: "
GRN=\033[1;32m%s\033[0m # green bold text
RED=\033[1;31m%s\033[0m # red bold text
shell:
	fd -0ug "**.sh" | xargs -0I{} sh -c 'printf $(fmtstr) "{}" && shellcheck -o all "{}" && printf "$(GRN)\n" OK || printf "$(RED)\n" FAIL'
