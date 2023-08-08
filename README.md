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
# devtools
xcode-select --install
# clone this
cd && git clone https://github.com/anuramat/cfg && cd cfg
# install packages
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
brew analytics off
brew bundle install
# install configs and prefs
./setup.sh
```

## Keyboard settings:
- Delete everything in "Text replacements..."  
- Keybinds
