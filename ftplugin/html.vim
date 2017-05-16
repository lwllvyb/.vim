if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

setl iskeyword+=-
setl sts=2 sw=2 ts=2

nnoremap <buffer><silent><F5> :up<cr>:OpenCurrent<cr>
imap <buffer><silent><F5> <esc><F5>
nmap <buffer><c-s><c-s> vatV>gvs
vmap <buffer><c-s> >gvs
