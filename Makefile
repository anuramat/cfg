SHELL := /bin/bash

.PHONY: all
all: lua_lint sh_lint

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Lua ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

.PHONY: lua_fmt
lua_fmt:
	@ echo -e "\nFormatting Lua files"
	@ stylua .

.PHONY: lua_lint
lua_lint: lua_fmt
	@ echo -e "\nChecking Lua files"
	@ luacheck . --globals=vim | ghead -n -2

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Shell ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

.PHONY: sh_fmt
sh_fmt: 
	@ # write, list, simplify, case-indent, binary-newline, keep-padding
	@ # keep padding,
	@ echo -e "\nFormatting shell scripts"
	@ fd -0ug "*.sh" | xargs -0I{} shfmt -w -l -s  -ci -bn -kp {} 

width=35
GRN=\033[1;32m%s\033[0m # green bold text
RED=\033[1;31m%s\033[0m # red bold text
.PHONY: sh_lint
sh_lint: sh_fmt
	@ echo -e "\nChecking shell scripts"
	@ fd -0ug "*.sh" -x sh -c 'printf "%-$(width)s" "Checking {}: " && shellcheck --color=always -o all "{}" && printf "$(GRN)\n" OK || printf "$(RED)\n" FAIL'
	@ echo -e "$(shell fd -ug "*.sh" | wc -l | tr -d " ") files total"
posix:
	@ echo -e "\nChecking shell scripts (forced POSIX, ignoring shebangs)"
	@ fd -0ug "*.sh" -x sh -c 'printf "%-$(width)s" "Checking {}: " && shellcheck --color=always -s sh -o all "{}" && printf "$(GRN)\n" OK || printf "$(RED)\n" FAIL'
	@ echo -e "$(shell fd -ug "*.sh" | wc -l | tr -d " ") files total"
