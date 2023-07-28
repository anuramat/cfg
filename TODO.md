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

# nvim 

## problems
- lazyload markdown preview 
- cancel completion on c-f in cmdline
- luasnip binds
- harpoon go-to-nth

## configure better
- treesitter move/swap/etc
- loclist, quickfix bindings, learn how to use
- trouble vs bqf vs telescope vs lspsaga? too much overlap

## editor stuff:
- harpoon? or maybe marks are enough?
- ufo for folds!

## ide stuff:
- dap
- neotest
- go specific
- refactorings primeagen?

## notes:
```vim
" delete all buffers
:%bdelete
" delete global marks
:delmarks A-Z 
```

