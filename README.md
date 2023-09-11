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
- `./configuration.nix`

## Misc
- put [apropos](https://nixos.wiki/wiki/Apropos) where it belongs
- TODO figure out how to get unstable packages declaratively
- TODO get dracula for fd and kitty 
