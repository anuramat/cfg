#!/usr/bin/env bash
. ./lib/utils.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ System settings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# shoutout to https://macos-defaults.com
# and https://mths.be/macos
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
screenshot_dir="$HOME/Screenshots"
ensure_path "$screenshot_dir"
# Finder
finder=com.apple.finder
defaults write -g AppleShowAllExtensions -bool true                         # Show file extensions
defaults write $finder CreateDesktop -bool false                            # Hide icons from desktop
defaults write $finder FXDefaultSearchScope -string SCcf                    # Search current folder by default
defaults write $finder FXEnableExtensionChangeWarning -bool false           # Hide warning on extension change
defaults write $finder FXPreferredViewStyle -string clmv                    # Set default view to columns
defaults write $finder NewWindowTarget -string "PfDe"                       # "PfDe" for desktop, "PfDo" for documents..., "PfLo" otherwise
defaults write $finder NewWindowTargetPath -string "file://${HOME}/"        # If PfLo: "file://${PATH}/"
defaults write $finder QuitMenuItem -bool true                              # Allow quit on Cmd+Q
defaults write $finder ShowPathbar -bool true                               # Show bar on the bottom
defaults write $finder ShowStatusBar -bool false                            # Don't show status bar on the bottom (size, n_items)
defaults write $finder _FXShowPosixPathInTitle -bool true                   # Show full path in title
defaults write $finder _FXSortFoldersFirst -bool true                       # Keep folders on the top
defaults write com.apple.universalaccess showWindowTitlebarIcons -bool true # Show folder icon in title bar
# Dock
dock=com.apple.dock
defaults write $dock minimize-to-application -bool true
defaults write $dock tilesize -int 48
defaults write $dock autohide -bool true                 # Hide dock
defaults write $dock autohide-delay -float 0             # Remove unhide delay
defaults write $dock autohide-time-modifier -float 0     # Remove hide/unhide animation
defaults write $dock mineffect -string scale             # Set minimize animation
defaults write $dock mru-spaces -bool false              # Do not rearrange spaces automatically
defaults write $dock show-recents -bool true             # Do not show recent apps
defaults write $dock static-only -bool true              # Only show opened apps
defaults write $dock show-process-indicators -bool false # Hide indicater for open applications
defaults write $dock expose-group-apps -bool true        # Group windows by application
defaults write $dock persistent-apps -array              # Delete all apps shortcuts
# not tested : don't write dsstore on external drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# Misc
defaults write -g AppleInterfaceStyle Dark                                # Dark mode
defaults write -g ApplePressAndHoldEnabled -bool false                    # Allow key repeat on hold
defaults write -g AppleSpacesSwitchOnActivate -bool false                 # Switch to space with open application on Cmd+Tab
defaults write -g AppleWindowTabbingMode -string always                   # Prefer tabs to windows
defaults write -g NSCloseAlwaysConfirmsChanges -bool false                # Ask to save on close
defaults write -g NSQuitAlwaysKeepsWindows -bool false                    # Close windows on <Cmd-Q>
defaults write com.apple.TextEdit RichText -bool false                    # Use txt by default (&& killall TextEdit ?)
defaults write com.apple.screencapture location -string "$screenshot_dir" # Set screenshot folder
# Keyboard
defaults write -g InitialKeyRepeat -float 15 # repeat period
defaults write -g KeyRepeat -float 2         # delay
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g TISRomanSwitchState -bool false # turn off automatic input method switching
# Language
defaults write -g AppleLanguages -array en      # Change system language
defaults write -g AppleLocale -string en_RU@USD # Set locale
# Clock in menubar
menuclock=com.apple.menuextra.clock.plist
defaults write $menuclock ShowAMPM -bool true
defaults write $menuclock ShowDate -integer 0
defaults write $menuclock ShowDayOfWeek -bool true
defaults write $menuclock ShowSeconds -bool true
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ End ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
killall Dock Finder SystemUIServer
echo "[cfg] restart pls"
