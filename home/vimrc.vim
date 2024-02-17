"~~~~~~~~~~~~~~~~~~~~~~~~ imports ~~~~~~~~~~~~~~~~~~~~~~~~~"
unlet! skip_defaults_vim
so $VIMRUNTIME/defaults.vim
autocmd! vimHints
so $XDG_CONFIG_HOME/nvim/base.vim
"~~~~~~~~~~~~~~~~~~~~~~~~~~~ ui ~~~~~~~~~~~~~~~~~~~~~~~~~~~"
se hls " search
let &t_SI .= "\e[6 q" | let &t_SR .= "\e[4 q" | let &t_EI .= "\e[2 q" " cursor shape
se laststatus=2 " statusline in every window
"~~~~~~~~~~~~~~~~~ default nvim mappings ~~~~~~~~~~~~~~~~~~"
" sane yank
nn Y y$
" ^L does :noh
nn <c-l> <cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>
" readline breaks undo
ino <c-u> <c-g>u<c-u>
ino <c-w> <c-g>u<c-w>
" * search on selection
xn * y/\V<c-r>"<cr>
xn # y?\V<c-r>"<cr>
" repeat subs now remembers flags
nn & :&&<cr>
" not exactly like nvim but close enough
nn Q @q
"~~~~~~~~~~~~~~~~~~~~~~~~~~ paths ~~~~~~~~~~~~~~~~~~~~~~~~~"
cal mkdir(expand('~/.vim/view'), 'p')
cal mkdir(expand('~/.vim/undo'), 'p')
cal mkdir(expand('~/.vim/backup'), 'p')
cal mkdir(expand('~/.vim/swap'), 'p')
se udir=~/.vim/undo bdir=~/.vim/backup dir=~/.vim/swap vdir=~/.vim/view
"~~~~~~~~~~~~~~~~~~~~~~~~~~ misc ~~~~~~~~~~~~~~~~~~~~~~~~~~"
packadd! matchit
se autoindent autoread
se belloff=all " term bell
