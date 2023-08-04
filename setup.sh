#!/usr/bin/env bash
set -e
. ./lib/utils.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Config files ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
export __UTILS_OVERWRITE="always"
continue_prompt "Install configs?" && {
  install2file config/bashrc.sh "$HOME/.bashrc"
  install2file config/batconfig "$XDG_CONFIG_HOME/bat/config"
  install2file config/gitconfig.cfg "$XDG_CONFIG_HOME/git/config"
  install2folder config/condarc "$XDG_CONFIG_HOME/conda"
  install2folder config/config.fish "$XDG_CONFIG_HOME/fish"
  install2folder config/fish_prompt.fish "$XDG_CONFIG_HOME/fish/functions"
  install2folder config/karabiner.json "$XDG_CONFIG_HOME/karabiner"
  install2folder config/ripgreprc "$XDG_CONFIG_HOME"
  install2folder config/shellcheckrc "$XDG_CONFIG_HOME"
  install2folder nvim "$XDG_CONFIG_HOME"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Shells ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# bash
ensure_string 'source "$HOME/.bashrc"' "$HOME/.bash_profile"
# fish
./lib/vars.fish
# common
ensure_string "hehe" "$HOME/.hushlogin"
continue_prompt "Install fzf integration?" && {
  /opt/homebrew/opt/fzf/install
}
# set shell
continue_prompt "Change shell to fish?" && {
  set_shell /opt/homebrew/bin/fish
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ macOS stuff ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
screenshot_dir="$HOME/Screenshots"
ensure_path "$screenshot_dir"
defaults write com.apple.screencapture location -string "$screenshot_dir"
defaults write -g ApplePressAndHoldEnabled -bool false   # allow key repeat on hold
defaults write NSGlobalDomain AppleLanguages -array "en" # system language
# sudo languagesetup -langspec English # login language (i've heard it doesn't work)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ iTerm2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$(realpath config/iterm2)"     # Set config path
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true                      # Autoload
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2 # Autosave
