# anuramat/cfg

> [!WARNING] backup your config before proceeding
>
> this will overwrite your stuff

## Structure

- `./config/*` - symlinked to `$XDG_CONFIG_HOME`
- `./home/*` - symlinked to `$HOME`
- `./nixos` - rsynced to `/etc/nixos`
- `./lib` - `make` scripts

## XDG base dir spec

non-compliant parts:

- alacritty imports
- ripgrep global ignore
- nix
  - syncthing paths

## Themes

TODO list all the places that define a theme
