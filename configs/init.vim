"------------------------------------------------------------------------------"
"                                                                              " 
"                           plugins                                            "
"                                                                              " 
"------------------------------------------------------------------------------"

" subject to change:
" dif file tree
" dif fuzzy finder
" coc -> native lsp ecosystem
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree' " file tree
    Plug 'nvim-lua/plenary.nvim' " required by telescope
    Plug 'nvim-telescope/telescope.nvim' " fuzzy finder
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " lsp, completion, etc
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " hl, fold, ind
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'flazz/vim-colorschemes'
    Plug 'airblade/vim-gitgutter'
    Plug 'akinsho/bufferline.nvim', {'tag': 'v2.*'} " tab line XXX
    Plug 'ryanoasis/vim-devicons' " file format icons and so on
    Plug 'metakirby5/codi.vim' " repl buffer
call plug#end()





"------------------------------------------------------------------------------"
"                                                                              " 
"                           native settings                                    "
"                                                                              " 
"------------------------------------------------------------------------------"

"                   search
set ignorecase              " case insensitive...
set smartcase               " ... except when query contains uppercase
set hlsearch                " highlight search 
set incsearch               " incremental search

"                   tabs/spaces
" autoindentation for most stuff is governed by filetype
" if noexpandtab: n * ' ' -> n div tabstop * \t + n mod tabstop * ' '
" smarttab uses ts value on the right, if sts is off
" motiv: ts for reading \t in plaintext, sw for indentation, sts for comments
set tabstop=4               " \t width
set shiftwidth=4            " autoindent/<</>> width
set softtabstop=4           " <Tab>/<BS> width; -1: sts=sw; 0: <Tab>=ts, <BS>=1
set expandtab               " insert spaces instead of spaces+tabs
set smarttab                " on: sts forced to sw in front of the line
set autoindent              " keep ind level on nl (mostly for plaintext)
set nosmartindent           " replaced by filetype
set nocindent               " replaced by filetype

"                   ui/visuals
syntax on                   " syntax highlighting
set showmatch               " matching bracket blinks when closed
set matchtime=1             " blink length, 0.1s
set number                  " enable line numbers
set cursorline              " highlight cursor line
set nocursorcolumn            " highlight cursor column
set laststatus=2            " statusline - always
"           columns
set colorcolumn=80          " set an 80 column border for good coding style
set signcolumn=yes          " signcolumn
"           colors
set background=dark
" colorscheme molokai "
" let g:airline_theme='molokai'
colorscheme gruvbox
let g:airline_theme='atomic'

"                   misc
set mouse=a                 " enable mouse
set clipboard=unnamedplus   " using system clipboard
set scrolloff=5             " soft vertical centering of the cursor
set updatetime=100          " ms before swap is written (used by gitgutter)
filetype plugin indent on   " all filetype features on
"           backup and swap
set nobackup
set nowritebackup
set swapfile
"           backspace behaviour
set backspace=eol,start,indent
"           command autocomplete
set wildmenu                " cmd autocmp menu
set wildoptions=pum         " make menu vertical
set wildmode=longest:full   " longest matching, full req by wildmenu
"           misc
set showcmd                 " defensive; vim: on, vi: off
set history=10000           " lines of history, vim: 50
set nolinebreak             " turns off breaking before end of screen
set encoding=utf-8          " defensive; vim: depends
"           can be useful to change for non-code
set textwidth=0             " auto-\n after n+ chars and a whitespace
set wrapmargin=0            " moves cur word to newline when close to term edge
set wrap                    " wrap long lines (without <CR>) 
set formatoptions=jcroql    " XXX





"------------------------------------------------------------------------------"
"                                                                              " 
"                           plugin settings                                    "
"                                                                              " 
"------------------------------------------------------------------------------"

"                   binds
let mapleader=","
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>f :Telescope find_files<CR>
nnoremap <Leader>b :Telescope buffers<CR>
nnoremap <Leader>gd :GitGutterDiffOrig<CR>
nnoremap <Leader>ce :CodiExpand<CR>
nnoremap <Leader>cn :CodiNew python<CR>

"                   airline
let g:airline_powerline_fonts = 1
" XXX if no powerline fonts: try unicode fallback in ":h airline_customization"

"                   treesitter, telescope
lua << EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  auto_install = false,
  ignore_install = {"phpdoc"},
  highlight = { enable = true },
  indent = { enable = true, disable = {"python"} }
}
require("telescope").setup()
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"                   coc
highlight CocFloating ctermbg=Black
let g:coc_global_extensions = ['coc-pyright', 'coc-go']
autocmd BufWritePre *.go :silent call CocAction('runCommand',
         \'editor.action.organizeImport')

"                   codi
let g:codi#interpreters = {'python':
            \{'bin': 'python3', 'prompt':'^\(>>>\|\.\.\.\) '}
\}
