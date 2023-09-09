"~~~~~~~~~~~~~~~~~~~~~~~ formatting ~~~~~~~~~~~~~~~~~~~~~~~"
se sr sw=0 et ts=2
se tw=80 fo=qwj " add 'ro/' to prepend command leader on <cr>
"~~~~~~~~~~~~~~~~~~~~~~~~ visuals ~~~~~~~~~~~~~~~~~~~~~~~~~"
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
hi Normal guibg=NONE " transparent bg
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_winsize=25
"~~~~~~~~~~~~~~~~~~~~~~~~~~ misc ~~~~~~~~~~~~~~~~~~~~~~~~~~"
se noto
se kmp=russian-jcukenwin imi=0
" se spl=en,ru
se cot=menu,menuone,noselect,preview wop=fuzzy,pum
se nofen fdm=indent
se ic scs
se ut=100
se udf
se bdir-=.
se ve=block
se pa+=**
pa cfilter
se nf=bin,hex
se mouse=
"~~~~~~~~~~~~~~~~~~~~~~~~~ typos ~~~~~~~~~~~~~~~~~~~~~~~~~~"
com -bang Q q<bang>
com -bang W w<bang>
com -bang WQ wq<bang>
com -bang Wq wq<bang>
com -bang QA qa<bang>
com -bang Qa qa<bang>
"~~~~~~~~~~~~~~~~~~~ markdown ft plugin ~~~~~~~~~~~~~~~~~~~"
let g:markdown_fenced_languages = ['python', 'lua', 'vim', 'haskell', 'bash', 'sh', 'json5=json']
