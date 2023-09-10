#!/usr/bin/env bash
set -e

repo_cfg="./configuration.nix"
[ "$(git diff "$repo_cfg")" ] && echo "$repo_cfg has uncommited changed, can't proceed"
sys_cfg="/etc/nixos/configuration.nix"
[ -r "$sys_cfg" ] && cp "$sys_cfg" ./

git add --all && git commit -am sync && git push
