#!/usr/bin/env bash
set -e

nixos_cfg="/etc/nixos/configuration.nix"
[ -r  "$nixos_cfg" ] && cp "$nixos_cfg" ./

git add --all && git commit -am sync && git push
