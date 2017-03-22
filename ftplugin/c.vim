set fdm=syntax fdl=3

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

call dict#addl('c')

nnoremap <buffer><F4> :call util#ToggleHeader()<cr>
inoremap {<cr> {<cr>}<esc>O
