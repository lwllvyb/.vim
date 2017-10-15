" set fdm=syntax fdl=3
set tabstop=4 sw=4

set isk=@,48-57,_,128-167,224-235
nmap <buffer><F5> :w<cr>:!node %<cr>

" syn region JsFold start="{" end="}" transparent fold
" syn sync fromstart
