#!/usr/bin/env bash
set -e

local_nixos_folder="./nixos/"
sys_nixos_folder="/etc/nixos/"

# copy the config (merges directories, overwrites files)
sudo rsync -r --chown=root:root "$local_nixos_folder" "$sys_nixos_folder"

# rebuild the system
sudo nixos-rebuild switch

# clear tofi cache
__tofi="$XDG_CACHE_HOME/tofi-drun"
[ -f "$__tofi" ] && rm "$__tofi"
