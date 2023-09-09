"~~~~~~~~~~~~~~~~~~~~~~~ formatting ~~~~~~~~~~~~~~~~~~~~~~~"
se sr sw=0 et ts=2 " indentation (2 spaces)
se tw=80 fo=qwj " foramtting; add 'ro/' to prepend command leader on <cr>
"~~~~~~~~~~~~~~~~~~~~~~~~ visuals ~~~~~~~~~~~~~~~~~~~~~~~~~"
se nowrap
se dy=lastline,uhex " XXX idk
se fcs=fold:\ ,foldopen:,foldsep:\ ,foldclose:
se ls=3 " show only one statusline
se sbr=↪ list lcs=tab:❮·❯,extends:❯,precedes:❮,trail:·,lead:·
au TextYankPost * silent! lua vim.highlight.on_yank()
se nu rnu " relative line numbers
se so=0 " no scrolloff
se report=0 shm=asWIcCF " notification settings
se mat=1 sm " highlight matching bracket (deciseconds)
se nosmd " turn off mode indicator in cmdline TODO add mode indicator to fallback statusline
se scl=yes " gutter
se tgc " 24-bit color
try
  colo sorbet
catch
endtry
try
  " pseudo-transparency, looks ugly with transparent bg
  se winbl=0 " floating window transparency
  se pb=30 " popup transparency
catch
endtry
se ph=20 " popup max height
" hi Normal guibg=NONE " transparent bg (guibg has nothing to do with gui)
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_winsize=25
"~~~~~~~~~~~~~~~~~~~~~~~~~~ misc ~~~~~~~~~~~~~~~~~~~~~~~~~~"
se noto " no timeout on key sequences
se kmp=russian-jcukenwin imi=0 " cyrillic on i_c^
" se spl=en,ru " spelling languages (russian will trigger download)
se cot=menu,menuone,noselect,preview wop=fuzzy,pum " completion settings
se nofen fdm=indent " folds
se ic scs " smart case
se ut=100 " period in ms for swap writes and CursorHold autocmd 
se udf " persistent undo
se bdir-=. " don't write backups to cwd
se ve=block " move beyond line end in v-block mode
" se pa+=** " recurse in path
pa cfilter " quickfix filter plugin
se nf=bin,hex,unsigned " ^a/^x number formats
"~~~~~~~~~~~~~~~~~~~~~~~~~ typos ~~~~~~~~~~~~~~~~~~~~~~~~~~"
com! -bang Q q<bang>
com! -bang W w<bang>
com! -bang WQ wq<bang>
com! -bang Wq wq<bang>
com! -bang QA qa<bang>
com! -bang Qa qa<bang>
"~~~~~~~~~~~~~~~~~~~ markdown ft plugin ~~~~~~~~~~~~~~~~~~~"
let g:markdown_fenced_languages = ['python', 'lua', 'vim', 'haskell', 'bash', 'sh', 'json5=json']
