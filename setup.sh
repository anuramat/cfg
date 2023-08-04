#!/usr/bin/env bash
. ./lib/utils.sh
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Config files ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
continue_prompt "Install configs?" && {
  install2file config/bashrc.sh "$HOME/.bashrc"
  install2file config/condarc.yaml "$HOME/.condarc"
  install2file config/git.cfg "$XDG_CONFIG_HOME/git/config"
  install2file config/prompt.fish "$XDG_CONFIG_HOME/fish/functions/fish_prompt.fish"
  install2folder config/config.fish "$XDG_CONFIG_HOME/fish"
  install2folder config/karabiner.json "$XDG_CONFIG_HOME/karabiner"
  install2folder config/shellcheckrc "$XDG_CONFIG_HOME"
  install2folder config/ripgreprc "$XDG_CONFIG_HOME"
  install2folder nvim "$XDG_CONFIG_HOME"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Shells ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# common
ensure_string "hehe" "$HOME/.hushlogin"
continue_prompt "Install fzf integration?" && {
  /opt/homebrew/opt/fzf/install
}
# bash
ensure_string 'source "$HOME/.bashrc"' "$HOME/.bash_profile"
# fish
./lib/vars.fish
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
