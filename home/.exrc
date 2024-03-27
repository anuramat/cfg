" nvi 

" skip comment block at the top when opening a file
se comment

" show cursor position at the bottom of the screen
se ruler
se number
se showmode
" show e v e r y t h i n g
se nolist

se cedit=
se filec=


se tildeop
" doesn't work in nvi
" se modelines

" highlight matching bracket on insert
se showmatch
se matchtime=1

" soft wrapping
se noleftright
" hard wrap (max line length)
se wraplen=80
"~~~~~~~~~~~~~~~~~~~~~~~~~ search ~~~~~~~~~~~~~~~~~~~~~~~~~"
" egrep style regexes
se noextended 
" ignore case
se ignorecase
" wrap searches
se wrapscan
" smart case regex
se iclower
" incremental search
se searchincr
"~~~~~~~~~~~~~~~~~~~~~~~~~ indent ~~~~~~~~~~~~~~~~~~~~~~~~~"
se autoindent
" indentation width for autoindent and </>
se shiftwidth=4
" visual size of a real tab
se tabstop=4
" real tab visual size
se hardtabs=4

