#!/usr/bin/env bash
set -e

local_nixos_folder="./nixos/"
[ "$(git diff "$local_nixos_folder")" ] && echo "$(basename "$local_nixos_folder") has uncommited changed, can't proceed" && exit
sys_nixos_folder="/etc/nixos"
[ -r "$sys_nixos_folder" ] && cp "$sys_nixos_folder" "$local_nixos_folder"

# git add --all && git commit -am sync && git push
