#!/usr/bin/env bash
# get helper functions
. ./lib/utils.sh
# Env vars
. ./home/profile.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Configs ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Install configs
./bin/configs.sh
# Install go binaries
./bin/gogetter.sh
# Suppress login message
ensure_string "hehe" "${HOME}/.hushlogin"
# Make bash the default shell
[ "${SHELL}" != "${HOMEBREW_PREFIX}/bin/bash" ] && {
	continue_prompt "Change shell to bash?" && {
		set_shell "${HOMEBREW_PREFIX}/bin/bash"
	}
}
# Install fzf shell integration
[ -f "${HOME}/.fzf.bash" ] || {
	continue_prompt "Install fzf integration?" && {
		"${HOMEBREW_PREFIX}/opt/fzf/install"
	}
}
# iTerm2
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${XDG_CONFIG_HOME}/iterm2"     # Set config path
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true                      # Autoload
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2 # Autosave
# System settings
./bin/prefs.sh
