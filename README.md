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
- foot imports
- ripgrep global ignore
- nix
  - syncthing paths

## Themes

- alacritty
- bat
- delta
- foot
- git
- ls/eza
- mako
- qt5ct
- sway
- swaylock
- waybar

TODO:

- gtk3
- gtk4
- qt6
