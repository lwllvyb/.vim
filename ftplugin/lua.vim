if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

nnoremap <buffer> <silent> <F5> :w<cr>:!lua %:p<cr>
