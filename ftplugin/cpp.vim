set fdm=syntax fdl=3

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

set complete=.,w,b,u,U,k,s,i,d

call dict#addl('c', 'cpp')

nnoremap <buffer><F4> :call util#ToggleHeader()<cr>
inoremap {<cr> {<cr>}<esc>O
