set fdm=syntax fdl=3
set tabstop=4 sw=4

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

nmap <buffer><F5> :w<cr>:!node %<cr>

call dict#addl('nodejs')

so <sfile>:h/cxx.vim
