set fdm=syntax fdl=3
set tabstop=4 sw=4

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

set isk=@,48-57,_,128-167,224-235
nmap <buffer><F5> :w<cr>:!node %<cr>

call dict#addl('nodejs')
