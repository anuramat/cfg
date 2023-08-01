# CFG TODO

- add fish locale to setup/config?
- verify mac defaults command for locale
- condarc and conda init in bashscript
- make utils more posix (lastarg, for loop)
- dump script for brewfile (merge?)
- add some basic commands to rcs like "cfg push/pull"
- check if install_file can ever create a folder with basename of path
(== if install_file is always sane)
- keep a single file with stuff common for fish and bash
- configure fish prompt to resemble bash one

```bash
  cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w 50 | head -n 1

  conda config --set auto_activate_base false`
```

# nvim todo

## configuration:
- check todo comments pattern
- marks plugin mappings
- rename keymaps -> mappings
- remove repeat search on f/t
- fix format bug on markdown
- [LSP] Format request failed, no matching language servers.

## remove bloat:
- trouble vs bqf? too much overlap, also with telescope

## overkill:
- dap
- neotest
- go specific
- refactorings primeagen

# nvim notes:
```vim
" delete all buffers
:%bdelete
" delete global marks
:delmarks A-Z 
" turn on spellcheck
set spelling
```

