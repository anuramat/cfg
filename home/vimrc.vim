so $XDG_CONFIG_HOME/nvim/opts.vim

colo sorbet " sorbet zaibatsu

call mkdir(expand('~/.vim/undo'), 'p')
call mkdir(expand('~/.vim/backup'), 'p')
call mkdir(expand('~/.vim/view'),'p')
call mkdir(expand('~/.vim/swap'), 'p')
se udir=~/.vim/undo bdir=~/.vim/backup vdir=~/.vim/view dir=~/.vim/swap
se bs=indent,eol,start
se ai ar
se bo=all
se cpt=t,d,.,w,b,u,U,i
