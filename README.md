# anuramat/cfg

Requirements:
- NixOS v???
- Internet connection
- git

## Installation
```sh
./setup.sh
```

## Files
- `./config/*` - symlinked to `$XDG_CONFIG_HOME`
- `./home/*` - symlinked to `$HOME`
- `./configuration.nix` - TODO install from setup.sh to `/etc/nixos/configuration.nix`

## Misc
- put [apropos](https://nixos.wiki/wiki/Apropos) where it belongs
- TODO get dracula for fd/exa/kitty
- TODO add scripts from `$HOME/bin`
