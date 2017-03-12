if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

"setl foldmethod=marker
"vnoremap <buffer><silent> <space>x "ty:call execute(@t)<cr>
"nnoremap <buffer><silent> <space>x :call execute(getline(line('.')))<cr>
nnoremap <buffer><silent> <F5> :w<cr>:so %<cr>
nnoremap <buffer> <F9> :breakadd here<cr>

nmap <buffer>g. <Plug>(GoToVimFun)

call dict#addl('viml', 'vimc')
