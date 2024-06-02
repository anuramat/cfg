#!/usr/bin/env bash
set -e

# keep paths normalized
local_nixos=./nixos
sys_nixos=/etc/nixos
hardware_config="$sys_nixos/hardware-configuration.nix"
tofi_drun_cache="$XDG_CACHE_HOME/tofi-drun"

# double check that hardware configuration path is valid
[ -f "${hardware_config}" ]

# delete everything but the hardware configuration
sudo find "${sys_nixos}" ! -wholename "${sys_nixos}" ! -wholename "${sys_nixos}/hardware-configuration.nix" ! -wholename "${sys_nixos}/flake.lock" -delete

# copy the config (merges directories, overwrites files)
sudo rsync -r --chown=root:root "${local_nixos}/" "${sys_nixos}"

# rebuild
sudo nixos-rebuild switch

# copy lockfile to repo
cp "${sys_nixos}/flake.lock" "${local_nixos}/flake.lock"

# clear tofi .desktop cache
[ -f "${tofi_drun_cache}" ] && rm "${tofi_drun_cache}" || true

# create default XDG user directories
xdg-user-dirs-update --force
