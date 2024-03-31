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
- regreet config and wallpaper location
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
- check if all neovim stuff is used
- move nix packages around
- clear sway.nix
- import as much as possible from profile.sh? stop sourcing profile.sh from
  bashrc
- clipboard persistence

### Problems

- regreet takes time to load the theme https://github.com/rharish101/ReGreet/issues/45
