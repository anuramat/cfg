" search stuff
set ignorecase              " case insensitive 
set hlsearch                " highlight search 
set incsearch               " incremental search


" tabs stuff
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed


" visual flair
syntax on                   " syntax highlighting
set showmatch               " hl matching bracket when closing
set number                  " add line numbers
set cursorline              " highlight current cursorline
set bg=dark
" cc
set cc=80                   " set an 80 column border for good coding style
highlight ColorColumn ctermbg=DarkGrey " cc color
" sc 
set signcolumn=yes " signcolumn (used by gitgutter and coc)
set updatetime=100 " period before swap is written (used by gitgutter)
highlight SignColumn ctermbg=Black


" misc
set mouse=a                 " enable mouse
set clipboard=unnamedplus   " using system clipboard


" does this even change anything?
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on  " allow auto-indenting depending on file type
filetype plugin on          " mandatory stuff
set ttyfast                 " Speed up scrolling in Vim


call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree' " file tree menu
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " lsp
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " hl, fold, ind
    Plug 'vim-airline/vim-airline' " status line
    Plug 'airblade/vim-gitgutter' " git status
    Plug 'ryanoasis/vim-devicons' " icons for nerdtree etc
call plug#end()


" coc
highlight CocFloating ctermbg=Black
let g:coc_global_extensions = ['coc-pyright', 'coc-go']
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')


" nerdtree
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
