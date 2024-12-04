#!/usr/bin/env bash
set -e
# vim: fdm=marker fdl=0

# paths {{{1
backups="$XDG_CACHE_HOME/cfg/backups"
local_nixos=./nixos
sys_nixos=/etc/nixos
hwcfg="$sys_nixos/hardware-configuration.nix"
lock="$sys_nixos/flake.lock"

# backup {{{1
mkdir -p "$backups" && sudo rsync -r "$sys_nixos/" "$backups/$(date -u +'%F_%H-%M-%S')"

# clean {{{1
# rm * except hw config - to make sure our build can't reference old files from
# previous builds, that were removed from the repo
sudo find "$sys_nixos" ! -wholename "$sys_nixos" ! -wholename "$hwcfg" -delete

# write {{{1
# merge / overwrite
sudo rsync -r --chown=root:root "$local_nixos/" "$sys_nixos"
# rebuild
sudo nixos-rebuild switch
# save new lock
cp "$lock" "$local_nixos/flake.lock"

# misc post-build {{{1
# create default XDG user directories
xdg-user-dirs-update --force
# TODO maybe ensure path for xdg basedir spec too
