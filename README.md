# anuramat/cfg

macOS zero to hero:
- Install scripts
- Packages
- Configs
- macOS preferences

Assumes:
- default XDG paths 
- default Apple Silicon Homebrew path (`/opt/homebrew/`)
Paths are configured in `shell/profile.sh`

`setup.sh` **overwrites without prompt*** files in `$XDG_CONFIG_HOME` with symlinks to files in `./config`

## CLI 

Brewfile is somewhat bloated, **comment out unwanted packages before installing**.

```sh
# install git and stuff (takes some time)
xcode-select --install
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# clone this
cd && git clone https://github.com/anuramat/cfg && cd cfg
# install packages from Brewfile
brew analytics off
brew bundle install
# remember to restart afterwards
./setup.sh
```

## GUI Preferences 

### Keyboard:
- Delete everything in "Text replacements..."  
- Keybinds

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
