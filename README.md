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
```bash
xcode-select --install
cd && git clone https://github.com/anuramat/cfg && cd cfg
./setup.sh # install configs and prefs
```

## Post-install
- Get fzf binding scripts (`brew info fzf`)
- Add "private" file to `./config/git/`

## Preferences
- Delete everything in "Text replacements..." (TODO auto)
- Keybinds (TODO auto)
- "Lock Screen" / delays
