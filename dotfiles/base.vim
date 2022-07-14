"                   search
set ignorecase              " case insensitive...
set smartcase               " ... except when query contains uppercase
set hlsearch                " highlight search 
set incsearch               " incremental search
set wrapscan              " search wraps around

"                   tabs/spaces
" autoindentation for most stuff is governed by filetype
" if noexpandtab: n * ' ' -> n div tabstop * \t + n mod tabstop * ' '
" smarttab uses ts value on the right, if sts is off
" motiv: ts for reading \t in plaintext, sw for indentation, sts for comments
set tabstop=4               " \t width
set shiftwidth=4            " autoindent/<</>> width
set softtabstop=4           " <Tab>/<BS> width; -1: sts=sw; 0: <Tab>=ts, <BS>=1
set expandtab               " insert spaces instead of spaces+tabs
set smarttab                " on: sw instead of (s)ts used in front of the line
set autoindent              " keep ind level on nl (mostly for plaintext)
set shiftround              " round indents to multiples of shiftwidth
set nosmartindent           " replaced by filetype
set nocindent               " replaced by filetype
"                   ui/visuals
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse
set showmatch               " matching bracket blinks when closed
set matchtime=1             " blink length, 0.1s
set scrolloff=5             " soft vertical centering of the cursor
set showcmd                 " defensive; vim: on, vi: off
set noshowmode              " don't show mode in cmdline (cuz airline)
set shortmess+=c            " TODO wtf
set termguicolors           " truecolor
set list                    " show some whitespace as defined by listchars:
set splitbelow
set splitright
set nostartofline             " move to line start on big moves
set report=0                " always report changed lines
set display=lastline,uhex   " alwys shw wrpped lnes, shw unprntble chrs unicode
if has('multi_byte') && &encoding ==# 'utf-8'
    set listchars=tab:│+,extends:❯,precedes:❮,nbsp:+,trail:·,lead:·
    set showbreak=\ ↪\ 
else
    set listchars=tab:\|->,extends:>,precedes:<,nbsp:+,trail:.,lead:.
endif
set ttyfast                 " faster redrawing
set nolazyredraw            " turn on for frequent macros
set redrawtime=2000         " increase if syntax hl is slow on large files
set synmaxcol=0             " line length limit for syntax hl
"           elements
set cmdheight=1             " command line
set cursorline              " cursor line
set nocursorcolumn          " cursor column
set laststatus=2            " statusline - always
set ruler                   " cursor position on built-in statusline
set number                  " number column
set colorcolumn=80          " right column
if has("nvim-0.5.0") || has("patch-8.1.1564")
    set signcolumn=number   " merges number column with signcolumn
else
    set signcolumn=yes
endif

"           command autocomplete
set wildmenu                " cmd autocmp menu
if has("nvim")
    set wildoptions=pum         " make menu vertical
endif
set wildmode=longest:full   " longest matching, full req by wildmenu
"           colors
set tgc
set background=dark
try
    colorscheme molokai
catch
    colorscheme default
endtry
let g:airline_theme='molokai'

"                   misc
" set nrformats=hex,octal,bin " XXX 0x1, 01, 0b - number formats for incrementing
set clipboard=unnamedplus   " using system clipboard
filetype plugin indent on   " all filetype features on
set hidden                  " TODO wtf
set backspace=eol,start,indent

"           backup and swap
set history=10000           " lines of history, vim: 50
set updatetime=100          " ms period for swap writes and some plugins runs
set nobackup                " XXX backups conflict with some language servers
set nowritebackup           " XXX same
set noswapfile              " XXX might be useful
set noautowrite             " XXX same
set noundofile              " TODO ?? 
"           misc
set nolinebreak             " turns off breaking before end of screen
set encoding=utf-8          " defensive; vim: depends
"           can be useful to change for non-code TODO
set textwidth=0             " auto-\n after n+ chars and a whitespace
set wrapmargin=0            " moves cur word to newline when close to term edge
set wrap                    " wrap long lines (without <CR>) 
set formatoptions=jcroql    " TODO change for comments/plaintext



let mapleader=","
