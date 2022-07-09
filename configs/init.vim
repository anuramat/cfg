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

" misc
set mouse=a                 " enable mouse
set clipboard=unnamedplus   " using system clipboard
set scrolloff=5             " soft vertical centering of the cursor
set updatetime=100          " period before swap is written (used by gitgutter)
set history=10000

" does this even change anything?
set wildmenu
" let mapleader=","
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allow auto-indenting depending on file type
filetype plugin on          " mandatory stuff
set ttyfast                 " Speed up scrolling in Vim

"                   plugin settings

" coc
highlight CocFloating ctermbg=Black
let g:coc_global_extensions = ['coc-pyright', 'coc-go']
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" nerdtree bind
map <C-b> :NERDTreeToggle<CR> " control+b to open nerdtree

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
