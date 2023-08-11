#!/usr/bin/env bash
. ./lib/utils.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ System settings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Shoutout to https://macos-defaults.com
# and https://mths.be/macos
# Breaks every major release :(
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~ Docker ~~~~~~~~~~~~~~~~~~~~~~~~ #
finder=com.apple.finder
defaults write -g AppleShowAllExtensions -bool true                         # Show file extensions
defaults write "${finder}" CreateDesktop -bool false                        # Hide icons from desktop
defaults write "${finder}" FXDefaultSearchScope -string SCcf                # Search current folder by default
defaults write "${finder}" FXEnableExtensionChangeWarning -bool false       # Hide warning on extension change
defaults write "${finder}" FXPreferredViewStyle -string clmv                # Set default view to columns
defaults write "${finder}" NewWindowTarget -string "PfDe"                   # "PfDe" for desktop, "PfDo" for documents..., "PfLo" otherwise
defaults write "${finder}" NewWindowTargetPath -string "file://${HOME}/"    # If PfLo: "file://${PATH}/"
defaults write "${finder}" QuitMenuItem -bool true                          # Allow quit on Cmd+Q
defaults write "${finder}" ShowPathbar -bool true                           # Show bar on the bottom
defaults write "${finder}" ShowStatusBar -bool false                        # Don't show status bar on the bottom (size, n_items)
defaults write "${finder}" _FXShowPosixPathInTitle -bool true               # Show full path in title
defaults write "${finder}" _FXSortFoldersFirst -bool true                   # Keep folders on the top
defaults write com.apple.universalaccess showWindowTitlebarIcons -bool true # Show folder icon in title bar
# ~~~~~~~~~~~~~~~~~~~~~~~~ Dock ~~~~~~~~~~~~~~~~~~~~~~~~~ #
dock=com.apple.dock
defaults write "${dock}" minimize-to-application -bool true
defaults write "${dock}" tilesize -int 48
defaults write "${dock}" autohide -bool true                 # Hide dock
defaults write "${dock}" autohide-delay -float 0             # Remove unhide delay
defaults write "${dock}" autohide-time-modifier -float 0     # Remove hide/unhide animation
defaults write "${dock}" mineffect -string scale             # Set minimize animation
defaults write "${dock}" mru-spaces -bool false              # Do not rearrange spaces automatically
defaults write "${dock}" show-recents -bool true             # Do not show recent apps
defaults write "${dock}" static-only -bool true              # Only show opened apps
defaults write "${dock}" show-process-indicators -bool false # Hide indicater for open applications
defaults write "${dock}" expose-group-apps -bool true        # Group windows by application
defaults write "${dock}" persistent-apps -array              # Delete all apps shortcuts
# ~~~~~~~~~~~~~~~~~~~~~ Hot corners ~~~~~~~~~~~~~~~~~~~~~ #
# Bottom left corner - Screensaver/Lock
for corner in tl tr br bl; do
	defaults write "${dock}" "wvous-${corner}-corner" -int 0
	defaults write "${dock}" "wvous-${corner}-modifier" -int 0
done
defaults write "${dock}" wvous-bl-corner -int 5
defaults write "${dock}" wvous-bl-modifier -int 0
# ~~~~~~~~~~~~~~~~~~~~~~~~ Misc ~~~~~~~~~~~~~~~~~~~~~~~~~ #
defaults write -g AppleInterfaceStyle Dark                 # Dark mode
defaults write -g ApplePressAndHoldEnabled -bool false     # Allow key repeat on hold
defaults write -g AppleSpacesSwitchOnActivate -bool false  # Switch to space with open application on Cmd+Tab
defaults write -g AppleWindowTabbingMode -string always    # Prefer tabs to windows
defaults write -g NSCloseAlwaysConfirmsChanges -bool false # Ask to save on close
defaults write -g NSQuitAlwaysKeepsWindows -bool false     # Close windows on <Cmd-Q>
defaults write com.apple.TextEdit RichText -bool false     # Use txt by default
# Not tested : don't write dsstore on external drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# Screenshot directory
screenshot_dir="${HOME}/Screenshots"
ensure_path "${screenshot_dir}"
defaults write com.apple.screencapture location -string "${screenshot_dir}" # Set screenshot folder
# ~~~~~~~~~~~~~~~~~~~~~~ Keyboard ~~~~~~~~~~~~~~~~~~~~~~~ #
defaults write -g InitialKeyRepeat -float 15 # repeat period
defaults write -g KeyRepeat -float 2         # delay
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g TISRomanSwitchState -bool false # turn off automatic input method switching
# ~~~~~~~~~~~~~~~~~~~~~~ Language ~~~~~~~~~~~~~~~~~~~~~~~ #
defaults write -g AppleLanguages -array en      # Change system language
defaults write -g AppleLocale -string ru_RU@USD # Set locale
# ~~~~~~~~~~~~~~~~~~~~~~ Menu bar ~~~~~~~~~~~~~~~~~~~~~~~ #
menuclock=com.apple.menuextra.clock.plist
defaults write "${menuclock}" ShowAMPM -bool true
defaults write "${menuclock}" ShowDate -integer 0
defaults write "${menuclock}" ShowDayOfWeek -bool true
defaults write "${menuclock}" ShowSeconds -bool true
defaults write "${menuclock}" IsAnalog -bool false
defaults write "${menuclock}" FlashDateSeparators -bool false
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true
# ~~~~~~~~~~~~~~~~~~~~~~ Trackpad ~~~~~~~~~~~~~~~~~~~~~~~ #
trackpad=com.apple.AppleMultitouchTrackpad
defaults write "${trackpad}" ActuateDetents -int 1
defaults write "${trackpad}" ActuationStrength -int 1
defaults write "${trackpad}" Clicking -int 0
defaults write "${trackpad}" DragLock -int 0
defaults write "${trackpad}" Dragging -int 0
defaults write "${trackpad}" FirstClickThreshold -int 1
defaults write "${trackpad}" ForceSuppressed -bool false
defaults write "${trackpad}" SecondClickThreshold -int 1
defaults write "${trackpad}" TrackpadCornerSecondaryClick -int 0
defaults write "${trackpad}" TrackpadFiveFingerPinchGesture -int 2
defaults write "${trackpad}" TrackpadFourFingerHorizSwipeGesture -int 2
defaults write "${trackpad}" TrackpadFourFingerPinchGesture -int 2
defaults write "${trackpad}" TrackpadFourFingerVertSwipeGesture -int 2
defaults write "${trackpad}" TrackpadHandResting -bool true
defaults write "${trackpad}" TrackpadHorizScroll -int 1
defaults write "${trackpad}" TrackpadMomentumScroll -bool true
defaults write "${trackpad}" TrackpadPinch -int 1
defaults write "${trackpad}" TrackpadRightClick -bool true
defaults write "${trackpad}" TrackpadRotate -int 1
defaults write "${trackpad}" TrackpadScroll -bool true
defaults write "${trackpad}" TrackpadThreeFingerDrag -bool false
defaults write "${trackpad}" TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write "${trackpad}" TrackpadThreeFingerTapGesture -int 2
defaults write "${trackpad}" TrackpadThreeFingerVertSwipeGesture -int 2
defaults write "${trackpad}" TrackpadTwoFingerDoubleTapGesture -int 1
defaults write "${trackpad}" TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
defaults write "${trackpad}" USBMouseStopsTrackpad -int 0
defaults write "${trackpad}" UserPreferences -bool true
# ~~~~~~~~~~~~~~~~~~~~~~ Spotlight ~~~~~~~~~~~~~~~~~~~~~~ #
defaults write com.apple.Spotlight orderedItems -array \
	'{enabled = true; name = "SYSTEM_PREFS";}' \
	'{enabled = true; name = "PDF";}' \
	'{enabled = true; name = "MENU_EXPRESSION";}' \
	'{enabled = true; name = "MENU_DEFINITION";}' \
	'{enabled = true; name = "MENU_CONVERSION";}' \
	'{enabled = true; name = "EVENT_TODO";}' \
	'{enabled = true; name = "CONTACT";}' \
	'{enabled = true; name = "APPLICATIONS";}' \
	'{enabled = false; name = "SPREADSHEETS";}' \
	'{enabled = false; name = "SOURCE";}' \
	'{enabled = false; name = "PRESENTATIONS";}' \
	'{enabled = false; name = "MUSIC";}' \
	'{enabled = false; name = "MOVIES";}' \
	'{enabled = false; name = "MESSAGES";}' \
	'{enabled = false; name = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
	'{enabled = false; name = "MENU_OTHER";}' \
	'{enabled = false; name = "IMAGES";}' \
	'{enabled = false; name = "FONTS";}' \
	'{enabled = false; name = "DOCUMENTS";}' \
	'{enabled = false; name = "DIRECTORIES";}' \
	'{enabled = false; name = "BOOKMARKS";}'
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ End ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
echo "[cfg] preferences applied, restart please"
