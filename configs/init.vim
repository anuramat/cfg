"                   plugins
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree' " file tree menu
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " lsp
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " hl, fold, ind
    Plug 'vim-airline/vim-airline' " status line
    Plug 'vim-airline/vim-airline-themes'
    Plug 'flazz/vim-colorschemes'
    Plug 'airblade/vim-gitgutter' " git status
    Plug 'ryanoasis/vim-devicons' " icons for nerdtree etc
call plug#end()

"                   search
set ignorecase              " case insensitive 
set smartcase               " except when query contains uppercase
set hlsearch                " highlight search 
set incsearch               " incremental search
  

"                   tabs/spaces
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed


"                   ui/visuals
syntax on                   " syntax highlighting
set showmatch               " matching bracket blinks when closed
set matchtime=1             " blink length
set number                  " add line numbers
set cursorline              " highlight current cursorline
" colorcolumn
set colorcolumn=80          " set an 80 column border for good coding style
set signcolumn=yes          " signcolumn (used by gitgutter and coc)
" colors
set background=dark
colorscheme molokai         " gruvbox is a good alt
let g:airline_theme='molokai'

"                   misc
set mouse=a                 " enable mouse
set clipboard=unnamedplus   " using system clipboard
set scrolloff=5             " soft vertical centering of the cursor
set updatetime=100          " ms before swap is written (used by gitgutter)
filetype plugin indent on   " all filetype features on
set smartindent             " XXX might conflict with something?
" backup and swap
set nobackup
set nowritebackup
set swapfile

"                   defaults XXX remove duplicates
set wildmenu                " cmd autocmp menu, vim: off
set wildoptions=pum,tagfile " vertical menu, show comp source symbol, vim: ""
set smarttab                " vim: off
set autoindent              " vim: off
set wildmode=full           " required for vertical menu, vim: on
set showcmd                 " vim: on, vi: off
set ttyfast                 " def (deprecated), vim: auto
set history=10000           " lines of history, vim: 50
set nolinebreak
" can be useful to change
set textwidth=0             " auto-newline after n+ chars and a whitespace
set wrapmargin=0            " moves cur word to newline when close to term edge
" set formatoptions= " XXX
set wrap


"                   binds
map <space> /
let mapleader=","
map <Leader><Leader> :NERDTreeToggle<CR>
" moving between windows XXX conflicts with search on space
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l 






"                   plugin settings boilerplate

" airline
let g:airline_powerline_fonts = 1
" if no powerline fonts: try unicode fallback in ":h airline_customization"


" treesitter settings
lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  auto_install = false,
  ignore_install = {"phpdoc"},
  highlight = { enable = true },
  indent = { enable = true }
}
EOF

" folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()


" coc XXX replace?
highlight CocFloating ctermbg=Black
let g:coc_global_extensions = ['coc-pyright', 'coc-go']
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
