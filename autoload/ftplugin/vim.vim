
set sw=4 sts=4 ts=4 fdm=marker

let &fmr=' {{{, }}}'
set mps+=<:>

"vnoremap <buffer><silent> <space>x "ty:call execute(@t)<cr>
"nnoremap <buffer><silent> <space>x :call execute(getline(line('.')))<cr>
nnoremap <buffer><silent> <F5> :w<cr>:so %<cr>
nnoremap <buffer> <F9> :breakadd here<cr>
imap <buffer><F5> <esc><F5>

nnoremap <expr><buffer><c-j> (foldlevel('.') ? 'za': 'V}zfzc')
vnoremap <buffer><m-o> yoechom <c-r>" \| call getchar()<esc>
nmap <buffer><m-o> viw<m-o>

if exists('g:popup_loaded')
    call popup#addl('goto', 'Goto',
            \['f', 'Function', "\<Plug>(GoToVimFun)"],
            \['d', 'Definition', "\<Plug>(GoToVimLet)"])
endif
