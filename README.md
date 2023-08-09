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

If you don't know/remember what some package does, it might be [here](packages.md)

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

## Manual prefs:
- Delete everything in "Text replacements..." (TODO)
- Keybinds (TODO)
- Wallpaper (TODO)
- Choose a screensaver (no point in setting up automatically)
- Lock Screen -> "Require password..." = "Immediately" (no chance of setting through defaults)
