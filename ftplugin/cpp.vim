set fdm=syntax fdl=3
set tabstop=4 sw=4

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

set complete=.,w,b,u,U,k,s,i,d

call dict#addl('c', 'cpp')

so <sfile>:h/c-like.vim
