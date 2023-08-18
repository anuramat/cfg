so $XDG_CONFIG_HOME/nvim/opts.vim
set nocompatible
call mkdir(expand('~/.vim/undo'), 'p')
call mkdir(expand('~/.vim/backup'), 'p')
call mkdir(expand('~/.vim/view'),'p')
call mkdir(expand('~/.vim/swap'), 'p')
se udir=expand('~/.vim/undo') bdir=expand('~/.vim/backup') vdir=expand('~/.vim/view') dir=expand('~/.vim/swap')
se bs=indent,eol,start
