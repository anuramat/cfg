#!/usr/bin/env bash
source lib/utils.sh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Config files ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
install_multiple nvim/lua nvim/init.lua "$HOME/.config/nvim"
install_single config/karabiner.json "$HOME/.config/karabiner"
install_single config/bashrc.sh "$HOME/.bashrc"
install_single config/config.fish "$HOME/"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Shells ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
ensure_string 'source "$HOME/.bashrc"' "$HOME/.bash_profile"
ensure_string "hehe" "$HOME/.hushlogin"
set_shell /opt/homebrew/bin/fish
fish -c "set -U fish_greeting"
fish -c "set -U GOPATH '$HOME/go'"
fish -c "fish_add_path '$HOME/go/bin'"
fish -c "fish_add_path /opt/homebrew/bin/"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ macOS stuff ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
screenshot_dir="$HOME/Screenshots"
ensure_path "$screenshot_dir"
defaults write com.apple.screencapture location -string "$screenshot_dir"
# allow key repeat press and hold #
defaults write -g ApplePressAndHoldEnabled -bool false
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ conda ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
conda_output="$(conda init bash)"
[ $? -eq 0 ] || echo "$conda_output"
conda config --set auto_activate_base false
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ iTerm2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Set config path
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$(realpath config/iterm2)"
# Autoload
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
# Autosave
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2
