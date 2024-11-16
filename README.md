# anuramat/cfg

## Fresh install

Better to do it from the tty, since GUI stuff starts to fall apart:
```bash
nix-shell -p gnumake git
git clone git@github.com:anuramat/cfg ~/cfg
cd ~/cfg
# will complain because of the hostname mismatch
make
sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)
make install
# without this some stuff might be broken
wallust theme base16-nord
```

## Finishing touches

```bash
# generate a key
ssh-keygen
# *add the key to gh*
# switch to ssh for the cfg repo
git remote set-url origin git@github.com:anuramat/cfg
# makes eg "nix-shell -p" use unstable
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
```

- change git creds
- set up your machine in flake.nix

## Structure

- `./config/*` - symlinked to `$XDG_CONFIG_HOME`
- `./home/*` - symlinked to `$HOME`
- `./nixos` - rsynced to `/etc/nixos` on `make`
- `./lib` - `make` scripts

## XDG Base Directory Specification

While I *tried* to keep it XDG compliant, it isn't always feasible. `rg XDGBDSV`
should show most of the problematic parts.

## Colors

Use `r`, which is a `wallust` wrapper with some additional logic:
- `foot` is themed through the config, other terminals use sequences.
- `/etc/bashrc` applies `dircolors`, so `LS_COLORS` is set there

## TODO

- gtk3 gtk4 qt5 qt6
- icons
- cursors
- import as much as possible from profile.sh? stop sourcing profile.sh from
  bashrc
- clipboard persistence
- ripgreprc check globs
