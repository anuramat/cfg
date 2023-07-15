#!/usr/bin/env sh
source src/utils.sh

# install configs #
install_files nvim/lua nvim/init.lua "$HOME/.config/nvim"
install_files misc/karabiner.json "$HOME/.config/karabiner"
install_files misc/cfg.sh "$HOME"
install_files misc/fishcfg.fish "$HOME"

# setup bash #
ensure_string 'source "$HOME/cfg.sh"' "$HOME/.bash_profile"
# suppress "last login" msg
ensure_string "hehe" "$HOME/.hushlogin"
# setup fish
set_shell /opt/homebrew/bin/fish
fish -c "set -U fish_greeting"
fish -c "set -U GOPATH '$HOME/go'"
fish -c "fish_add_path '$HOME/go/bin'"
fish -c "fish_add_path /opt/homebrew/bin/"

# change default screenshot location #
screenshot_dir="$HOME/Screenshots"
ensure_path "$screenshot_dir"
defaults write com.apple.screencapture location -string "$screenshot_dir"

# allow key repeat press and hold #
defaults write -g ApplePressAndHoldEnabled -bool false

# conda #
conda_output="$(conda init bash)"
[ $? -eq 0 ] || echo "$conda_output"
conda config --set auto_activate_base false

# iTerm2 #
# Set config path
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$(realpath misc/iterm2)"
# Autoload
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
# Autosave
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2
