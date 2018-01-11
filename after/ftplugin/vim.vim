
set sw=4 sts=4 ts=4 fdm=marker

let &fmr=' {{{, }}}'
set mps+=<:>
set iskeyword&

"vnoremap <buffer><silent> <space>x "ty:call execute(@t)<cr>
"nnoremap <buffer><silent> <space>x :call execute(getline(line('.')))<cr>
nnoremap <buffer><silent> <F5> :update<cr>:so %<cr>
nnoremap <buffer><silent> <F2> :breakadd here<cr>
imap <buffer><F5> <esc><F5>

nnoremap <expr><buffer><c-j> (foldlevel('.') ? 'za': 'V}zfzc')

if exists('g:popup_loaded') && !exists('b:popup_menus')
    let b:popup_menus = {
        \ 'goto': {->pmenu#new('Goto',
                    \ ['f', 'Function', ":call vmode#goto_define()\<cr>"],
                    \ ['v', 'Variable', ":call vmode#search_var('\<c-r>\<c-w>')\<cr>"],
                    \).merge(pmenu#common#goto())},
        \ 'util': {->pmenu#new('Util',
                    \ ['e', 'Echo ...', "viwyoechom \<c-r>\" | call getchar()\<esc>"],
                    \ ).merge(pmenu#util#n())},
        \ }
endif
