# anuramat/cfg
my shitty little config repo

## Setup
achtung: Brewfile is big chungus floppa gigachad, comment out unwanted packages

### CLI

```sh
# install git and stuff (might take some time)
xcode-select --install
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# clone this repo, create dev folder
cd && git clone https://github.com/anuramat/cfg && cd cfg
# install from Brewfile
brew bundle install
# install config files and shiet
bash setup.sh
```

### GUI

#### Preferences 

I sure do hope Apple doesn't make another redesign

##### Keyboard:
- Key repeat rate: rightmost
- Delay until repeat: rightmost - 1
- Turn off everything in "Text replacements..." and "Input sources/Edit..."

##### Trackpad/More Gestures:
- App Exposè - Swipe Down with Three Fingers
- Swipe between pages - Off
- Default web browser

##### Control Centre:
- Turn on battery percentage in menu bar

##### Desktop & Dock

###### Dock:
- Automatically hide and show the Dock - On
- Show recent applications in Dock - Off
- Show indicators for open applications - Off

###### Menu Bar:
- Automatically - Always
- Recent - None

###### Windows & Apps:
- Prefer tabs - Always
- Ask to keep changes - On
- Close windows when quitting - Off

###### Mission control:
- Automatically rearrange Spaces based on most recent use - Off
- When switching to an application, switch to a Space with open windows - Off
- Group windows by application - On

#### Misc

- Remove all shortcuts from dock

## Potential problems

- If developer stuff appears in your spotlight:
```sh
mkdir /Applications/Xcode.app
# uncheck the "developer" checkbox in prefs/spotlight
rm -r /Applications/Xcode.app
```

- If for some reason rosetta doesn't get installed:
```sh
/usr/sbin/softwareupdate --install-rosetta --agree-to-license
```

- Haskell doesn't like Apple silicon, use x86 Homebrew -> x86 ghcup
