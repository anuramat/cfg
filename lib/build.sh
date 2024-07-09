#!/usr/bin/env bash
set -e

# paths {{{1
backup="$HOME/.cfgbak"
local_nixos=./nixos
sys_nixos=/etc/nixos
hwcfg="$sys_nixos/hardware-configuration.nix"
lock="$sys_nixos/flake.lock"

# backup {{{1
mkdir -p "$backup" && sudo rsync -r "$sys_nixos/" "$backup/$(date -u +'%F_%H-%M-%S')"

# clean {{{1
# rm * except hw config & lockfile - to make sure our build can't reference old
# files from previous builds, that were removed from the repo
sudo find "$sys_nixos" ! -wholename "$sys_nixos" ! -wholename "$hwcfg" ! -wholename "$lock" -delete

# write {{{1
# merge / overwrite
sudo rsync -r --chown=root:root "$local_nixos/" "$sys_nixos"
# rebuild
sudo nixos-rebuild switch

# misc post-build {{{1
# clear tofi .desktop cache
tofi_drun_cache="$XDG_CACHE_HOME/tofi-drun"
[ -f "$tofi_drun_cache" ] && rm "$tofi_drun_cache" || true
# create default XDG user directories
xdg-user-dirs-update --force

# vim: fdm=marker fdl=0
