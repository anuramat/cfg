# anuramat/cfg

Requirements:
- NixOS v???
- Internet connection
- git

## Installation
```sh
./setup.sh
```

## Structure
- `./config/*` - symlinked to `$XDG_CONFIG_HOME`
- `./home/*` - symlinked to `$HOME`
- `./bin/**` - called by `setup.sh`; can be used standalone
- `./utils/**` - used by `setup.sh` and `./bin/**`
