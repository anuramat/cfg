# vim: fdm=marker fdl=1

# Setup {{{1
.PHONY: all flake links
all: flake links
flake:
	@ ./scripts/heading.sh "Building NixOS"
	@ sudo nixos-rebuild switch
links:
	@ ./scripts/heading.sh "Setting up links"
	@ BASH_ENV=/etc/profile ./scripts/install.sh

# Code {{{1
.PHONY: code
code: nix lua sh

# Nix {{{2
.PHONY: nix nixfmt
nixfmt:
	@ ./scripts/heading.sh "Formatting Nix files"
	@ nixfmt $(shell fd -e nix)

nix: nixfmt
	@ ./scripts/heading.sh "Checking Nix files"
	@ statix check . || true
	@ deadnix || true

# Lua {{{2
.PHONY: lua luafmt
luafmt:
	@ ./scripts/heading.sh "Formatting Lua files"
	@ stylua .
lua: luafmt
	@ ./scripts/heading.sh "Checking Lua files"
	@ luacheck . --globals=vim | ghead -n -2

# Shell {{{2
.PHONY: sh shfmt
shfmt:
	@ ./scripts/heading.sh "Formatting shell scripts"
	@ ./scripts/shrun.sh 'silent' 'shfmt --write --simplify --case-indent --binary-next-line --space-redirects'
sh: shfmt
	@ ./scripts/heading.sh "Checking shell scripts"
	@ ./scripts/shrun.sh 'verbose' 'shellcheck --color=always -o all'

# makefile2graph
.PHONY: root
root: all code
