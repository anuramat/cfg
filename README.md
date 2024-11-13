# anuramat/cfg

Backup your config before proceeding, this will overwrite your stuff.

## Fresh install

```bash
nix-shell -p gnumake git
git clone git@github.com:anuramat/cfg
cd ~/cfg
make # will complain because of the hostname mismatch
cd /etc/nixos
sudo nixos-rebuild switch --flake .#hostname
cd ~/cfg
make install
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
```

## Structure

- `./config/*` - symlinked to `$XDG_CONFIG_HOME`
- `./home/*` - symlinked to `$HOME`
- `./nixos` - rsynced to `/etc/nixos` on `make`
- `./lib` - `make` scripts

## XDG Base Directory Specification

While I *tried* to keep it XDG compliant, it isn't always feasible. `rg XDGBDSV`
should show most of the problematic parts.

## Colors


### Terminal

`foot` is themed through a config, other terminals use sequences

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
- import as much as possible from profile.sh? stop sourcing profile.sh from
  bashrc
- clipboard persistence
- ripgreprc check globs
