# anuramat/cfg

## Fresh install

Better to do it from the tty, since GUI stuff starts to fall apart:
```bash
nix-shell -p gnumake git
cd /etc
git clone git@github.com:anuramat/cfg ~/cfg
cd ~/cfg
make # will complain because of the hostname mismatch
sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)
make install
wallust theme random # (wrapped) wallust generates some configs
```

## Finishing touches

```bash
nvim # fetch plugins, install TS parsers
ssh-keygen # generate a key
gh auth login # set up github
# switch to ssh
git remote set-url origin git@github.com:anuramat/cfg
sudo tailscale up "--operator=$(whoami)" # set up tailscale
# etc: spotify, web browser, telegram, proton pass
```

## Structure

- `./config/*` - symlinked to `$XDG_CONFIG_HOME`
- `./home/*` - symlinked to `$HOME`
- `./nixos` - rsynced to `/etc/nixos` on `make`
- `./lib` - make deps

## XDG Base Directory Specification

`rg XDGBDSV` should show most of the violations.

## Notable hardcode

- Git repositories in `~/notes/` and `~/cfg/`
- Personal (`nixos/user.nix`, `rg -i 'anuramat|arsen`)
