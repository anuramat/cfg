# vim: fdm=marker fdl=1
heading::="$(shell tput setaf 5 bold)%s$(shell tput sgr0)\n"

# Setup {{{1
.PHONY: all flake config
all: flake config
flake:
	@ printf ${heading} "Building NixOS"
	@ sudo nixos-rebuild switch
config: 
	@ printf ${heading} "Linking configs"
	@ BASH_ENV=/etc/profile ./lib/install.sh

# Code {{{1
.PHONY: code 
code: nix lua shell
# Nix {{{2
nixfmt:
	@ printf ${heading} "Formatting Nix files"
	@ alejandra .
nix: nixfmt
	# TODO add a linter
# Lua {{{2
.PHONY: lua luafmt
luafmt:
	@ printf ${heading} "Formatting Lua files"
	@ stylua .
lua: luafmt
	@ printf ${heading} "Checking Lua files"
	@ luacheck . --globals=vim | ghead -n -2
# Shell {{{2
.PHONY: shell shfmt
shfmt:
	@ printf ${heading} "Formatting shell scripts"
	@ ./lib/shrun.sh 'shfmt --write --simplify --case-indent --binary-next-line --space-redirects'
shell: shfmt
	@ printf ${heading} "Checking shell scripts"
	@ ./lib/shrun.sh 'shellcheck --color=always -o all'
