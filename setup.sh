#!/usr/bin/env bash
set -e
. ./lib/utils.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Config files ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# TODO check that XDG_CONFIG_HOME is set
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
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ iTerm2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$(realpath config/iterm2)"     # Set config path
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true                      # Autoload
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2 # Autosave
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ System settings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# shoutout to https://macos-defaults.com
# and https://mths.be/macos
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
screenshot_dir="$HOME/Screenshots"
ensure_path "$screenshot_dir"
osascript -e 'tell application "System Preferences" to quit' # So it doesn't interfere
# Finder
defaults write -g AppleShowAllExtensions -bool true                         # Show file extensions
defaults write com.apple.finder CreateDesktop -bool false                   # Hide icons from desktop
defaults write com.apple.finder FXDefaultSearchScope -string SCcf           # Search current folder by default
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false  # Hide warning on extension change
defaults write com.apple.finder FXPreferredViewStyle -string clmv           # Set default view to columns
defaults write com.apple.finder ShowPathbar -bool true                      # Show bar on the bottom
defaults write com.apple.finder _FXSortFoldersFirst -bool true              # Keep folders on the top
defaults write com.apple.finder QuitMenuItem -bool true                     # Allow quit on Cmd+Q
defaults write com.apple.universalaccess showWindowTitlebarIcons -bool true # Show folder icon in title bar
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
killall Finder
# Dock
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock autohide -bool true                 # Hide dock
defaults write com.apple.dock autohide-delay -float 0             # Remove unhide delay
defaults write com.apple.dock autohide-time-modifier -float 0     # Remove hide/unhide animation
defaults write com.apple.dock mineffect -string scale             # Set minimize animation
defaults write com.apple.dock mru-spaces -bool false              # Do not rearrange spaces automatically
defaults write com.apple.dock show-recents -bool true             # Do not show recent apps
defaults write com.apple.dock static-only -bool true              # Only show opened apps
defaults write com.apple.dock show-process-indicators -bool false # Hide indicater for open applications
defaults write com.apple.dock expose-group-apps -bool true        # Group windows by application
defaults write com.apple.dock persistent-apps -array              # Delete all apps shortcuts
killall Dock
# not tested : don't write dsstore on external drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# Misc
defaults write -g AppleSpacesSwitchOnActivate -bool false                 # Switch to space with open application on Cmd+Tab
defaults write -g AppleInterfaceStyle Dark                                # Dark mode
defaults write -g ApplePressAndHoldEnabled -bool false                    # Allow key repeat on hold
defaults write com.apple.screencapture location -string "$screenshot_dir" # Set screenshot folder
defaults write com.apple.TextEdit RichText -bool false                    # Use txt by default (&& killall TextEdit ?)
# Language
defaults write -g AppleLanguages -array en # Change system language
sudo languagesetup -langspec English       # login language
