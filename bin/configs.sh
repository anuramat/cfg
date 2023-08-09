#!/usr/bin/env bash
# Comment out to ask before overwriting
export __UTILS_OVERWRITE="always"
# Install $HOME dotfiles
find home -maxdepth 1 -mindepth 1 -print0 | xargs -0I{} bash -c '. lib/utils.sh; install2file {} $HOME/$(dotfilify {})'
# Install $XDG_CONFIG_HOME configs
find config -maxdepth 1 -mindepth 1 -print0 | xargs -0I{} bash -c ". lib/utils.sh; install2folder {} ${XDG_CONFIG_HOME}"
