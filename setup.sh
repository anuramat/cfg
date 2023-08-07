#!/usr/bin/env bash
set -e
. ./lib/utils.sh
. ./shell/profile.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Configs ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# TODO check that XDG_CONFIG_HOME is set, print paths in terminal
export __UTILS_OVERWRITE="always"
# Install $HOME dotfiles
find shell -maxdepth 1 -mindepth 1 -print0 | xargs -0I{} bash -c '. lib/utils.sh; echo {} $HOME/$(dotfilify {})'
# Install $XDG_CONFIG_HOME configs
find config -maxdepth 1 -mindepth 1 -print0 | xargs -0I{} bash -c ". lib/utils.sh; install2folder {} $XDG_CONFIG_HOME"
# Suppress login message
ensure_string "hehe" "$HOME/.hushlogin"
# Make bash the default shell
[ "$SHELL" != "$HOMEBREW_PREFIX/bin/bash" ] && {
	continue_prompt "Change shell to bash?" && {
		set_shell "$HOMEBREW_PREFIX/bin/bash"
	}
}
# Install fzf shell integration
continue_prompt "Install fzf integration?" && {
	"$HOMEBREW_PREFIX/opt/fzf/install"
}
# iTerm2
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$XDG_CONFIG_HOME/iterm2"       # Set config path
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true                      # Autoload
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2 # Autosave
# System settings
./bin/macos.sh
