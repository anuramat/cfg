" TODO: maybe remove bangs where not necessary?
"~~~~~~~~~~~~~~~~~~~~~ basic mappings ~~~~~~~~~~~~~~~~~~~~~"
let mapleader = " "
let maplocalleader = mapleader . ";"
tno <esc> <c-\><c-n>
nn <c-c> <silent><c-c>
nn <c-cr> o<esc>
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nn <silent> <leader>q :call ToggleQuickFix()<cr>
"" moving current line (conflicts with eg zellij)
"nnoremap <A-j> :silent m .+1<CR>:silent normal ==<cr>
"nnoremap <A-k> :silent m .-2<CR>:silent normal ==<cr>
"inoremap <A-j> <Esc>:silent m .+1<CR>:silent normal ==<cr>gi
"inoremap <A-k> <Esc>:silent m .-2<CR>:silent normal ==<cr>gi
"~~~~~~~~~~~~~~~~~~~~ formatting {{{1 ~~~~~~~~~~~~~~~~~~~~~"
se shiftround shiftwidth=0 expandtab tabstop=2
se textwidth=80 formatoptions=qwjr
"~~~~~~~~~~~~~~~~~~~~~~ general {{{1 ~~~~~~~~~~~~~~~~~~~~~~"
se complete=t,i,d,.,w,b,u,U " completion source priority
se clipboard=unnamedplus " unnamedplus for clipboard, unnamed for selection
se notimeout " no timeout on key sequences
se keymap=russian-jcukenwin imi=0 " cyrillic on i_^6
se completeopt=menu,menuone,noselect,preview " ins completion
se wildoptions=fuzzy,pum " cmd completion
se fen fdm=indent foldlevelstart=99 " overriden by fdl in modelines
se foldopen=insert,mark,quickfix,search,tag " maybe undo too?
se incsearch ignorecase smartcase " search settings
se updatetime=100 " period in ms for swap writes and CursorHold autocmd
se undofile " persistent undo
se backupdir-=. " don't write backups to CWD
se virtualedit=block " move beyond line end in v-block mode
pa cfilter
se nrformats=bin,hex,unsigned " ^a/^x number formats
let g:markdown_fenced_languages = ['python', 'lua', 'vim', 'haskell', 'bash', 'sh', 'json5=json', 'tex']
se synmaxcol=300
let g:matchparen_timeout=50
let g:matchparen_insert_timeout=50
" se spl=en,ru " spelling languages (russian will trigger download)
" se path+=** " recurse in path
" se shcf=-ic " use an interactive shell for "!" so that background jobs work
se mouse= " disable mouse
"~~~~~~~~~~~~~~~~~~~~~~ visuals {{{1 ~~~~~~~~~~~~~~~~~~~~~~"
se cole=0 " conceallevel
se nowrap
se fcs=fold:\─,foldopen:,foldsep:\ ,foldclose:
se foldtext=
se laststatus=3 " show only one statusline
se sbr=↪ list lcs=tab:│\ ,extends:❯,precedes:❮,trail:·,lead:·
au TextYankPost * silent! lua vim.highlight.on_yank()
se number relativenumber
se scrolloff=0
se report=0 shortmess=asWcCF " notification settings, I for intro
se cursorline cursorlineopt=line
se matchtime=1 showmatch " highlight matching bracket (deciseconds)
se signcolumn=yes " gutter
se tgc " 24-bit color
let g:border="solid" " read this from plugin configs; `:he nvim_open_win`
let g:nonfiles=['NeogitStatus', 'NeogitPopup', 'oil', 'lazy', 'lspinfo', 'null-ls-info', 'NvimTree', 'neo-tree', 'alpha', 'help']
if !exists("g:colors_name") " so that we can re-source without changing colorscheme
  try
    colo sorbet
  catch
    colo elflord
  endtry
endif
" pseudo-transparency, looks ugly with transparent bg
if has('nvim')
  " se winbl=30 " floating window transparency
  " se pb=30 " popup transparency
endif
se ph=20 " popup max height
" hi Normal guibg=NONE " transparent bg (guibg has nothing to do with gui)
let g:netrw_banner=0
" let g:netrw_liststyle=3 " tree style, symlinks are broken tho
let g:netrw_winsize=25
"~~~~~~~~~~~~~~~~~~~~~ commands {{{1 ~~~~~~~~~~~~~~~~~~~~~~"
""" Typos
com! -bang Q q<bang>
com! -bang W w<bang>
com! -bang WQ wq<bang>
com! -bang Wq wq<bang>
com! -bang Wqa wqa<bang>
com! -bang WQa wqa<bang>
com! -bang WQA wqa<bang>
com! -bang QA qa<bang>
com! -bang Qa qa<bang>

""" Hide qf buffers
augroup qf
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END

""" Use ripgrep by default
se grepprg=rg\ --vimgrep
se grepformat=%f:%l:%c:%m

""" Source everything
" breaks plenary
" let &shell='/usr/bin/env bash --login'

""" Open messages in a buffer
com! Messages call MessageBuffer()
function! MessageBuffer()
  let messages = execute('messages')
  execute 'enew'
  call setline(1, split(messages, "\n"))
  setlocal bufhidden=hide
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal nobuflisted
  setlocal nomodifiable
endfunction

""" Trim spaces
com! Trim %s/\ \+$//g

" vim: fdm=marker fdl=0
