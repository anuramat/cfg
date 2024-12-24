# vim: fdm=marker fdl=1
heading::="$(shell tput setaf 5 bold)%s$(shell tput sgr0)\n"

# Setup {{{1
.PHONY: all flake links
all: flake links
flake:
	@ printf ${heading} "Building NixOS"
	@ sudo nixos-rebuild switch
links:
	@ printf ${heading} "Setting up links"
	@ BASH_ENV=/etc/profile ./scripts/install.sh

# Code {{{1
.PHONY: code
code: nix lua sh

# Nix {{{2
.PHONY: nix nixfmt
nixfmt:
	@ printf ${heading} "Formatting Nix files"
	@ treefmt -f nixfmt
nix: nixfmt
	@ printf ${heading} "Checking Nix files"
	@ statix check .
	@ deadnix

# Lua {{{2
.PHONY: lua luafmt
luafmt:
	@ printf ${heading} "Formatting Lua files"
	@ stylua .
lua: luafmt
	@ printf ${heading} "Checking Lua files"
	@ luacheck . --globals=vim | ghead -n -2

# Shell {{{2
.PHONY: sh shfmt
shfmt:
	@ printf ${heading} "Formatting shell scripts"
	@ ./scripts/shrun.sh 'shfmt --write --simplify --case-indent --binary-next-line --space-redirects'
sh: shfmt
	@ printf ${heading} "Checking shell scripts"
	@ ./scripts/shrun.sh 'shellcheck --color=always -o all'

# makefile2graph
.PHONY: root
root: all code
