heading::="$(shell tput setaf 5 bold)%s$(shell tput sgr0)\n"

.PHONY: build code
build:
	@ printf ${heading} "Building NixOS"
	@ ./lib/build.sh
code: lua sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Lua ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
.PHONY: lua lua_fmt
lua_fmt:
	@ printf ${heading} "Formatting Lua files"
	@ stylua .
lua: lua_fmt
	@ printf ${heading} "Checking Lua files"
	@ luacheck . --globals=vim | ghead -n -2
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Shell ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
.PHONY: sh posix sh_fmt
sh_fmt:
	@ # write, list, simplify, case-indent, binary-newline, keep-padding
	@ # keep padding,
	@ printf ${heading} "Formatting shell scripts"
	@ fd -0ug "*.sh" | xargs -0I{} shfmt -w -l -s -ci -bn -kp {}
shell: sh_fmt
	@ printf ${heading} "Checking shell scripts"
	@ . lib/test.sh ; autoshell
posix: sh_fmt
	@ printf ${heading} "Checking shell scripts for POSIX compatibility"
	@ . lib/test.sh ; posix
