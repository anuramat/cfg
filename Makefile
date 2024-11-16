heading::="$(shell tput setaf 5 bold)%s$(shell tput sgr0)\n"

.PHONY: system install code
system:
	@ printf ${heading} "Building NixOS"
	@ ./lib/build.sh
install:
	@ printf ${heading} "Installing configs"
	@ . lib/install.sh; install
code: lua shell
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Lua ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
.PHONY: lua lua_fmt
lua_fmt:
	@ printf ${heading} "Formatting Lua files"
	@ stylua .
lua: lua_fmt
	@ printf ${heading} "Checking Lua files"
	@ luacheck . --globals=vim | ghead -n -2
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Shell ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
.PHONY: shell posix sh_fmt
sh_fmt:
	@ printf ${heading} "Formatting shell scripts"
	@ . lib/format.sh; shell
shell: sh_fmt
	@ printf ${heading} "Checking shell scripts"
	@ . lib/lint.sh; shell
posix: sh_fmt
	@ printf ${heading} "Checking shell scripts for POSIX compatibility"
	@ . lib/lint.sh; posix
