# anuramat/cfg

- Brew packages and Go binaries
- Configs/dotfiles
- macOS system preferences

```bash
xcode-select --install
cd && git clone https://github.com/anuramat/cfg && cd cfg
./setup.sh
```

## Manual setup
- Install fzf binding scripts (`brew info fzf`)
- Add "private" files if necessary (`fd -u private.example`)
- Keybinds in "System Settings"
- "Lock Screen" -> delays

## Structure
- `./config/*` - symlinked to `$XDG_CONFIG_HOME`
- `./home/*` - `$HOME`
- `./bin/**` - called by `setup.sh`; can be used standalone
- `./utils/**` - used by `setup.sh` and `./bin/**`
