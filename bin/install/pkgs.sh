#!/usr/bin/env bash
. lib/utils.sh

install_gobins go-binaries.txt
brew bundle install
