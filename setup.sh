#!/usr/bin/env bash
set -e

. ./lib/utils.sh
. ./home/profile.sh

echo "[cfg] installing configs" && ./bin/install/configs.sh

touch "$HOME/.hushlogin"

# check that bash is default
# [ "$SHELL" != "$HOMEBREW_PREFIX/bin/bash" ] && {
# Install fzf shell integration
