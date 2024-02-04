#!/usr/bin/env bash
set -e

local_nixos_folder="./nixos"
sys_nixos_folder="/etc/nixos"

# check if there's any uncommited changes in the repo
[ "$(git diff @ -- "$local_nixos_folder")" ] && echo "$(basename "$local_nixos_folder") has uncommited changed, can't proceed" && exit
rm -rd "$local_nixos_folder"
# copy NixOS stuff to the repo
[ -r "$sys_nixos_folder" ] && cp -rT "$sys_nixos_folder" "$local_nixos_folder"

# push everything
git commit -am sync && git push
