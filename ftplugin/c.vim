set fdm=syntax fdl=3

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

call dict#addl('c')

so <sfile>:h/cxx.vim
