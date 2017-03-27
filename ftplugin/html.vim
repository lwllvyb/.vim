set sts=4 sw=4 ts=4

if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

nnoremap <buffer><silent><F5> :up<cr>:OpenCurrent<cr>
imap <buffer><silent><F5> <esc><F5>
