.PHONY: all
all: lua_lint sh_lint

.PHONY: lua_fmt
lua_fmt:
	# Formatting lua files...
	@ stylua .
	# Done.

.PHONY: lua_lint
lua_lint: lua_fmt
	# ~~~~~~~~~~~~~~~~~~~~~ Luacheck ~~~~~~~~~~~~~~~~~~~~~~ #
	@ luacheck . --globals=vim

.PHONY: sh_fmt
sh_fmt: 
	@ # write, list, simplify, case-indent, binary-newline, keep-padding
	@ # keep padding,
	@ fd -0ug "*.sh" | xargs -0 shfmt -w -l -s  -ci -bn -kp

width=35
GRN=\033[1;32m%s\033[0m # green bold text
RED=\033[1;31m%s\033[0m # red bold text
.PHONY: sh_lint
sh_lint: sh_fmt
	# ~~~~~~~~~~~~~~~~~~~~ Shellcheck ~~~~~~~~~~~~~~~~~~~~~ #
	@ fd -0ug "*.sh" -x sh -c 'printf "%-$(width)s" "Checking {}: " && shellcheck -o all "{}" && printf "$(GRN)\n" OK || printf "$(RED)\n" FAIL'
	@ echo
	@ echo "$(shell fd -ug "*.sh" | wc -l) files total"
