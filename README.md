# anuramat/cfg

macOS zero to hero:
- install scripts
- packages
- configs

Assumes:
- default XDG paths
- default Apple Silicon Homebrew path (`/opt/homebrew/`)

## CLI 

Brewfile is somewhat bloated, comment out unwanted packages before installing.

```sh
# install git and stuff (might take some time)
xcode-select --install
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# clone this repo, create dev folder
cd && git clone https://github.com/anuramat/cfg && cd cfg
# install from Brewfile
brew analytics off
brew bundle install
# install config files and shiet
bash setup.sh
```

## GUI Preferences 

### Keyboard:
- Delete everything in "Text replacements..."  

### Trackpad/More Gestures:
- App Exposè - Swipe Down with Three Fingers
- Swipe between pages - Off

### Control Centre:
- Turn on battery percentage in menu bar

### TODO:
- Number format, time format

# Potential problems

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
