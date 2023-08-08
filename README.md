# anuramat/cfg

macOS zero to hero:
- Packages
- Configs
- macOS preferences

Assumes:
- Default XDG paths 
- Default Apple Silicon Homebrew path (`/opt/homebrew/`)

Before running anything:
- Modify install paths in `shell/profile.sh`
- Modify `setup.sh`, if you don't want to overwrite files automatically
- Comment out unwanted packages from `Brewfile`

## CLI 
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

## Keyboard settings:
- Delete everything in "Text replacements..."  
- Keybinds
