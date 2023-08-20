#!/usr/bin/env bash
set -e

__GOBINFILE="$1"

. lib/utils.sh

install_gobins "${__GOBINFILE}"
brew bundle install
