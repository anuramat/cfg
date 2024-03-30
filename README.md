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
  - service.nix - syncthing paths

## Themes

### Terminal

- foot
- alacritty

- bat
- delta
- git
- ls/eza/fd
- zellij

### GUI

- mako
- qt5ct
- sway
- swaylock
- waybar
- zathura

TODO:

- gtk3
- gtk4
- qt6

### TODO

- themes: gtk,qt; cursors; icons
- tidy up bash stuff
