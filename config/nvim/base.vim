"~~~~~~~~~~~~~~~~~~~~~ basic mappings ~~~~~~~~~~~~~~~~~~~~~"
let mapleader = " "
tnoremap <esc> <c-\><c-n>
xnoremap <leader>p "_dP
nnoremap <c-c> <silent><c-c>
"~~~~~~~~~~~~~~~~~~~~~~~~~~ cmds ~~~~~~~~~~~~~~~~~~~~~~~~~~"
com! KillAll :silent %bd|e#|bd#
" typos
"~~~~~~~~~~~~~~~~~~~~~~~ formatting ~~~~~~~~~~~~~~~~~~~~~~~"
se sr sw=0 et ts=2 " indentation (2 spaces)
se tw=80 fo=qwj " foramtting; add 'ro/' to prepend command leader on <cr>
"~~~~~~~~~~~~~~~~~~~~~~~~~~ misc ~~~~~~~~~~~~~~~~~~~~~~~~~~"
se noto " no timeout on key sequences
se kmp=russian-jcukenwin imi=0 " cyrillic on i_c^
se cot=menu,menuone,noselect,preview wop=fuzzy,pum " completion settings
se nofen fdm=indent " folds
se ic scs " smart case
se ut=100 " period in ms for swap writes and CursorHold autocmd
se udf " persistent undo
se bdir-=. " don't write backups to cwd
se ve=block " move beyond line end in v-block mode
pa cfilter " quickfix filter plugin
se nf=bin,hex,unsigned " ^a/^x number formats
let g:markdown_fenced_languages = ['python', 'lua', 'vim', 'haskell', 'bash', 'sh', 'json5=json']
" se spl=en,ru " spelling languages (russian will trigger download)
" se pa+=** " recurse in path
"~~~~~~~~~~~~~~~~~~~~~~~~ visuals ~~~~~~~~~~~~~~~~~~~~~~~~~"
se nowrap
se dy=lastline,uhex " XXX idk
se fcs=fold:\ ,foldopen:,foldsep:\ ,foldclose:
se ls=3 " show only one statusline
se sbr=↪ list lcs=tab:│·,extends:❯,precedes:❮,trail:·,lead:·
au TextYankPost * silent! lua vim.highlight.on_yank()
se nu rnu " relative line numbers
se so=0 " no scrolloff
se report=0 shm=asWIcCF " notification settings
se cul culopt=number
se mat=1 sm " highlight matching bracket (deciseconds)
se nosmd " turn off mode indicator in cmdline TODO add mode indicator to "fallback statusline"
se scl=yes " gutter
se tgc " 24-bit color
hi WinSeparator guibg=bg guifg=fg
" hi Normal guibg=NONE " transparent bg (guibg has nothing to do with gui)
if !exists("g:colors_name") " so that we can re-source without changing colorscheme
  try
    colo sorbet
  catch
    colo elflord
  endtry
endif
" pseudo-transparency, looks ugly with transparent bg
if has('nvim')
  se winbl=30 " floating window transparency
  se pb=30 " popup transparency
endif
se ph=20 " popup max height
" hi Normal guibg=NONE " transparent bg (guibg has nothing to do with gui)
let g:netrw_banner=0
" let g:netrw_liststyle=3 " tree style, symlinks are broken tho
let g:netrw_winsize=25
"~~~~~~~~~~~~~~~~~~~~~~~~~ typos ~~~~~~~~~~~~~~~~~~~~~~~~~~"
com! -bang Q q<bang>
com! -bang W w<bang>
com! -bang WQ wq<bang>
com! -bang Wq wq<bang>
com! -bang QA qa<bang>
com! -bang Qa qa<bang>


augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END
se smc=200 " max column to do syntax hl, might break entire file
let g:matchparen_timeout=50
let g:matchparen_insert_timeout=50


se cb=unnamedplus " unnamedplus for clipboard, unnamed for selection
