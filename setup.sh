#!/usr/bin/env bash
set -e
. ./lib/utils.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Configs ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# TODO check that XDG_CONFIG_HOME is set
export __UTILS_OVERWRITE="always"
continue_prompt "Install configs?" && {
  install2file misc/bashrc.sh "$HOME/.bashrc"
  install2folder misc/config.fish "$XDG_CONFIG_HOME/fish"
  install2folder misc/fish_prompt.fish "$XDG_CONFIG_HOME/fish/functions"
  # symlink everything from ./config folder to $XDG_CONFIG_HOME
  find config -maxdepth 1 -mindepth 1 -print0 | xargs -0I {} bash -c ". lib/utils.sh; install2folder {} $XDG_CONFIG_HOME"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Shells ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# bash
ensure_string 'source "$HOME/.bashrc"' "$HOME/.bash_profile"
# fish functions and variables
./bin/setup.fish
# common
ensure_string "hehe" "$HOME/.hushlogin"
continue_prompt "Install fzf integration?" && {
  /opt/homebrew/opt/fzf/install
}
# set shell
continue_prompt "Change shell to fish?" && {
  set_shell /opt/homebrew/bin/fish
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ iTerm2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$(realpath config/iterm2)"     # Set config path
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true                      # Autoload
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2 # Autosave
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ System ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
./bin/macos.sh
