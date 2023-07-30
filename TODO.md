# CFG TODO

- add fish locale to setup/config?
- verify mac defaults command for locale
- condarc and conda init in bashscript
- make utils more posix (lastarg, for loop)
- dump script for brewfile (merge?)
```bash
  cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w 50 | head -n 1

  conda config --set auto_activate_base false`
```

# nvim todo
- :norm
- recording
- double star, find vs edit
- C-x
- C-o 
- g.* commands
- default textobjects, mini.ai, matchit, []
- loclist usage
- way to properly delete global marks
- vimgrep

## configuration:
- check todo comments pattern

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

