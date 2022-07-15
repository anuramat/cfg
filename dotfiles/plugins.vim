" make sure vimplug is installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" subject to change:
call plug#begin('~/.vim/plugged')
    " major
    Plug 'nvim-telescope/telescope.nvim'            " fuzzy finder
    Plug 'nvim-lua/plenary.nvim'                    " required by telescope
    Plug 'scrooloose/nerdtree' " because netrw sucks
    " visual
    Plug 'ryanoasis/vim-devicons'                   " file icons
    Plug 'akinsho/bufferline.nvim', {'tag': 'v2.*'} " buffer line
    Plug 'lukas-reineke/indent-blankline.nvim'      " indentation lines
    Plug 'vim-airline/vim-airline'                  " status line
    Plug 'airblade/vim-gitgutter'                   " git signcolumn
    Plug 'flazz/vim-colorschemes'                   " a lot of themes
    Plug 'vim-airline/vim-airline-themes'           " airline themes
    " convenience
    Plug 'tpope/vim-fugitive'                       " !git -> :Git
    Plug 'windwp/nvim-autopairs'                    " auto pairing symbols
    Plug 'tomtom/tcomment_vim'                      " commenting on gc(c)
    " major junk
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " lsp, completion, etc
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " hl, fold, ind
    Plug 'metakirby5/codi.vim'                      " repl buffer
    " dependencies
call plug#end()


"                   binds
let mapleader=","
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>f :Telescope find_files<CR>
nnoremap <Leader>b :Telescope buffers<CR>
nnoremap <Leader>gd :GitGutterDiffOrig<CR>

"                   airline
let g:airline_powerline_fonts = 1 " XXX unicode fallback in ":h airline_custom"

"                   treesitter, telescope
lua << EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  auto_install = false,
  ignore_install = {"phpdoc"},
  highlight = { enable = true },
  indent = { enable = true, disable = {"python"} }
}
require("telescope").setup {}
require("nvim-autopairs").setup {}
require("bufferline").setup {}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"                   codi
let g:codi#interpreters = {'python':
            \{'bin': 'python3', 'prompt':'^\(>>>\|\.\.\.\) '}
            \}
