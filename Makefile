.PHONY: all
all: lua_format lua_lint shell_lint

.PHONY: lua_format
lua_format:
	# Formatting lua files...
	@stylua .
	# Done.

.PHONY: lua_lint
lua_lint:
	# ~~~~~~~~~~~~~~~~~~~~~ Luacheck ~~~~~~~~~~~~~~~~~~~~~~ #
	@luacheck . --globals=vim

width=35
GRN=\033[1;32m%s\033[0m # green bold text
RED=\033[1;31m%s\033[0m # red bold text
.PHONY: shell_lint
shell_lint:
	# ~~~~~~~~~~~~~~~~~~~~ Shellcheck ~~~~~~~~~~~~~~~~~~~~~ #
	@fd -0ug "*.sh" -x sh -c 'printf "%-$(width)s" "Checking {}: " && shellcheck -o all "{}" && printf "$(GRN)\n" OK || printf "$(RED)\n" FAIL'
	@echo
	@fd -ug "*.sh" | wc -l | xargs -I{} echo "{} files total."
