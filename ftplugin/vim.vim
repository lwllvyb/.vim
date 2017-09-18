set sw=4 sts=4 ts=4
if exists("b:did_myftplugin")|finish|endif
let b:did_myftplugin = 1

setl foldmethod=marker
"vnoremap <buffer><silent> <space>x "ty:call execute(@t)<cr>
"nnoremap <buffer><silent> <space>x :call execute(getline(line('.')))<cr>
nnoremap <buffer><silent> <F5> :w<cr>:so %<cr>
nnoremap <buffer> <F9> :breakadd here<cr>
imap <buffer><F5> <esc><F5>

vnoremap <buffer><m-o> yoechom <c-r>" \| call getchar()<esc>
nmap <buffer><m-o> viw<m-o>

if exists('g:popup_loaded')
    call popup#addl('goto', 'Goto',
            \['f', 'Function', "\<Plug>(GoToVimFun)"],
            \['d', 'Definition', "\<Plug>(GoToVimLet)"])
endif
