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

Use `wallust run img.png` to set a wallpaper and generate a theme:
- `foot` is themed through a template config (for no particular reason), other 
  terminals use sequences.
- `/etc/bashrc` applies `dircolors`, so `LS_COLORS` is set there
- everything else is in the `wallust.toml`

## TODO

- put term name into a parameter to reference it in parts of the config maybe?
- waybar (maybe switch)
- swaylock
- something is writing LS_COLORS
- zellij
- gtk3 gtk4 qt5 qt6
- icons
- cursors
- import as much as possible from profile.sh? stop sourcing profile.sh from
  bashrc
- clipboard persistence
- ripgreprc check globs
