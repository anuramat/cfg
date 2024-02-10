"~~~~~~~~~~~~~~~~~~~ source nvim config ~~~~~~~~~~~~~~~~~~~"
so $XDG_CONFIG_HOME/nvim/base.vim
"~~~~~~~~~~~~~~~~~~~~~~~~~~~ ui ~~~~~~~~~~~~~~~~~~~~~~~~~~~"
se is hls " search
let &t_SI .= "\e[6 q" | let &t_EI .= "\e[2 q" " cursor shape
se ru sc wmnu " bottom ui
filet plugin indent on | syn on " default plugins
se ls=2
hi VertSplit guibg=bg guifg=fg
"~~~~~~~~~~~~~~~~~ default nvim mappings ~~~~~~~~~~~~~~~~~~"
" sane yank behaviour
nn Y y$
" cls also removes highlight
nn <c-l> <cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>
" make readline hotkeys break undo
ino <c-u> <c-g>u<c-u>
ino <c-w> <c-g>u<c-w>
" search selection (to match */# in normal mode)
xn * y/\V<c-r>"<cr>
xn # y?\V<c-r>"<cr>
" repeat with the same flags
nn & :&&<cr>
nn Q <nop>
"~~~~~~~~~~~~~~~~~~~~~~~~~~ paths ~~~~~~~~~~~~~~~~~~~~~~~~~"
cal mkdir(expand('~/.vim/view'), 'p')
cal mkdir(expand('~/.vim/undo'), 'p')
cal mkdir(expand('~/.vim/backup'), 'p')
cal mkdir(expand('~/.vim/swap'), 'p')
se udir=~/.vim/undo bdir=~/.vim/backup dir=~/.vim/swap vdir=~/.vim/view
"~~~~~~~~~~~~~~~~~~~~~~~~~~ misc ~~~~~~~~~~~~~~~~~~~~~~~~~~"
packadd! matchit
se nolrm " legacy
se ttimeout ttm=50 " fix <escape> delay
se bs=indent,eol,start
se ai ar " autoindent autoread
se bo=all " stupid bell
se cpt=t,d,.,w,b,u,U,i " TODO test and move to nvim
