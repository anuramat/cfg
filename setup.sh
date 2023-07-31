#!/usr/bin/env bash
source lib/utils.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Config files ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
install2folder nvim "$HOME/.config"
install2folder config/karabiner.json "$HOME/.config/karabiner"
install2file config/bashrc.sh "$HOME/.bashrc"
install2file config/config.fish "$HOME/.config/fish"
install2file config/shellcheckrc "$HOME/.config/shellcheckrc"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Shells ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
ensure_string 'source "$HOME/.bashrc"' "$HOME/.bash_profile"
ensure_string "hehe" "$HOME/.hushlogin"
set_shell /opt/homebrew/bin/fish
fish -c "set -U fish_greeting"
fish -c "set -Ux GOPATH '$HOME/go'"
fish -c "set -Ux LANG 'en_US.UTF-8'"
fish -c "set -Ux LC_ALL 'en_US.UTF-8'"
fish -c "fish_add_path '$HOME/go/bin'"
fish -c "fish_add_path /opt/homebrew/bin/"
/opt/homebrew/opt/fzf/install
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ macOS stuff ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
screenshot_dir="$HOME/Screenshots"
ensure_path "$screenshot_dir"
defaults write com.apple.screencapture location -string "$screenshot_dir"
# allow key repeat press and hold #
defaults write -g ApplePressAndHoldEnabled -bool false
# locale
sudo defaults write .GlobalPreferences AppleLocale en_US
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ iTerm2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Set config path
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$(realpath config/iterm2)"
# Autoload
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
# Autosave
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2
