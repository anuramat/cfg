#!/usr/bin/env bash
set -e
. ./lib/utils.sh
. ./shell/profile.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Configs ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# TODO check that XDG_CONFIG_HOME is set, print paths in terminal
export __UTILS_OVERWRITE="always" # WARNING will overwrite your files without a prompt, unless they are protected
continue_prompt "Install configs?" && {
  install2file shell/bashrc.sh "$HOME/.bashrc"
  install2file shell/profile.sh "$HOME/.profile"
  # file.ext -> .file
  find shell -maxdepth 1 -mindepth 1 -print0 | xargs -n1 -0I{} bash -c '. lib/utils.sh; basename {} | xargs -I# echo {} $HOME/$(basename {} | perl -pe "s/(.*)\..*/.\1/")' 
  find config -maxdepth 1 -mindepth 1 -print0 | xargs -n1 -0I{} bash -c ". lib/utils.sh; install2folder {} $XDG_CONFIG_HOME"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Shell ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# bash
ensure_string 'source "$HOME/.bashrc"' "$HOME/.bash_profile"
# common
ensure_string "hehe" "$HOME/.hushlogin"
continue_prompt "Install fzf integration?" && {
  "$HOMEBREW_PREFIX/opt/fzf/install"
}
# set shell
continue_prompt "Change shell to bash?" && {
  set_shell "$HOMEBREW_PREFIX/bin/bash"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ iTerm2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$XDG_CONFIG_HOME/iterm2"     # Set config path
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true                      # Autoload
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2 # Autosave
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ System ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
./bin/macos.sh
