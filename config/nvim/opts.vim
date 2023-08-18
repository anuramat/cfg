"~~~~~~~~~~~~~~~~~~~~~~~ formatting ~~~~~~~~~~~~~~~~~~~~~~~"
se sr sw=0 et ts=2
se tw=80 fo=qwj " add 'ro/' to prepend command leader on <cr>
"~~~~~~~~~~~~~~~~~~~~~~~~ visuals ~~~~~~~~~~~~~~~~~~~~~~~~~"
" se cul
se nowrap
se dy=lastline,uhex
se fcs=fold:\ ,foldopen:,foldsep:\ ,foldclose:
se ls=3
se sbr=↪
se list
se lcs=tab:❮·❯,extends:❯,precedes:❮,trail:·,lead:·
au TextYankPost * silent! lua vim.highlight.on_yank()
se mat=1
se nu rnu
se so=0
se report=0 shm=asWIcCF
se sm
se nosmd
se scl=yes
se tgc
colo sorbet
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_winsize=25
"~~~~~~~~~~~~~~~~~~~~~~~~~~ misc ~~~~~~~~~~~~~~~~~~~~~~~~~~"
" set noto ttimeout ttm=50
se kmp=russian-jcukenwin imi=0
" se spl=en,ru
se cot=menuone,noselect wop=fuzzy,pum
se nofen fdm=indent
se ic scs
se ut=100
se udf
se bdir-=.
se ve=block
se pa+=**
pa cfilter
se nf=bin,hex
"~~~~~~~~~~~~~~~~~~~~~~~~~ diffs ~~~~~~~~~~~~~~~~~~~~~~~~~~"
if !has('nvim')
  se udir=expand('~/.vimundo')
endif
