set fdm=syntax fdl=3
set tabstop=4 sw=4

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

call dict#addl('c')

so <sfile>:h/c-like.vim
