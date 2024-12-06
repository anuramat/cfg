heading::="$(shell tput setaf 5 bold)%s$(shell tput sgr0)\n"
# TODO fix this mess, validate perms on ./lib/*.sh
.PHONY: all system configs
all: system configs
system:
	@ printf ${heading} "Building NixOS"
	# @ ./lib/build.sh
configs:
	@ printf ${heading} "Installing configs"
	@ ./lib/install.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Lua ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
.PHONY: lua lua_fmt
lua_fmt:
	@ printf ${heading} "Formatting Lua files"
	@ stylua .
lua: lua_fmt
	@ printf ${heading} "Checking Lua files"
	@ luacheck . --globals=vim | ghead -n -2
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Shell ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
.PHONY: shell sh_fmt
sh_fmt:
	@ printf ${heading} "Formatting shell scripts"
	@ ./shrun 'shfmt -w -l -s -ci -bn -kp'
shell: sh_fmt
	@ printf ${heading} "Checking shell scripts"
	@ ./shrun 'shellcheck --color=always -o all'
