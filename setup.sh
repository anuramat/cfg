#!/usr/bin/env bash
. ./lib/utils.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Config files ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
continue_prompt "Install configs?" && {
  install2folder nvim "$HOME/.config"
  install2folder config/karabiner.json "$HOME/.config/karabiner"
  install2folder config/config.fish "$HOME/.config/fish"
  install2folder config/shellcheckrc "$HOME/.config"
  install2file config/bashrc.sh "$HOME/.bashrc"
  install2file config/git.cfg "$HOME/.gitconfig"
  install2file config/editor.cfg "$HOME/.editorconfig"
  install2file config/condarc.yaml "$HOME/.condarc"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Shells ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# bash
ensure_string 'source "$HOME/.bashrc"' "$HOME/.bash_profile"
# fish
fish -c "set -U fish_greeting"
fish -c "set -Ux GOPATH '$HOME/go'"
fish -c "set -Ux LC_ALL 'en_US.UTF-8'"
fish -c "fish_add_path '$HOME/go/bin'"
fish -c "fish_add_path /opt/homebrew/bin/"
# common
ensure_string "hehe" "$HOME/.hushlogin"
continue_prompt "Install fzf integration?" && {
  /opt/homebrew/opt/fzf/install
}
continue_prompt "Make fish the default shell?" && {
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
