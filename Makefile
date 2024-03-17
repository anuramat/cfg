local_nixos::=./nixos/
sys_nixos::=/etc/nixos/
tofi_drun_cache::="${XDG_CACHE_HOME}/tofi-drun"

.PHONY: build
build:
	@ # copy the config (merges directories, overwrites files)
	@ sudo rsync -r --chown=root:root "${local_nixos}" "${sys_nixos}"
	@ sudo nixos-rebuild switch
	@ [ -f "${tofi_drun_cache}" ] && rm "${tofi_drun_cache}" || true

.PHONY: lint
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
GREEN=\033[1;32m%s\033[0m # green bold text
RED=\033[1;31m%s\033[0m # red bold text
PURPLE=\033[1;35m%s\033[0m # purple bold text

.PHONY: sh_lint
sh_lint: sh_fmt
	@ echo -e "\nChecking shell scripts"
	@ fd -0ug "*.sh" -x sh -c 'printf "%-$(width)s" "Checking {}: " && shellcheck --color=always -o all "{}" && printf "$(GREEN)\n" OK || printf "$(RED)\n" FAIL'
posix:
	@ printf "\n$(PURPLE)\n" "Checking shell scripts (forced POSIX, ignoring shebangs)"
	@ fd -0ug "*.sh" -x sh -c 'printf "%-$(width)s" "Checking {}: " && shellcheck --color=always -s sh -o all "{}" && printf "$(GREEN)\n" OK || printf "$(RED)\n" FAIL'
