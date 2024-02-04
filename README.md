# anuramat/cfg
NixOS edition

```sh
./install.sh # home directory: .config/, dotfiles
./build.sh # configuration.nix
```

## Hier
- `./config/*` - symlinked to `$XDG_CONFIG_HOME`
- `./home/*` - symlinked to `$HOME`
- `./nixos` - mirrors `/etc/nixos`
