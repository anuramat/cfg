#!/usr/bin/env bash
set -e
. ./lib/utils.sh
. ./misc/xdg.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Configs ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# TODO check that XDG_CONFIG_HOME is set, print paths in terminal
export __UTILS_OVERWRITE="always" # WARNING will overwrite your files without a prompt, unless they are protected
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
  "$HOMEBREW_PREFIX/opt/fzf/install"
}
# set shell
continue_prompt "Change shell to fish?" && {
  set_shell "$HOMEBREW_PREFIX/bin/fish"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ iTerm2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$XDG_CONFIG_HOME/iterm2"     # Set config path
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true                      # Autoload
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2 # Autosave
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ System ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
. ./bin/macos.sh
