
if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

nnoremap <F5> :call qrun#fasm()<cr>
imap <F5> <esc><F5>
