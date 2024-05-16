# anuramat/cfg

> [!WARNING] backup your config before proceeding
>
> this will overwrite your stuff

## Fresh install

```bash
nix-shell -p gnumake git
git clone git@github.com:anuramat/cfg
cd cfg
make install
make # will complain because of the wrong hostname
cd /etc/nixos
sudo nixos-rebuild switch --flake .#hostname
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
```

## Structure

- `./config/*` - symlinked to `$XDG_CONFIG_HOME`
- `./home/*` - symlinked to `$HOME`
- `./nixos` - rsynced to `/etc/nixos` on `make`
- `./lib` - `make` scripts

## XDG base dir spec

non-compliant parts:

- alacritty imports (https://github.com/alacritty/alacritty/pull/7690)
- foot imports (https://codeberg.org/dnkl/foot/issues/1713)
- nix
  - service.nix - syncthing paths

## Colorschemes

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
- qt6ct
- sway
- swaylock
- waybar
- zathura

### TODO

- gtk2
- gtk3
- gtk4
- qt (verify colors, uniform theme)

## TODO

- icons
- cursors
- move nix packages around
- import as much as possible from profile.sh? stop sourcing profile.sh from
  bashrc
- clipboard persistence
- ripgreprc check globs
- maybe move latex templates to ~/Templates
