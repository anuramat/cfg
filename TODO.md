# CFG TODO

- add fish locale to setup/config?
- verify mac defaults command for locale
- condarc and conda init in bashscript
- make utils more posix (lastarg, for loop)
- dump script for brewfile (merge?)
- master/slave file to not mess up brewfile
```bash
  cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w 50 | head -n 1

  conda config --set auto_activate_base false`
```

# nvim rice

## configuration:
- lazyload markdown preview 
- luasnip binds
- treesitter move/swap/etc
- loclist, quickfix bindings

## must have:
- ufo for folds!
- undotree

## remove bloat:
- trouble vs bqf vs telescope vs lspsaga? too much overlap

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
```

